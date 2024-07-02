# Используем базовый образ с Python

FROM python:3.8

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы requirements.txt в контейнер
COPY requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем все остальные файлы в рабочую директорию
COPY . .

# Указываем переменную окружения для Flask
ENV FLASK_APP=bootstrap.py

# Указываем команду для запуска Flask-приложения
CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]

# Открываем порт для приложения
EXPOSE 80
