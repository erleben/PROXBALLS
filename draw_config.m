function draw_config(config)
N = length(config.R);
for i=1:N
    x = config.X(i);
    y = config.Y(i);
    r = config.R(i);
    circle( [ x y], r, 100 );
end
end

