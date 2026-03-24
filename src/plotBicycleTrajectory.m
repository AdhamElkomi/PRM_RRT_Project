function plotBicycleTrajectory(trajectory, figureTitle)
% PLOTBICYCLETRAJECTORY Plots x-y trajectory of the bicycle model.

    figure;
    plot(trajectory(:,1), trajectory(:,2), 'b-', 'LineWidth', 2);
    hold on;
    plot(trajectory(1,1), trajectory(1,2), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
    plot(trajectory(end,1), trajectory(end,2), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

    axis equal;
    grid on;
    xlabel('x');
    ylabel('y');
    title(figureTitle);
    legend('Trajectory', 'Start', 'End');
end