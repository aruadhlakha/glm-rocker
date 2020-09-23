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
	&& Rscript -e 'devtools::install_github("USGS-R/glmtools", ref = "ggplot_overhaul")' \
	&& Rscript -e 'devtools::install_github("GLEON/rLakeAnalyzer")' \
	&& Rscript -e 'devtools::install_github("aemon-j/FLakeR", ref = "inflow")' \
	&& Rscript -e 'devtools::install_github("aemon-j/GOTMr")' \
	&& Rscript -e 'devtools::install_github("aemon-j/gotmtools")' \
	&& Rscript -e 'devtools::install_github("aemon-j/SimstratR")' \
	&& Rscript -e 'devtools::install_github("aemon-j/MyLakeR")' \
	&& Rscript -e 'devtools::install_github("aemon-j/MyLakeR")' \
	&& Rscript -e 'devtools::install_github("aemon-j/LakeEnsemblR")'

RUN 	echo "rstudio  ALL=(ALL) NOPASSWD:ALL">>/etc/sudoers

RUN	mkdir /home/rstudio/test-scripts 

WORKDIR /home/rstudio/test-scripts 

RUN	git clone https://github.com/aruadhlakha/GLM-scripts.git 

RUN 	chmod -R 777 .

RUN	mkdir /home/rstudio/configurations 

WORKDIR /home/rstudio/configurations 

RUN	git clone https://github.com/aruadhlakha/glm-configs.git 


RUN 	chmod -R 777 .

COPY rserver.conf /etc/rstudio/rserver.conf
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install py-cdrive-api
