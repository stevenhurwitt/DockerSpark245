SPARK_VERSION="3.2.0"
HADOOP_VERSION="3.2"
JUPYTERLAB_VERSION="2.1.5"

# -- Building the Images

docker build \
  -f cluster-base.Dockerfile \
  -t stevenhurwitt/cluster-base:latest .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f spark-base.Dockerfile \
  -t stevenhurwitt/spark-base:latest .

docker build \
  -f spark-master.Dockerfile \
  -t stevenhurwitt/spark-master:latest .

docker build \
  -f spark-worker.Dockerfile \
  -t stevenhurwitt/spark-worker:latest .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f jupyterlab.Dockerfile \
  -t stevenhurwitt/jupyterlab:latest .

# Local copy of Notebooks and job-submit scripts outside Git change tracking
mkdir -p ./local/notebooks
cp -R ./notebooks/* ./local/notebooks

