function collision = isPointInCollision(pt, env)
% ISPOINTINCOLLISION Returns true if point pt is inside an obstacle
% or outside the environment bounds.

    x = pt(1);
    y = pt(2);

    % Outside bounds
    if x < env.xMin || x > env.xMax || y < env.yMin || y > env.yMax
        collision = true;
        return;
    end

    % Check rectangular obstacles
    for i = 1:size(env.rects,1)
        rect = env.rects(i,:);
        xr = rect(1);
        yr = rect(2);
        w  = rect(3);
        h  = rect(4);

        if x >= xr && x <= xr + w && y >= yr && y <= yr + h
            collision = true;
            return;
        end
    end

    % Check circular obstacles
    for i = 1:size(env.circles,1)
        xc = env.circles(i,1);
        yc = env.circles(i,2);
        r  = env.circles(i,3);

        if (x - xc)^2 + (y - yc)^2 <= r^2
            collision = true;
            return;
        end
    end

    collision = false;
end