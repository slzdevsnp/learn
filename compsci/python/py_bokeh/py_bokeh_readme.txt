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


ch3
    columnDataSource (needed for hoover and used to draw glyphs)
    hovertools customized with data  (iris)
    layout multiple plots
    span annotation (lines)
    box_annotations (rectangles)
    labels for specific glyphs  ch3_categorical_labels.py

ch4
    bokeh server
    >python -m bokeh serve widgets.py  #basic example
    >bokeh server widgets.py
    >bokeh server --port 5007 dyn_chart_labels_select.py
    selecgt_span_ex8Sol how to dynamically compute values of Select UI

ch5 
    streaming in bokeh server
    random_generator_chart.py
    bitcoin_stream-webscrap.py
    bitcoint_stream_widgets.py

ch6
    venv/bokeh/bin/pip3 install Flask
    ch6_inflask    flaskapp0    python flaskapp0/app.py how to embed a basic line chart

    embedding dynamic bokeh charts  (2 separate processes) 
    ## bokeh tornado runs on 5006
    #  flask runs on 5000
    bokeh serve  --allow-websocket-origin=localhost:5000   random_generator.py
    python app.py  # runs on port 5000

    djangoapp0   (better for big apps), flask more flexible
    django-admin startproject mysite
    cd djangoapp0/mysite
    python manage.py startapp bokehapp
    #to run the server
    python manage.py runserver 
