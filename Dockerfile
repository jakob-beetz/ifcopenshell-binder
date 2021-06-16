FROM jupyter/scipy-notebook:5cb007f03275

MAINTAINER Thomas Paviot <tpaviot@gmail.com>

USER root

ENV DEBIAN_FRONTEND=noninteractive

##############
# apt update #
##############
RUN apt-get update
RUN apt install libgl1-mesa-glx -y

USER jovyan

# Install packages via requirements.txt
#ADD requirements.txt .
#RUN pip install -r requirements.txt

# .. Or update conda base environment to match specifications in environment.yml
ADD environment.yml /tmp/environment.yml

# All packages specified in environment.yml are installed in the base environment
RUN conda env update -f /tmp/environment.yml && \
    conda clean -a -f -y
RUN jupyter labextension install jupyter-threejs
RUN jupyter labextension install jupyter-datawidgets
RUN jupyter labextension install ipycanvas

