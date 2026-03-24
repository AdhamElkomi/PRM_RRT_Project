function plotFeasibleKinematicRRT(env, nodes, edgeTraj, path)
% PLOTFEASIBLEKINEMATICRRT Displays the feasible kinematic RRT.

    figure; hold on; axis equal;
    xlim([env.xMin env.xMax]);
    ylim([env.yMin env.yMax]);
    grid on; box on;
    xlabel('x');
    ylabel('y');
    title('Feasible Kinematic RRT');

    % Rectangular obstacles
    for i = 1:size(env.rects,1)
        rectangle('Position', env.rects(i,:), ...
                  'FaceColor', [0.3 0.3 0.3], ...
                  'EdgeColor', 'k');
    end

    % Circular obstacles
    theta = linspace(0, 2*pi, 100);
    for i = 1:size(env.circles,1)
        xc = env.circles(i,1);
        yc = env.circles(i,2);
        r  = env.circles(i,3);
        fill(xc + r*cos(theta), yc + r*sin(theta), ...
             [0.3 0.3 0.3], 'EdgeColor', 'k');
    end

    % Tree
    for i = 2:length(edgeTraj)
        traj = edgeTraj{i};
        plot(traj(:,1), traj(:,2), 'b-');
    end

    % Start and goal
    plot(nodes(1,1), nodes(1,2), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
    plot(env.goal(1), env.goal(2), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

    % Final path
    if ~isempty(path)
        plot(path(:,1), path(:,2), 'r-', 'LineWidth', 2.5);
    end
end