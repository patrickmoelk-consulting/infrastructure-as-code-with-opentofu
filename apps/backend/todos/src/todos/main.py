from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .todos import router

app = FastAPI(root_path="/api")

origins = []

app.add_middleware(CORSMiddleware, allow_origins=origins)
app.include_router(router, prefix="/todos")


@app.get("/")
def get_root():
    return "Hello, world!"
