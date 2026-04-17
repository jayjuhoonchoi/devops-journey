from http.server import HTTPServer, BaseHTTPRequestHandler

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        html = """
        <!DOCTYPE html>
        <html>
        <head><title>DevOps Journey</title></head>
        <body style="font-family:sans-serif;text-align:center;padding:50px;background:#1a1a2e;color:white">
          <h1>🚀 DevOps Journey</h1>
          <h2>Jay Choi | Melbourne</h2>
          <p>Auto-deployed via GitHub Actions!</p>
          <p>Version: 1.0.0</p>
        </body>
        </html>
        """
        self.wfile.write(html.encode())
    def log_message(self, format, *args):
        pass

if __name__ == '__main__':
    print("Server starting on port 5000...")
    HTTPServer(('0.0.0.0', 5000), Handler).serve_forever()
