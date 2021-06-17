FROM jupyter/scipy-notebook

MAINTAINER Jakob Beetz
USER root


RUN apt-get update
RUN apt install libgl1-mesa-glx -y



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

USER jovyan
WORKDIR /home/jovyan/work
