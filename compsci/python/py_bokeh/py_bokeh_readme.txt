## based on course by ardit Sulce.   
Data Visualization on the Browser with Python and Bokeh


bokeh version used incourse = 0.13.0  (current version is 1.0.4)

pip3 install bokeh==0.13.0

in pycharm createed new project with VirtualEnv    ~/venv/bokeh   with pythong 3.6

installation: 

cd  ~/venv/bokeh
bin/pip3 install bokeh==0.13.0

this installs also dependencies, including Jinja2, numpy(1.16.1), PyYAML, tornado(5.1.1)

also, lets install a version of pandas 0.23.4
bin/pip3 install pandas==0.23.4


install also jupyter
bin/pip3 install jupyter 

source ~/venv/bokeh/bin/activate

start jupyter in the env
cd ~
venv/bokeh/bin/jupyter notebook   # jupyter notebook starts with correct venv's python kernel and local packages


==================== contents ===============================
ch1 Getting Started
ch2 Customizing Bokeh Graphs
ch3 Advanced Plotting
ch4 Boker Server: Interactive Plotting with HTML Widgets
ch5 Boker Server: Streaming Real Time Data
ch6 Embedding Bokeh Plots in WebSites
ch7 Deploying Bokeh Data Visualization Apps in Live Servers
=============================================================


ch1 getting started

    bokeh in  Interactive jupyter session bug

    1. instead of show(f) use save(f) to overwrite your plot, not to append it
    2. using bokeh non-interactively as python  bokeh_code.py

    official doc   bokeh.pydata.org
    complete API: Refererence Guide !


ch2 
    nb/ch2/iris_styling.ipynb
    f.background_fill_color="#BFEBBB"  #can use rgb picker

    some font names that could be used in bokeh:
    Antiqua, Arial, Calibri, Courier, Fraktur,Helvetica, Modern,Monospace,Open Sans, Palatino, roman, Sans-serif,Serif,Swiss,Times, Times New Roman, Verdana


   ch2_iris.styling.py    styles, axes, ticks, colors,  color of data, alpha, legend