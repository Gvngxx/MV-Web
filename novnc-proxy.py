#!/usr/bin/env python3
import http.server
import socketserver
import urllib.request
from urllib.parse import urlparse
import os

PORT = 5000
NOVNC_PORT = 5001
INTRO_HTML = "/usr/local/share/intro.html"

class ProxyHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Serve intro page for root path
        if self.path == '/' or self.path == '/index.html':
            try:
                with open(INTRO_HTML, 'rb') as f:
                    content = f.read()
                self.send_response(200)
                self.send_header('Content-type', 'text/html')
                self.send_header('Content-Length', str(len(content)))
                self.end_headers()
                self.wfile.write(content)
                return
            except Exception as e:
                self.send_error(500, f"Error serving intro: {e}")
                return
        
        # Proxy all other requests to easy-novnc
        try:
            url = f'http://localhost:{NOVNC_PORT}{self.path}'
            with urllib.request.urlopen(url, timeout=10) as response:
                self.send_response(response.status)
                for header, value in response.headers.items():
                    if header.lower() not in ['connection', 'keep-alive', 'transfer-encoding']:
                        self.send_header(header, value)
                self.end_headers()
                self.wfile.write(response.read())
        except Exception as e:
            self.send_error(502, f"Error proxying to noVNC: {e}")

    def do_POST(self):
        # Proxy POST requests to easy-novnc
        try:
            url = f'http://localhost:{NOVNC_PORT}{self.path}'
            content_length = int(self.headers.get('Content-Length', 0))
            body = self.rfile.read(content_length) if content_length > 0 else b''
            
            req = urllib.request.Request(url, data=body, method='POST')
            for header, value in self.headers.items():
                if header.lower() not in ['host', 'connection', 'keep-alive']:
                    req.add_header(header, value)
            
            with urllib.request.urlopen(req, timeout=10) as response:
                self.send_response(response.status)
                for header, value in response.headers.items():
                    if header.lower() not in ['connection', 'keep-alive', 'transfer-encoding']:
                        self.send_header(header, value)
                self.end_headers()
                self.wfile.write(response.read())
        except Exception as e:
            self.send_error(502, f"Error proxying to noVNC: {e}")

if __name__ == '__main__':
    with socketserver.TCPServer(("", PORT), ProxyHandler) as httpd:
        print(f"Proxy server running on port {PORT}")
        print(f"Proxying to noVNC on port {NOVNC_PORT}")
        httpd.serve_forever()
