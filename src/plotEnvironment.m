function plotEnvironment(env)
% PLOTENVIRONMENT Displays the environment, obstacles, start and goal.

    figure; hold on; axis equal;
    xlim([env.xMin env.xMax]);
    ylim([env.yMin env.yMax]);
    grid on;
    box on;

    title('2D Environment');
    xlabel('X');
    ylabel('Y');

    % Draw rectangular obstacles
    for i = 1:size(env.rects,1)
        rectangle('Position', env.rects(i,:), ...
                  'FaceColor', [0.3 0.3 0.3], ...
                  'EdgeColor', 'k');
    end

    % Draw circular obstacles
    theta = linspace(0, 2*pi, 100);
    for i = 1:size(env.circles,1)
        xc = env.circles(i,1);
        yc = env.circles(i,2);
        r  = env.circles(i,3);
        x = xc + r*cos(theta);
        y = yc + r*sin(theta);
        fill(x, y, [0.3 0.3 0.3], 'EdgeColor', 'k');
    end

    % Draw start and goal
    plot(env.start(1), env.start(2), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
    plot(env.goal(1), env.goal(2), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);


end