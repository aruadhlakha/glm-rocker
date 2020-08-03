FROM rocker/verse:3.6.3-ubuntu18.04

MAINTAINER "ARYAN ADHLAKHA" aryan@cs.wisc.edu "Robert Ladwig" 

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
	gfortran-8 \
	gfortran \ 
	libgd-dev \
	git \
	build-essential \
	libnetcdf-dev \
	ca-certificates \
	&& update-ca-certificates 

RUN 	Rscript -e 'install.packages("ncdf4")' \
	&& Rscript -e 'install.packages("devtools")' \
	&& Rscript -e 'devtools::install_github("GLEON/GLM3r",ref="GLMv.3.1.0a3")' \
	&& Rscript -e 'devtools::install_github("USGS-R/glmtools", ref = "ggplot_overhaul")' 

RUN	mkdir home/rstudio/scripts
WORKDIR	home/rstudio/scripts

RUN	git clone https://github.com/aruadhlakha/GLM-scripts.git

RUN	mkdir home/rstudio/configurations
WORKDIR	home/rstudio/configurations

RUN	git clone https://github.com/aruadhlakha/glm-configs.git
	
RUN 	mkdir home/rstudio/GLM-a

WORKDIR home/rstudio/GLM-a

RUN git clone https://github.com/AquaticEcoDynamics/GLM.git && \
	git clone https://github.com/AquaticEcoDynamics/libplot.git && \
	git clone https://github.com/AquaticEcoDynamics/libutil.git && \
	git clone https://github.com/aruadhlakha/libaed2.git

WORKDIR libutil

RUN F90=gfortran-8 make

WORKDIR ../libplot

RUN make

WORKDIR ../libaed2

RUN F90=gfortran-8 make

WORKDIR ../GLM

RUN FC=gfortran-8 ./build_glm.sh

COPY rserver.conf /etc/rstudio/rserver.conf
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install py-cdrive-api
