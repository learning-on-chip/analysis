function exemplify()
  setup;
  prefix = 'reference/workload/gainestown/cpu2006/large/';
  files = { ...
      [prefix, 'astar.sqlite3'], ...
      [prefix, 'GemsFDTD.sqlite3'], ...
      [prefix, 'bwaves.sqlite3'], ...
      [prefix, 'wrf.sqlite3'] ...
  };
  Plot.figure(1000, 700);
  count = length(files);
  for i = 1:count
    [data, ~] = aggregate(files{i}, 'dynamic_power');
    data = reshape(data(1, 1:50000), 25, 2000);
    data = data(1, :);
    subplot(count, 1, i);
    plot(data);
    Plot.limit([0, length(data)], [0, 15]);
    set(gca,'xtick', [])
    set(gca,'xticklabel', [])
  end
end