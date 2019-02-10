from bokeh.plotting import figure
from bokeh.embed import components
from bokeh.resources import CDN
x=[1,2,3,4,5]
y=[6,7,8,9,10]

f=figure()
f.plot_width=300
f.plot_height=300
f.line(x,y)


js,div = components(f)

cdn_js=CDN.js_files[0]
cdn_css=CDN.css_files[0]