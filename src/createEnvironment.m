function env = createEnvironment()
% CREATEENVIRONMENT Creates a 2D environment with bounds, obstacles,
% start point and goal point.

    env.xMin = 0;
    env.xMax = 100;
    env.yMin = 0;
    env.yMax = 100;

    % Start and goal
    env.start = [10, 10];
    env.goal  = [90, 90];

    % Rectangular obstacles
    % Each row: [x y width height]
    env.rects = [
        20 20 15 40;
        50 10 10 50;
        70 60 20 10;
        30 75 25 10
    ];

    % Circular obstacles
    % Each row: [xc yc r]
    env.circles = [
        65 35 8;
        45 60 7
    ];
end