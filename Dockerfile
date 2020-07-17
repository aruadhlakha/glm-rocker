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

RUN 	Rscript -e 'install.packages(”ncdf4”)' \
	&& Rscript -e 'install.packages(”devtools”)' \
	&& Rscript -e 'devtools::install_github("GLEON/GLM3r")' \
	&& Rscript -e 'devtools::install_github("USGS-R/glmtools", ref = "ggplot_overhaul")' 
	

	
