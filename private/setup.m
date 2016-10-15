function setup()
  addpath('vendor/sqlite3');
  try
    use('Interaction');
  catch
    warning('Clone MathRocks (https://github.com/MathRocks/MathRocks) and add it to your path.');
  end
end
