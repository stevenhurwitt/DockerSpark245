ARG debian_jdk_image_tag=debian-slim
ARG debian_python_tag=3.7-slim
# FROM openjdk8:${debian_jdk_image_tag}
FROM python:${debian_python_tag}
# FROM datamechanics/spark:3.2.0-latest

# -- Layer: OS + Python 3.7

ARG shared_workspace=/opt/workspace
ARG java_home=/root/.sdkman/candidates/java/current

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -y && \
    apt install -y curl gcc zip unzip && \ 
    # apt install -y openjdk-11-jdk && \
	apt install -y build-essential zlib1g-dev libncurses5-dev && \
	apt install -y libsqlite3-dev && \
	apt install -y libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget libjpeg-dev && \
    apt install -y procps nano net-tools iputils-ping && \
	# curl -O https://www.python.org/ftp/python/3.7.11/Python-3.7.11.tar.xz  && \
    # tar -xf Python-3.7.11.tar.xz && cd Python-3.7.11 && ./configure && make -j 8 &&\
    # make install && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s https://get.sdkman.io | bash
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh" && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install java 8.332.08.1-amzn && \
    sdk install maven && \
    sdk install scala 2.12.15 && \
    sdk use java 8.332.08.1-amzn && \
    sdk use scala 2.12.15

# RUN echo $JAVA_HOME

ENV JAVA_HOME ${java_home}

ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]
