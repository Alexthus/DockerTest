# Базовый образ рос берётся за основу
FROM osrf/ros:humble-desktop
# Задаём переменную окружения, чтобы пользователь не участвовал в установке
ENV DEBIAN_FRONTEND=noninteractive
# Установим необходимые пакеты
RUN apt update && apt install -y \
xpra \
xterm \
net-tools \
netcat \
nano \
ros-$ROS_DISTRO-turtlebot3* \
ros-humble-rmw-cyclonedds-cpp
# Добавим настройки переменных окружения в .bashrc
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc \
&& echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc \
&& echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> ~/.bashrc \
&& echo "export TURTLEBOT3_MODEL=waffle" >> ~/.bashr
# скопируем файл simple.bash
COPY simple.bash /home/test/
# Зададим стартовую команду для контейнера
CMD ["bash"]
