import os
from fastapi import FastAPI
from fastapi.responses import JSONResponse

def load_env(path: str = ".env") -> None:
    if not os.path.exists(path):
        return

    with open(path, "r", encoding="utf-8") as env_file:
        for raw_line in env_file:
            line = raw_line.strip()

            if not line:
                continue

            if line.startswith("#"):
                continue

            if "=" not in line:
                continue

            key, value = line.split("=", 1)
            os.environ.setdefault(key, value)

load_env()

app = FastAPI(title=os.getenv("APP_NAME", "reliability_lab"))

@app.get("/")
def root() -> JSONResponse:
    return JSONResponse(
        { "project": os.getenv("APP_NAME", "reliability_lab"),
            "env": os.getenv("APP_ENV", "dev"),
            "status": "ok", }
    )

@app.get("/health")
def health() -> JSONResponse:
    return JSONResponse({"status": "healthy"})

@app.get("/version")
def version() -> JSONResponse:
    return JSONResponse({"version": os.getenv("APP_VERSION", "0.1.0")})