FROM godatadriven/pyspark

ARG BUILD_DATE
ARG JH_VERSION

LABEL org.label-schema.name="JupyterHub $JH_VERSION + PySpark $SPARK_VERSION" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$JH_VERSION
      
RUN set -x && \
    if [ -n "$JH_VERSION" ]; then\
        conda install -y nb_conda jupyterhub==$JH_VERSION jupyter_client 'tornado<6' -c conda-forge;\
    else\
        conda install -y nb_conda jupyterhub jupyter_client 'tornado<6' -c conda-forge;\
    fi && \
    python -m nb_conda_kernels.install --enable --prefix=/opt/miniconda3 && \
    conda clean -tipsy && \
    apt-get update && \
    apt-get install -y openjdk-8-jre git build-essential nano vim less procps apt-transport-https ca-certificates --no-install-recommends && \
    apt-get clean

EXPOSE 8000
ENTRYPOINT ["jupyterhub"]