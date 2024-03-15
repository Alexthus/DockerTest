# Последовательные шаги выполнения задания: 
#
# Установка Docker:
# 1. Обновил индекс пакетов:
#            sudo apt-get update
# 2. Установил необходимые пакеты:
#            sudo apt-get install ca-certificates curl gnupg
# 3. Добавил официальный GPG-ключ в Docker:
#            sudo install -m 0755 -d /etc/apt/keyrings
#            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#            sudo chmod a+r /etc/apt/keyrings/docker.gpg
# 4. Добавил репозиторий Docker в источники Apt:
#            echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# 5. Обновил индекс пакетов:
#            sudo apt-get update
# Установка пакетов Docker:
#            sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Проверка установки:
#            sudo docker run hello-world
#
# Установка Docker Compose:
# 1. Загрузка Docker Compose:
#            sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
# 2. Установка прав на исполнение файла:
#            sudo chmod +x /usr/local/bin/docker-compose
# 3. Проверка работы программы:
#            docker-compose --version
#
# Настройка Docker для работы без прав root (добавление пользователя в группу docker).
# 1. Создание группы docker
#            sudo groupadd docker
# 2. Добавление пользователя в эту группу6
#            sudo usermod -aG docker $USER
# 3. Активация изменений в группе
#            newgrp docker
# 4. Проверка работоспособности docker без ввода пароля
#            docker run hello-world
#
# Разработка простой программы выводящеий текущую дату:
#            nano simple.bash
# Код програмы:
#            #!/bin/bash/
#            echo "today is: "
#            date
#
# Далее зашёл на github и создал новый репозиторий DockerTest 
# 
# Создал Dockerfile для сборки образа, включающего программу simple.bash.
#            nano Dockerfile
#
# Код:
#               Базовый образ рос берётся за основу
#            FROM osrf/ros:humble-desktop
#               Задаём переменную окружения, чтобы пользователь не участвовал в установке
#            ENV DEBIAN_FRONTEND=noninteractive
#               Установим необходимые пакеты
#            RUN apt update && apt install -y \
#            xpra \
#            xterm \
#            net-tools \
#            netcat \
#            nano \
#            ros-$ROS_DISTRO-turtlebot3* \
#            ros-humble-rmw-cyclonedds-cpp
#               Добавим настройки переменных окружения в .bashrc
#            RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc \
#            && echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc \
#            && echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> ~/.bashrc \
#            && echo "export TURTLEBOT3_MODEL=waffle" >> ~/.bashr
#               скопируем файл simple.bash
#            COPY simple.bash /home/test/
#               Зададим стартовую команду для контейнера
#            CMD ["bash"]
#
#
# Собрал Docker-образ (custom_image) из Dockerfile.
#            docker build -t custom_image

# Запустил образ:
#            docker run -it custom_image
# Запустил программу simple.bash из папки /home/test/
#            bash simple.bash
# Программа выводит тукущую дату и время.
#
# Работа с Docker Compose:
# 1. Создал docker-compose.yaml, который запускает ваш Docker-контейнер с программой.
# Код:
#       
#               версия composer
#             version: '2' 
#               раздел служб
#             services:
#               служба, вызывающая дату
#              date1:
#               базовый образ контейнера
#               image: custom_image
#               команда, выполняемая после запуска контейнера
#               command: bash home/test/simple.bash
#               вторая служба, тоже вызывающая дату
#              date2:
#               базовый образ контейнера
#               image: custom_image
#               команда, выполняемая после запуска контейнера
#               command: bash home/test/simple.bash
#               зависимость - запуск date2 осуществляется после date1
#               depends_on:
#               - date1
# 
# 2. Запустил через docker-compose:
#             docker-compose up
# 
# Добавление файлов в репозиторий: 
# 1. Склонировал репозиторий из первого шага в рабочую директорию по SSH:
#             git clone git@github.com:Alexthus/DockerTest.git
# 2. Скопировал в неё файлы:
#             mv docker-compose.yaml Dockerfile ~/Project/ROS_PRJ/Docker/DockerTest
# 3. Иницмиализировал репозиторий 
#             git init
# 4. Добавил файлы:
#             git add Dockerfile
#             git add docker-compose.yaml
# 5. Сделал  commit:
#             git commit -m "Added Dockerfile and .yaml to repositiory"
# 6. Загрузил изменения на github:
#             git push
