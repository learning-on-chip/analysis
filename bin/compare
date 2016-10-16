#!/usr/bin/env python3

import matplotlib.pyplot as pp
import numpy as np
import os, sys

sys.path.append(os.path.dirname(__file__))

from workload import Workload
import constant

def main(names, component_id=1):
    count = len(names)
    pp.figure(figsize=(14, 2 * count), facecolor='w', edgecolor='k')
    for i in range(count):
        data = Workload.aggregate(Workload.locate(names[i]), 'dynamic_power')
        step_count = data.shape[1]
        time = constant.TIME_STEP * np.arange(step_count)
        pp.subplot(count, 1, i + 1)
        pp.plot(time, data[component_id, :])
        pp.xlim([time[0], time[-1]])
        pp.xlabel('Time (s)')
        pp.ylabel('Power (W)')
    pp.show()

if __name__ == '__main__':
    main(sys.argv[1:])
