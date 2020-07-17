FROM ubuntu:latest

MAINTAINER "ARYAN ADHLAKHA" aryan@cs.wisc.edu "Robert Ladwig" #original creator: Joseph Stachelek, stachel2@msu.edu

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
	gfortran-8 \
	gfortran \ 
	libgd-dev \
	git \
	build-essential \
	libnetcdf-dev \
	ca-certificates \
	&& update-ca-certificates

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
