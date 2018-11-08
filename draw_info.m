function draw_info(config, info)
N = length(info.D);
for i=1:N
    x = info.X(i);
    y = info.Y(i);
    d = info.D(i);
    nx = info.Nx(i)*d;
    ny = info.Ny(i)*d;
    o = info.O(i,:);
    
    if(d<0.01)
        
        x1 = config.X(o(1) );
        y1 = config.Y(o(1) );
        x2 = config.X(o(2) );
        y2 = config.Y(o(2) );
        
        circle( [ x y], 1.0, 100, 'm-' );
        plot( [x x+nx], [y y+ny], 'r', 'LineWidth', 2 );
        plot( [x1 x2], [y1 y2] , 'g', 'LineWidth', 1);
    end
end
end

