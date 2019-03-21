#!/bin/bash
#
# Script to Install
# Linux System Tools and Basic Python Components
# as well as to
# Start Jupyter Notebook Server
#
# Python for Algorithmic Trading
# (c) Dr. Yves J. Hilpisch
# The Python Quants GmbH
#
# GENERAL LINUX
sudo apt-get update  # updates the package index cache
sudo apt-get upgrade -y  # updates packages
# install system tools
sudo apt-get install -y bzip2 gcc git htop screen htop vim wget
sudo apt-get upgrade -y bash  # upgrades bash if necessary
sudo apt-get clean  # cleans up the package index cache

# INSTALLING MINICONDA
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda.sh
if [ -d miniconda3 ]
then 
	rm -rf miniconda3
fi
bash Miniconda.sh -b  # installs Miniconda
rm -rf Miniconda.sh  # removes the installer
export PATH="/home/sz_metafused_com/miniconda3/bin:$PATH"  # prepends the new path for current session
# prepends the new path in the shell configuration
cat >> ~/.profile <<EOF
export PATH="/home/sz_metafused_com/miniconda3/bin:$PATH"
EOF

# INSTALLING PYTHON LIBRARIES
conda install -y jupyter  # interactive data analytics in the browser
conda install -y pytables  # wrapper for HDF5 binary storage
conda install -y pandas  #  data analysis package
conda install -y matplotlib  # standard plotting library
conda install -y seaborn  # statistical plotting library
conda install -y quandl  # wrapper for Quandl data API
conda install -y scikit-learn  # machine learning library
conda install -y flask  # light weight web framework
conda install -y openpyxl  # library for Excel interaction
conda install -y pyyaml  # library to manage yaml files
conda install -y bokeh  # interactive plots 

pip install --upgrade pip  # upgrading the package manager
pip install q  # logging and debugging
pip install plotly==2.6  # interactive D3.js plots
pip install cufflinks  # combining plotly with pandas
pip install tensorflow  # deep learning library
pip install eikon  # Python wrapper for TR Eikon API
pip install git+git://github.com/yhilpisch/tpqoa  # Python wrapper for Oanda API

# COPYING FILES AND CREATING DIRECTORIES
mkdir .jupyter
mv ./jupyter_notebook_config.py .jupyter/
mv ./cert.* .jupyter
mkdir notebook
cd notebook

# STARTING JUPYTER NOTEBOOK
jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root
