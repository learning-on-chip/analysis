function [data, ids] = aggregate(file, column)
  result = query(file, 'SELECT DISTINCT component_id FROM dynamic');
  ids = sort([result.component_id]);
  time = [];
  data = [];
  for id = ids
    result = query(file, ['SELECT time, ', column, ' FROM dynamic ', ...
                          'WHERE component_id = ? ORDER BY time'], id);
    if ~isempty(time)
      assert(norm(time - [result.time]) == 0);
    else
      time = [result.time];
    end
    data = [data; [result.(column)]];
  end
end

function result = query(file, code, varargin)
  db = sqlite3.open(file);
  result = sqlite3.execute(db, code, varargin{:});
  sqlite3.close(db);
end
