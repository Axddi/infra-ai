FROM python:3.10-slim

WORKDIR /app

COPY app/backend/requirements.txt .
COPY app/backend/src/ ./src/

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "src/main.py"]