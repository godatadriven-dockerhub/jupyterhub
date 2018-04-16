ARG SPARK_VERSION=2.3.0
FROM godatadriven/pyspark:${SPARK_VERSION}

ARG BUILD_DATE
ARG SPARK_VERSION

LABEL org.label-schema.name="JupyterHub + PySpark $SPARK_VERSION" \
      org.label-schema.build-date=$BUILD_DATE
      
RUN conda install -y nb_conda jupyterhub jupyter_client findspark -c conda-forge && \
    python -m nb_conda_kernels.install --enable --prefix=/opt/miniconda3 && \
    conda clean -tipsy && \
    apt-get update && \
    apt-get install -y openjdk-8-jre git build-essential nano vim less procps --no-install-recommends && \
    apt-get clean && \
    export SPARK_HOME=$(python /opt/miniconda3/bin/find_spark_home.py) && \
    echo "SPARK_HOME=$(python /opt/miniconda3/bin/find_spark_home.py)" > /etc/profile.d/spark.sh

EXPOSE 8000
ENTRYPOINT ["jupyterhub"]