function points = sampleFreePoints(n, env)
% SAMPLEFREEPOINTS Generates n random points in free space.

    points = zeros(n, 2);
    count = 0;

    while count < n
        x = env.xMin + (env.xMax - env.xMin) * rand();
        y = env.yMin + (env.yMax - env.yMin) * rand();

        if ~isPointInCollision([x, y], env)
            count = count + 1;
            points(count, :) = [x, y];
        end
    end
end