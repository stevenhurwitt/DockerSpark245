ARG debian_jdk_image_tag=8-jre-slim
ARG debian_python_tag=3.7-slim
FROM openjdk:${debian_jdk_image_tag}
FROM python:${debian_python_tag}
# FROM datamechanics/spark:3.2.0-latest

# -- Layer: OS + Python 3.7

ARG shared_workspace=/opt/workspace

USER root
RUN apt-get update -y
RUN apt install -y curl gcc &&\ 
	apt install -y build-essential zlib1g-dev libncurses5-dev && \
	apt install -y libsqlite3-dev && \
	apt install -y libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget libjpeg-dev && \
    apt install -y procps nano net-tools && \
	# curl -O https://www.python.org/ftp/python/3.7.11/Python-3.7.11.tar.xz  && \
    # tar -xf Python-3.7.11.tar.xz && cd Python-3.7.11 && ./configure && make -j 8 &&\
    # make install && \
    # apt-get update && apt-get install -y procps && apt-get install -y nano && apt-get install -y net-tools && \
    rm -rf /var/lib/apt/lists/*

ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]
