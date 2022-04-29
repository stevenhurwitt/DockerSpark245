FROM stevenhurwitt/cluster-base

# -- Layer: JupyterLab

ARG spark_version=3.2.0
ARG jupyterlab_version=2.1.5

RUN apt-get update -y && \
    pip3 install setuptools==59.8.0 && \
	pip3 install pypandoc && \
    pip3 install pyspark==${spark_version} jupyterlab==${jupyterlab_version} && \
	pip3 install wget && \
    pip3 install numpy && \
    pip3 install pandas && \
    pip3 install matplotlib && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/local/bin/python3 /usr/bin/python

# RUN jupyter notebook --generate-config
# RUN cp /root/.jupyter/jupyter_notebook_config.py /root/.jupyter/jupyter_server_config.py
# RUN echo "c.ServerApp.password=u''">>/root/.jupyter/jupyter_server_config.py
# RUN echo "c.NotebookApp.password=u''">>/root/.jupyter/jupyter_notebook_config.py
# -- Runtime

EXPOSE 8888
WORKDIR ${SHARED_WORKSPACE}
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.token='' --ServerApp.password=''

