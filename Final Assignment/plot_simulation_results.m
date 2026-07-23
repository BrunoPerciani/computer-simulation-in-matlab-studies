function plot_simulation_results(time, mean_queue, num_runs)

    figure;

    plot(...
        time, ...
        mean_queue, ...
        'LineWidth', 2);

    title(sprintf(...
        'Average Queue Length over %d Simulations', ...
        num_runs));

    xlabel('Time after 7:00 (minutes)');
    ylabel('Average Number of Students in Queue');

    grid on;
    xlim([0, max(time)]);
    ylim([0, max(mean_queue) * 1.05]);
end