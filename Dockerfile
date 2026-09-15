# Первый стейдж + использую легковесный образ Python
FROM python:3.13-slim AS builder


# ставлю зависимости
WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt



#Второй стейдж + добавляю stdout для логов

FROM python:3.13-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app
#Без кэша и pip'a
COPY --from=builder /install /usr/local
#Само приложение
COPY . .
#Rootless Пользователь
RUN useradd --system --no-create-home rootless_user

USER rootless_user

EXPOSE 8000
#graceful shutdown
STOPSIGNAL SIGTERM
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

