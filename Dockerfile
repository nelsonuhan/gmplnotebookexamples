FROM andrewosh/binder-base

MAINTAINER Nelson Uhan <nelson@uhan.me>

USER root

# Update repositories
RUN apt-get update

# Install libgmp
RUN apt-get install -y libgmp-dev

# Install glpk from source
RUN wget http://ftp.gnu.org/gnu/glpk/glpk-4.60.tar.gz
RUN tar zxvf glpk-4.60.tar.gz
RUN cd glpk-4.60
RUN ./configure
RUN make
RUN make install

USER main

# Set environment variables for pyglpk install
RUN export C_INCLUDE_PATH=/usr/local/include
RUN export LD_LIBRARY_PATH=/usr/local/lib

# Install pyglpk
pip install https://github.com/bradfordboyle/pyglpk/zipball/master

# Install GMPL Notebook
pip install gmplnotebook

# Install GMPL Notebook kernel extension 
python -m gmplnotebook install --user
