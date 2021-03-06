#!/usr/bin/env python3

import os, sys
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'lib'))

from workload import Workload
import constant
import matplotlib.pyplot as pp
import numpy as np

def main(names):
    for name in names:
        process(name)
        while not pp.waitforbuttonpress():
            pass

def process(name):
    data = Workload.aggregate(Workload.locate(name), 'dynamic_power')
    component_count, step_count = data.shape
    time = constant.TIME_STEP * np.arange(0, step_count)
    pp.figure(figsize=(14, 2 * component_count), facecolor='w', edgecolor='k')
    for i in range(component_count):
        pp.subplot(component_count, 1, i + 1)
        pp.plot(time, data[i, :])
        pp.xlim([time[0], time[-1]])
        pp.ylabel('Power (W)')
        if i == 0:
            pp.title(name)
    pp.xlabel('Time (s)')

main(sys.argv[1:])
