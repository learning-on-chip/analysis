function show(name)
  setup;
  [data, ~] = aggregate(locate(name), 'dynamic_power');
  [units, steps] = size(data);
  Plot.figure(1000, units * 200);
  for i = 1:units
    subplot(units, 1, i);
    plot(data(i, :), 'LineWidth', 1);
    Plot.limit([0, steps]);
    set(gca,'xtick', [])
    set(gca,'xticklabel', [])
  end
end
