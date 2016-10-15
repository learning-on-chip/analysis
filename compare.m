function compare(names)
  setup;
  unit_id = 1;
  count = length(names);
  Plot.figure(1000, count * 200);
  for i = 1:count
    [data, ~] = aggregate(locate(names{i}), 'dynamic_power');
    time = 1e-3 * (0:(size(data, 2) - 1));
    subplot(count, 1, i);
    Plot.line(time, data(unit_id, :), 'style', {'LineWidth', 1});
    Plot.limit(time);
    Plot.label('Time (s)', 'Power (W)');
  end
end
