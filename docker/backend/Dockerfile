FROM python:3.10-slim

WORKDIR /app

COPY app/backend/requirements.txt .
RUN pip install -r requirements.txt

COPY app/backend .

CMD ["python", "app.py"]