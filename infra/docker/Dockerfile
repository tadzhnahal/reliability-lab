from python:3.12-slim
workdir /workspace
copy app /workspace/app
copy .env.example /workspace/.env
run pip install --no-cache-dir -r /workspace/app/requirements.txt
cmd ["uvicorn", "app.src.main:app", "--host", "0.0.0.0", "--port", "8000"]
