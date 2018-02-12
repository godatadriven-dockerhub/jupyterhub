FROM godatadriven/miniconda:3

ARG BUILD_DATE
ARG SPARK_VERSION=2.2.1

LABEL org.label-schema.name="JupyterHub" \
      org.label-schema.build-date=$BUILD_DATE
      
RUN conda install -y pyzmq==16.0.2 nb_conda jupyter jupyterhub jupyter_client findspark pyspark==${SPARK_VERSION} -c conda-forge && \
  	python -m nb_conda_kernels.install --enable --prefix=/opt/miniconda3 && \
    conda clean -tipsy && \
  	apt-get update && \
	apt-get install -y openjdk-8-jre && \
    apt-get clean && \
    export SPARK_HOME=$(python /opt/miniconda3/bin/find_spark_home.py)

EXPOSE 8000
ENTRYPOINT ["jupyterhub"]