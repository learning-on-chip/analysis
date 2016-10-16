from database import Database
import constant, glob, os
import numpy as np

class Workload:
    def aggregate(path, column):
        component_ids = read_components(path)
        component_count = len(component_ids)
        code = 'SELECT {} FROM dynamic WHERE component_id = ? ORDER BY time'
        code = code.format(column)
        data = None
        for i, component_id in enumerate(component_ids):
            result = Database.execute(path, code, component_id)
            result = np.array(result).transpose()
            if data is None: data = np.zeros([component_count, result.shape[1]])
            data[i, :] = result
        return data

    def locate(name):
        path = "{}/{}.sqlite3".format(constant.WORKLOAD_ROOT, name)
        assert(os.path.exists(path))
        return path

    def enumerate(name):
        path = "{}/{}/*.sqlite3".format(constant.WORKLOAD_ROOT, name)
        return glob.glob(path)

def read_components(path):
    result = Database.execute(path, 'SELECT DISTINCT component_id FROM dynamic')
    return [int(id) for id in np.sort(np.array(result).flatten())]
