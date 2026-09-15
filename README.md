
## Быстрый старт приложения
```
1. создаем .env из шаблона внутри
cp .env.example .env
2. поднимаем приложение + базу
docker compose up -d
3. Проверяем curl'ом работоспособность приложения и бд
curl localhost:8000/healthz
curl localhost:8000/readyz
```


## По поводу измененных файлов

1. **Dockerfile**
- легковесный образ alpine как бестпрактис
- multi-stage build для копирования во вторую стадию только пакеты pip'а
- rootless_user
- ENV PYTHONUNBUFFERED=1 для вывода логов в docker logs
- graceful shutdown для того, чтоб PID 1 получал сигнал и прекращал принимать новые соединения, но дорабатывал активные запросы
2. **Docker-compose**
  - depends_on + helthcheks для того, чтоб не крашился с ошибкой при запуске и можно было проверить БД и приложение ( в кубере можно реализовать через initContainers для BD и прописать helthчеки в readinessProbe и livenessProbe )
  - все секреты через переменные
