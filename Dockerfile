# syntax=docker/dockerfile:1
FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /netguardian_web
COPY requirements.txt /netguardian_web/
RUN pip install -r requirements.txt
COPY /netguardian_web /netguardian_web/
EXPOSE 8000
CMD python manage.py runserver 0.0.0.0:8000