from fastapi import FastAPI

app = FastAPI(root_path="/api")

@app.get("/")
def get_root():
  return "Hello, world!"
