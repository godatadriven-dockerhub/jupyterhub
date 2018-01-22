FROM godatadriven/miniconda:3

ARG BUILD_DATE
ARG SPARK_VERSION=2.2.1

LABEL org.label-schema.name="JupyterHub" \
      org.label-schema.build-date=$BUILD_DATE
      
ENV SPARK_HOME /usr/spark
ENV PATH="/usr/spark/bin:${PATH}"
  
RUN conda install -y pyzmq==16.0.2 nb_conda jupyter jupyterhub findspark -c conda-forge && \
  	python -m nb_conda_kernels.install --enable --prefix=/opt/miniconda3 && \
  	conda clean -tipsy && \
  	apt-get update && \
	apt-get install -y wget openjdk-8-jre && \
    wget -q "http://apache.cs.uu.nl/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz" && \
    tar xzf "spark-${SPARK_VERSION}-bin-hadoop2.7.tgz" && \
    rm "spark-${SPARK_VERSION}-bin-hadoop2.7.tgz" && \
    mv "spark-${SPARK_VERSION}-bin-hadoop2.7" /usr/spark && \
    apt-get remove -y wget && \
    apt-get clean

EXPOSE 8000
ENTRYPOINT ["jupyterhub"]