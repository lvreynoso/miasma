#!/usr/bin/env python3

# import a dataset, output a graph

import csv
from bokeh.plotting import figure, output_file, show
from bokeh.io import export_png
from bokeh.layouts import layout

x = []
y = []

# open the data file
with open('./data/mauna_loa_co2_eslr.csv', mode='r') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            print(f'Skipping column headers')
            line_count += 1
        else:
            x.append(row[2])
            y.append(row[5])
            line_count += 1
    print(f'Processed {line_count} lines.')

output_file("./plots/test_large.html")

# create the plot
p = figure(width=1334, height=750, title="Mauna Loa Carbon Dioxide Levels",
           x_axis_label="Date", y_axis_label="CO2 in ppm")

# add a line renderer
p.line(x, y, line_width=2)

layout(children=[p], sizing_mode='fixed')

# show(p)

# export plot
export_png(p, filename="./plots/plot_large.png")


print(f'Plot generated!')
