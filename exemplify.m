function exemplify(names)
  setup;
  count = length(names);
  Plot.figure(1000, count * 200);
  for i = 1:count
    [data, ~] = aggregate(locate(names{i}), 'dynamic_power');
    data = reshape(data(1, 1:50000), 25, 2000);
    data = data(1, :);
    subplot(count, 1, i);
    plot(data);
    Plot.limit([0, length(data)], [0, 15]);
    set(gca,'xtick', [])
    set(gca,'xticklabel', [])
  end
end
