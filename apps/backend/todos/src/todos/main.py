from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(root_path="/api")

origins = [
  "http://localhost:5173",
  "http://localhost:9999",
]

app.add_middleware(CORSMiddleware, allow_origins = origins)

@app.get("/")
def get_root():
  return "Hello, world!"
