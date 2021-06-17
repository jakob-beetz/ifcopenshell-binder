FROM jupyter/scipy-notebook

MAINTAINER Jakob Beetz
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
ADD environment.yml environment.yml

# All packages specified in environment.yml are installed in the base environment
RUN conda env update -f environment.yml && \
    conda clean -a -f -y
RUN jupyter labextension install jupyter-threejs
RUN jupyter labextension install jupyter-datawidgets
RUN jupyter labextension install ipycanvas

WORKDIR /home/jovyan/work
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}
