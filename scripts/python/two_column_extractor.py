#!/usr/bin/env python3

# import a dataset, output a graph

import csv

x = []
y = []

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

with open('./processed/mauna_loa_co2_eslr.csv', mode='w') as write_file:
    process_writer = csv.writer(
        write_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

    for index in range(len(x) - 1):
        process_writer.writerow([x[index], y[index]])
    print(f'Done writing out data.')
