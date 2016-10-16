#!/usr/bin/env python3

import matplotlib.pyplot as pp
import numpy as np
import os, sys

sys.path.append(os.path.dirname(__file__))

from workload import Workload
import constant

def main(names, draw=True):
    paths = []
    for name in names:
        paths.extend(Workload.enumerate(name))
    print('%-20s %10s %10s' % ('Benchmark', 'Components', 'Time, s'))
    count = len(paths)
    cores = np.zeros([count, 1])
    cache = np.zeros([count, 1])
    for i in range(count):
        name = '/'.join(paths[i].split('/')[-2:]).replace('.sqlite3', '')
        data = Workload.aggregate(paths[i], 'dynamic_power')
        [component_count, step_count] = data.shape
        sys.stdout.write('%-20s %10d %10.2f' % (
            name, component_count, constant.TIME_STEP * step_count
        ))
        total = np.sum(data)
        index = int(max(1, np.floor(component_count / 4)))
        index = range(component_count - index)
        for j in range(component_count):
            local = np.sum(data[j, :])
            sys.stdout.write(' %10.2e (%5.2f%%)' % (
                local, 100 * local / total
            ))
            if j in index: cores[i] += local
            else: cache[i] += local
        print()
    scale = cores + cache
    cores = 100 * cores / scale
    cache = 100 * cache / scale
    print('Average cache contribution: %.2f%%' % np.mean(cache))
    if not draw: return
    index = list(range(count))
    pp.figure(figsize=(14, 6), facecolor='w', edgecolor='k')
    pp.bar(index, cores, color='b')
    pp.bar(index, cache, color='y', bottom=cores)
    pp.ylim([0, 101])
    pp.show()

if __name__ == '__main__':
    main(sys.argv[1:])
