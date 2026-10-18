from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
WEB = ROOT / "web"
RESULT = ROOT / ".superpowers" / "sdd" / "2026-10-15-flutter-web-offline" / "smoke-result.txt"


class SmokeHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(WEB), **kwargs)

    def do_POST(self):
        if self.path != "/result":
            self.send_error(404)
            return
        length = int(self.headers.get("Content-Length", "0"))
        RESULT.write_bytes(self.rfile.read(length))
        self.send_response(204)
        self.end_headers()


if __name__ == "__main__":
    ThreadingHTTPServer(("127.0.0.1", 8081), SmokeHandler).serve_forever()
