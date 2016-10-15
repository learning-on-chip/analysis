function show(name)
  setup;
  [data, ~] = aggregate(locate(name), 'dynamic_power');
  [units, steps] = size(data);
  time = 1e-3 * (0:(steps - 1));
  Plot.figure(1000, units * 200);
  for i = 1:units
    subplot(units, 1, i);
    Plot.line(time, data(i, :), 'style', {'LineWidth', 1});
    Plot.limit(time);
    Plot.label('Time (s)', 'Power (W)');
  end
end
