function summarize(suite)
  setup;
  if nargin < 1, suite = 'parsec'; end
  prefix = ['reference/workload/gainestown/', suite, '/'];
  files = [
    list([prefix, 'small']) ...
    list([prefix, 'medium']) ...
    list([prefix, 'large']) ...
  ];
  fprintf('%-20s %5s %10s\n', 'Benchmark', 'Units', 'Time, s');
  cores = zeros(length(files), 1);
  cache = zeros(length(files), 1);
  for i = 1:length(files)
    [data, ~] = aggregate(files{i}, 'dynamic_power');
    [units, steps] = size(data);
    name = strrep(files{i}, prefix, '');
    name = strrep(name, '.sqlite3', '');
    fprintf('%-20s %5d %10.2f', name, units, 1e-3 * steps);
    total = sum(data(:));
    index = 1:(units - max(1, floor(units / 4)));
    for j = 1:units
      local = sum(data(j, :));
      fprintf(' %10.2e (%5.2f%%)', local, 100 * local / total);
      if ismember(j, index)
        cores(i) = cores(i) + local;
      else
        cache(i) = cache(i) + local;
      end
    end
    fprintf('\n');
  end
  scale = cores + cache;
  bar(100 * [cores ./ scale cache ./ scale], 'stacked');
  fprintf('Average contribution of L3s: %.2f%%\n', 100 * mean(cache ./ scale));
  ylim([0, 101]);
end

function names = list(directory)
  files = dir(directory);
  names = {};
  for i = 1:length(files)
    if regexp(files(i).name, '.*sqlite3', 'ONCE')
      names{end + 1} = sprintf('%s/%s', directory, files(i).name);
    end
  end
end
