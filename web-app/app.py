from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

app = FastAPI(root_path="/web-app")

# Mount static files for CSS and JS (same as before)
# Must be mounted _after_ the router or static routes will override api routes
app.mount("/", StaticFiles(directory="build", html=True), name="build")
