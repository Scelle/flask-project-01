# CD/CI Tutorial Sample Application

## Description

This sample Python REST API application was written for a tutorial on implementing Continuous Integration and Delivery pipelines.

It demonstrates how to:

 * Write a basic REST API using the [Flask](http://flask.pocoo.org) microframework
 * Basic database operations and migrations using the Flask wrappers around [Alembic](https://bitbucket.org/zzzeek/alembic) and [SQLAlchemy](https://www.sqlalchemy.org)
 * Write automated unit tests with [unittest](https://docs.python.org/2/library/unittest.html)

Related article: https://medium.com/rockedscience/docker-ci-cd-pipeline-with-github-actions-6d4cd1731030

## Requirements

 * `Python 3.8`
 * `Pip`
 * `virtualenv`, or `conda`, or `miniconda`

The `psycopg2` package does require `libpq-dev` and `gcc`.
To install them (with `apt`), run:

```sh
$ sudo apt-get install libpq-dev gcc
```

## Installation

With `virtualenv`:

```sh
$ python -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt
```

With `conda` or `miniconda`:

```sh
$ conda env create -n ci-cd-tutorial-sample-app python=3.8
$ source activate ci-cd-tutorial-sample-app
$ pip install -r requirements.txt
```

Optional: set the `DATABASE_URL` environment variable to a valid SQLAlchemy connection string. Otherwise, a local SQLite database will be created.

Initalize and seed the database:

```sh
$ flask db upgrade
$ python seed.py
```

## Running tests

Run:

```sh
$ python -m unittest discover
```

## Running the application

### Running locally

Run the application using the built-in Flask server:

```sh
$ flask run
```

### Running on a production server

Run the application using `gunicorn`:

```sh
$ pip install -r requirements-server.txt
$ gunicorn app:app
```

To set the listening address and port, run:

```
$ gunicorn app:app -b 0.0.0.0:8000
```

## Running on Docker

Run:

```
$ docker build -t ci-cd-tutorial-sample-app:latest .
$ docker run -d -p 8000:8000 ci-cd-tutorial-sample-app:latest
```



* - важное пояснение
** - решение возможных трудностей
*** - полезное

hosts:
192.168.49.2  my-flask-app.local

vim:
i - режим ввода
v - режим просмотра
esc - вовзрат к стандартному режиму команд

:q
:q! - выйти из несохранённого файла
:w - сохранить
:wq - сохранить и выйти



Vagrant:
vagrant init

Vagrantfile:
Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/focal64"
	config.vm.network "forwarded_port", guest: 80, host: 8080
end

ИЛИ

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo usermod -aG docker vagrant
    sudo apt-get install -y curl
  SHELL
end

ИЛИ

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Настройка перенаправления порта
  config.vm.network "forwarded_port", guest: 30000, host: 30000

  # Настройка виртуальной машины
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"  # Увеличьте до 4096MB или более
    vb.cpus = 2
  end

  # Установка Docker, Minikube, Kubectl и Helm
  config.vm.provision "shell", inline: <<-SHELL

    sudo apt-get update
  
  # Установка Docker
    sudo apt-get install -y docker.io
    sudo usermod -aG docker vagrant

    # Установка Minikube
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube
    sudo mv minikube /usr/local/bin/

    # Установка Kubectl
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/

    # Установка Helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    # Настройка bash completion для kubectl и helm
    echo "source <(kubectl completion bash)" >> ~/.bashrc
    echo "source <(helm completion bash)" >> ~/.bashrc
    source ~/.bashrc
  SHELL
end

vagrant up
vagrant ssh

vagrant halt

*После изменения Vagrantfile, выполните следующие команды для перезапуска виртуальной машины с новыми параметрами:
vagrant reload



Ubuntu:
sudo apt update
sudo apt upgrade

*Получение локального IP-адреса:
ifconfig
ИЛИ
ip a
Пример:
ip a
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:8e:2d:df brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.100/24 brd 192.168.1.255 scope global dynamic enp0s3
       valid_lft 86388sec preferred_lft 86388sec
    inet6 fe80::a00:27ff:fe8e:2ddf/64 scope link 
       valid_lft forever preferred_lft forever
Здесь 192.168.1.100 - это локальный IP-адрес.

*Получение внешнего IP-адреса:
curl ifconfig.me
ИЛИ
curl icanhazip.com

*Получение доменного имени:
hostname
ИЛИ
hostname -f
Пример:
hostname
ubuntu-focal



Git:
Установка и обновление:
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
Проверка:
git --version

Авторизация пользователя GitHub:
git config --global user.email "scelleapart@gmail.com"
git config --global user.name "Scelle"

Клонирование (пулл) репозитория тестового приложения:
git clone https://gitfront.io/r/deusops/Fsjok1dx89xG/flask-project-01/

Подключение к своему репозиторию:
git remote -v
git remote set-url origin git@github.com:Scelle/flask-project-01.git

Создание и добавление SSH-ключа:
ssh-keygen -t rsa -b 4096 -C "scelleapart@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub

Проверка подключения:
ssh -T git@github.com

Пуш приложения в свой репозиторий:
git init
git add .
git commit -m "initial commit"
git branch -M main
git remote add origin git@github.com:Scelle/flask-project-01.git
git push -u origin main

*Потом можно коммитить вот так:
git add deployment.yaml service.yaml
git commit -m "Add Kubernetes deployment and service manifests"
git push origin

ИЛИ

git push origin main

***Удалить коммит:
Мягкий сброс (soft reset) - сохранит изменения в рабочем каталоге:
git reset --soft HEAD~1
Жесткий сброс (hard reset) - удалит изменения в рабочем каталоге:
git reset --hard HEAD~1
git push --force

***Переименовать коммит:
git rebase -i HEAD~n
*Здесь n — количество последних коммитов
В открывшемся текстовом редакторе находим коммит, который хотим переименовать, меняем pick на reword, сохраняем изменения и выходим из редактора (vim (wq); nano (ctrl+o -> Enter -> ctrl+x)).
Далее переименовываем коммит, сохраняем изменения и выходим из редактора.
git push --force



Docker:
Установка:
***Можно удалить старые версии:
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker --version

Добавить текущего пользователя в группу docker, чтобы можно было использовать Docker без 'sudo':
sudo usermod -aG docker $USER
*После этого выйдите из системы и снова войдите, чтобы изменения вступили в силу.

Чтобы убедиться, что Docker установлен и работает правильно, выполните команду:
docker run hello-world

Авторизация пользователя Docker Hub:
docker login

Создание Docker-образа:
cd flask-project-01
vim Dockerfile

Сам Dockerfile:
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

Сборка Docker-образа:
docker build -t my-flask-app .

Запуск Docker-контейнера:
docker run -p 80:80 my-flask-app
***Когда мы говорим о пробросе портов, мы фактически создаем маршруты для сетевого трафика, которые перенаправляют запросы с определенного порта на хост-машине (ваш компьютер) на
соответствующий порт на гостевой машине (виртуальная машина Vagrant).

В вашем Vagrantfile вы настроили проброс порта следующим образом:
config.vm.network "forwarded_port", guest: 80, host: 8080
Это означает, что:
Любые запросы, приходящие на порт 8080 вашей хост-машины, будут перенаправлены на порт 80 вашей виртуальной машины.

В Docker вы используете команду docker run -p 80:80 my-flask-app, которая означает:
Проброс порта 80 на вашей виртуальной машине на порт 80 внутри контейнера.

Итог:
	Запросы на http://localhost:8080 на хост-машине будут перенаправлены на порт 80 виртуальной машины Vagrant.
	Виртуальная машина Vagrant перенаправляет эти запросы на порт 80 Docker-контейнера.
	Flask-приложение внутри Docker-контейнера обрабатывает эти запросы.
Проверка:
После выполнения всех шагов откройте браузер на вашей хост-машине и перейдите по адресу http://localhost:8080. Вы должны увидеть ваше Flask-приложение.

Пуш Docker-образа в Docker Hub:
docker build -t my-flask-app .
docker tag my-flask-app scelle/my-flask-app:latest
docker push scelle/my-flask-app:latest

Проверка:
docker pull scelle/my-flask-app:latest
docker run -p 80:80 scelle/my-flask-app:latest

***Просмотреть Docker-контейнеры и образы:
docker ps -a
docker images

***Удалить Docker-контейнеры и образы:
docker rm
docker rmi



GitLab:
1. Нужно импортировать репозиторий GitHub
***Так же можно добавить SSH-ключ (его создавали при настройке Git'а)

Установка:
Установка GitLab Runner:
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
chmod +x /usr/local/bin/gitlab-runner
gitlab-runner --version

Авторизация пользователя GitLab:
sudo gitlab-runner register
https://gitlab.com
glrt-XYWxwP8dwenoKNM8bx6R
docker
python:3.8

.gitlab-ci.yaml:
stages:
  - build
  - publish
  - release

variables:
  IMAGE_NAME: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

before_script:
  - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
  - docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD"

build:
  stage: build
  script:
    - docker build -t $IMAGE_NAME .
    - docker push $IMAGE_NAME

publish:
  stage: publish
  script:
    - docker tag $IMAGE_NAME $CI_REGISTRY_IMAGE:latest
    - docker push $CI_REGISTRY_IMAGE:latest

release:
  stage: release
  script:
    - docker tag $IMAGE_NAME $DOCKERHUB_USERNAME/$CI_PROJECT_NAME:latest
    - docker push $DOCKERHUB_USERNAME/$CI_PROJECT_NAME:latest



Kubernetes:
Установка:
Установка Minikube:
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

Установка kubectl:
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

Запуск Minikube:
minikube start --driver=docker
***Запуск Minikube с достаточным количеством памяти и использованием драйвера Docker:
minikube start --memory=4096mb --driver=docker

Проверка запуска:
Проверка статуса:
minikube status
Проверка контекста:
kubectl config current-context
*Д.б. minikube

deployment.yaml:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-flask-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: my-flask-app
  template:
    metadata:
      labels:
        app: my-flask-app
    spec:
      containers:
      - name: my-flask-app
        image: scelle/my-flask-app:latest
        ports:
        - containerPort: 5000

service.yaml:
apiVersion: v1
kind: Service
metadata:
  name: my-flask-app
spec:
  type: NodePort
  selector:
    app: my-flask-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
      nodePort: 30000

Применение манифестов:
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

Открытие сервиса Minikube:
minikube service my-flask-app
Проверка статуса Minikube:
minikube status

Проверка состояния кластера:
Проверка состояния узлов:
kubectl get pods

***Если какой-либо под находится в состоянии CrashLoopBackOff или Error, проверьте логи:
kubectl logs <pod-name>

***Проверка, что поды находятся в рабочем состоянии:
kubectl get pods -o wide
Проверка событий:
kubectl get events

***Удалить ненужный под:
kubectl delete pod <pod-name>

Проверка статуса сервисов:
kubectl get services

***Проверка статуса деплоев:
kubectl get deployments



Helm:
Установка Helm и Ingress:
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx

Проверка, что поды Ingress-контроллера запущены и работают:
kubectl get pods -n default -l app.kubernetes.io/name=ingress-nginx

ingress.yaml:
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-flask-app-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: <your-domain-or-ip>
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-flask-app
            port:
              number: 80

Вместо <your-domain-or-ip> - свой ip/домен, для этого:
minikube ip

kubectl apply -f ingress.yaml
Проверка Ingress:
kubectl get ingress

***Удалить Ingress-ресурс:
kubectl delete ingress <name>



Инициализация нового Helm-чарта:
helm create my-flask-app
cd my-flask-app
rm -rf templates/*

Создание необходимых ресурсов в директории 'templates/':
deployment.yaml:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}
    spec:
      containers:
      - name: {{ .Release.Name }}
        image: scelle/my-flask-app:latest
        ports:
        - containerPort: 5000
        envFrom:
        - configMapRef:
            name: {{ .Release.Name }}-config
        - secretRef:
            name: {{ .Release.Name }}-secret

service.yaml:
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-service
spec:
  type: NodePort
  selector:
    app: {{ .Release.Name }}
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
      nodePort: {{ .Values.service.nodePort }}


ingress.yaml:
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Values.ingress.name }}
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: {{ .Values.ingress.host }}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: {{ .Values.service.name }}
            port:
              number: 80


configmap.yaml:
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-config
data:
  FLASK_ENV: "production"
  DATABASE_URL: "sqlite:///mydatabase.db"

secret.yaml:
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Release.Name }}-secret
type: Opaque
data:
  SECRET_KEY: {{ .Values.secretKey | b64enc | quote }}

Обновление файла values.yaml:
values.yaml:
replicaCount: 2

image:
  repository: scelle/my-flask-app
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: NodePort
  port: 80
  nodePort: 30001

env:
  FLASK_ENV: "production"
  DATABASE_URL: "sqlite:///mydatabase.db"

secretKey: "mySecretKey"

Тестирование и установка Helm-чарта:
helm install my-flask-app ./my-flask-app
***Перед повторной установкой Helm-чарта, нужно убедится, что предыдущие ресурсы удалены:
helm uninstall my-flask-app
kubectl delete service my-flask-app-service

Проверка состояния всех ресурсов:
kubectl get all



Добавление в Helm-чарт файла ingress.yaml для описания конфигурации для доступа к приложению извне:
ingress.yaml:
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Release.Name }}-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: {{ .Values.ingress.host }}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: {{ .Release.Name }}-service
            port:
              number: 80

Обновление файла values.yaml:
values.yaml:
replicaCount: 2

image:
  repository: scelle/my-flask-app
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: NodePort
  port: 80
  nodePort: 30001

ingress:
  host: my-flask-app.local

env:
  FLASK_ENV: "production"
  DATABASE_URL: "sqlite:///mydatabase.db"

secretKey: "mySecretKey"

*Перед повторной установкой Helm-чарта, нужно убедится, что предыдущие ресурсы удалены:
helm uninstall my-flask-app
kubectl delete ingress my-flask-app-ingress



Добавление переменных для конфигурирования приложения в файл values.yaml:
values.yaml:
replicaCount: 2

image:
  repository: scelle/my-flask-app
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: NodePort
  port: 80
  nodePort: 30001

ingress:
  enabled: true
  host: my-flask-app.local
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
  path: /
  pathType: Prefix

env:
  FLASK_ENV: "production"
  DATABASE_URL: "sqlite:///mydatabase.db"

secretKey: "mySecretKey"

deployment.yaml:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}
  labels:
    app: {{ .Release.Name }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}
    spec:
      containers:
      - name: {{ .Release.Name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        imagePullPolicy: {{ .Values.image.pullPolicy }}
        ports:
        - containerPort: 5000
        env:
        - name: FLASK_ENV
          value: {{ .Values.env.FLASK_ENV }}
        - name: DATABASE_URL
          value: {{ .Values.env.DATABASE_URL }}
        - name: SECRET_KEY
          value: {{ .Values.secretKey }}

service.yaml:
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-service
spec:
  type: {{ .Values.service.type }}
  selector:
    app: {{ .Release.Name }}
  ports:
    - protocol: TCP
      port: {{ .Values.service.port }}
      targetPort: 5000
      nodePort: {{ .Values.service.nodePort }}

ingress.yaml:
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Release.Name }}-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: {{ .Values.ingress.host }}
    http:
      paths:
      - path: {{ .Values.ingress.path }}
        pathType: {{ .Values.ingress.pathType }}
        backend:
          service:
            name: {{ .Release.Name }}-service
            port:
              number: {{ .Values.service.port }}

*Перед повторной установкой Helm-чарта, нужно убедится, что предыдущие ресурсы удалены:
helm uninstall my-flask-app
kubectl delete deployment my-flask-app
kubectl delete service my-flask-app-service
kubectl delete ingress my-flask-app-ingress



Создание нового репозитория GitLab для Helm-чарта:
Авторизация пользователя GitLab:
git config --global user.name "Scelle Apart"
git config --global user.email "scelleapart@gmail.com"

Пуш существующей папки с Helm-чартом:
cd ~/flask-project-01/my-flask-app
git init --initial-branch=main
**Создайте персональный токен доступа на GitLab.
**Настройте удалённый URL:
git remote set-url origin https://scelleapart:glpat-1psGMtkvUhDS-qXGPUyz@gitlab.com/scelleapart/my-flask-app-helm-chart.git

git add .
git commit -m "Initial commit"
git push --set-upstream origin main

Настройка Helm для деплоя приложения в Kubernetes:
minikube start --driver=docker

helm repo index .
***Это создаст index.yaml файл в текущем каталоге (~/flask-project-01/my-flask-app)
git add index.yaml
git commit -m "Add Helm chart repository index"
git push origin main

helm repo add my-flask-app https://scelleapart:glpat-1psGMtkvUhDS-qXGPUyz@gitlab.com/scelleapart/my-flask-app-helm-chart.git
helm repo add my-flask-app https://scelleapart:glpat-1psGMtkvUhDS-qXGPUyz@gitlab.com/scelleapart/my-flask-app-helm-chart/raw/main/
helm repo add my-flask-app https://gitlab.com/scelleapart/my-flask-app-helm-chart/-/raw/main/

Обновление и проверка добавления репозитория:
helm repo update
helm search repo my-flask-app

***https://gitlab.com/scelleapart/my-flask-app-helm-chart.git - URL репозитория (ссылка в Clone with HTTPS)
Вместо: helm install my-flask-app my-flask-app/my-flask-app
Использовать это: helm repo update

.gitlab-ci.yml:
stages:
  - build
  - deploy

build:
  stage: build
  image: alpine:latest
  script:
    - echo "Build stage"

deploy:
  stage: deploy
  image: dtzar/helm-kubectl:latest
  script:
    - helm repo add my-flask-app <URL вашего репозитория на GitLab>
    - helm upgrade --install my-flask-app my-flask-app/my-flask-app
  environment:
    name: production
    url: http://my-flask-app.local

