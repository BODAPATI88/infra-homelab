from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from fastapi.responses import JSONResponse
from app.k8s_client import get_nodes, get_pods, get_namespaces

app = FastAPI(title="BVRINFRA Platform")

app.mount("/static", StaticFiles(directory="app/static"), name="static")

templates = Jinja2Templates(directory="app/templates")
@app.get("/", response_class=HTMLResponse)
async def home(request: Request):

    nodes = get_nodes()
    pods = get_pods()
    namespaces = get_namespaces()

    cluster_health = "Healthy"

    if pods["failed"] > 0:
        cluster_health = "Degraded"

    context = {
        "request": request,
        "title": "BVRINFRA Platform",

        # Live telemetry
        "cluster_nodes": len(nodes),
        "cluster_health": cluster_health,
        "gitops": "Healthy",
        "observability": "Active",

        "pod_total": pods["total"],
        "pod_running": pods["running"],
        "pod_failed": pods["failed"],

        "namespace_count": len(namespaces),

        # Full live datasets
        "nodes": nodes,
        "namespaces": namespaces,
    }

    return templates.TemplateResponse(
        request=request,
        name="index.html",
        context=context,
    )
@app.get("/api/nodes")
def api_nodes():
    return JSONResponse(content=get_nodes())


@app.get("/api/pods")
def api_pods():
    return JSONResponse(content=get_pods())


@app.get("/api/namespaces")
def api_namespaces():
    return JSONResponse(content=get_namespaces())

@app.get("/status", response_class=HTMLResponse)
async def status(request: Request):

    context = {
        "request": request,
        "title": "Platform Status",
    }

    return templates.TemplateResponse(
        request=request,
        name="status.html",
        context=context,
    )
@app.get("/architecture", response_class=HTMLResponse)
async def architecture(request: Request):

    context = {
        "request": request,
        "title": "Architecture",
    }

    return templates.TemplateResponse(
        request=request,
        name="architecture.html",
        context=context,
    )
@app.get("/incidents", response_class=HTMLResponse)
async def incidents(request: Request):

    context = {
        "request": request,
        "title": "Incidents",
    }

    return templates.TemplateResponse(
        request=request,
        name="incidents.html",
        context=context,
    )
@app.get("/operations", response_class=HTMLResponse)
async def operations(request: Request):

    context = {
        "request": request,
        "title": "Operations",
    }

    return templates.TemplateResponse(
        request=request,
        name="operations.html",
        context=context,
)
@app.get("/documentation", response_class=HTMLResponse)
async def docs(request: Request):

    context = {
        "request": request,
        "title": "Documentation",
    }

    return templates.TemplateResponse(
        request=request,
        name="docs.html",
        context=context,
    )
