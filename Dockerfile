FROM andrewosh/binder-base

MAINTAINER Nelson Uhan <nelson@uhan.me>

USER root

# Do everything in main's home directory
WORKDIR /home/main

# Update repositories
RUN apt-get update

# Install libgmp
RUN apt-get install -y libgmp-dev

# Install glpk from source
RUN wget http://ftp.gnu.org/gnu/glpk/glpk-4.60.tar.gz
RUN tar zxvf glpk-4.60.tar.gz
RUN cd glpk-4.60 && ./configure && make && make install

USER main

# Install pyglpk
ENV C_INCLUDE_PATH /usr/local/include
ENV LD_LIBRARY_PATH /usr/local/lib
RUN /home/main/anaconda2/envs/python3/bin/pip install https://github.com/bradfordboyle/pyglpk/zipball/v0.4.3

# Install GMPL Notebook
RUN /home/main/anaconda2/envs/python3/bin/pip install https://github.com/nelsonuhan/gmplnotebook/zipball/master 

# Install GMPL Notebook kernel extension 
RUN /home/main/anaconda2/envs/python3/bin/python -m gmplnotebook install --user
