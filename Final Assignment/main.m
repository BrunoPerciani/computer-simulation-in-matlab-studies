%% 1. Settings and Parameters
slot_length = 1;
total_slots = 180;

% Number of Monte Carlo simulations
num_runs = 10000;

% Base schedules
bus_interval = 6;

base_b_arrive = ...
    [53, 64:bus_interval:136, 140, 144, 152, 158, 165, 180];

t_arrive = ...
    [50 61 71 79 90 96 108 117 ...
     121 133 137 141 149 155 162 168 178];

% Train parameters
train_params = struct(...
    'mean_early', 130, ...
    'std_early',   30, ...
    'mean_late',   85, ...
    'std_late',    10, ...
    'cutoff_time', 120, ...
    'walk_rate', 0.10);

%% 2. Random Number Settings

% Fix the sequence of random numbers for reproducibility
% Set this only once, outside the repetition loop
rng(1);

%% 3. Storage for Simulation Results

% Each row represents one simulation
% Each column represents one minute
all_queue_histories = zeros(num_runs, total_slots + 1);

remaining_students = zeros(num_runs, 1);
transported_students = zeros(num_runs, 1);
average_wait_times = zeros(num_runs, 1);
maximum_wait_times = zeros(num_runs, 1);
maximum_queue_lengths = zeros(num_runs, 1);

%% 4. Monte Carlo Simulation

for run = 1:num_runs

    [queue_history, result] = run_single_simulation(...
        base_b_arrive, ...
        t_arrive, ...
        train_params, ...
        total_slots);

    % Store queue length at every minute
    all_queue_histories(run, :) = queue_history;

    % Store performance measures
    remaining_students(run) = result.remaining_students;
    transported_students(run) = result.transported_students;
    average_wait_times(run) = result.average_wait_time;
    maximum_wait_times(run) = result.maximum_wait_time;
    maximum_queue_lengths(run) = result.maximum_queue_length;
end

%% 5. Calculate Statistics

% Average queue length at each minute
mean_queue = mean(all_queue_histories, 1);


time = 0:slot_length:total_slots;

%% 6. Display Summary Results

fprintf('\n');
fprintf('========== Monte Carlo Simulation Results ==========\n');
fprintf('Number of simulations: %d\n', num_runs);

fprintf('\n--- Average values ---\n');
fprintf('Transported students: %.2f\n', ...
        mean(transported_students));
fprintf('Students remaining at 10:00: %.2f\n', ...
        mean(remaining_students));
fprintf('Average wait time: %.2f minutes\n', ...
        mean(average_wait_times));
fprintf('Maximum wait time: %.2f minutes\n', ...
        mean(maximum_wait_times));
fprintf('Maximum queue length: %.2f students\n', ...
        mean(maximum_queue_lengths));

fprintf('\n--- Standard deviations ---\n');
fprintf('Transported students: %.2f\n', ...
        std(transported_students));
fprintf('Students remaining at 10:00: %.2f\n', ...
        std(remaining_students));
fprintf('Average wait time: %.2f minutes\n', ...
        std(average_wait_times));
fprintf('Maximum wait time: %.2f minutes\n', ...
        std(maximum_wait_times));
fprintf('Maximum queue length: %.2f students\n', ...
        std(maximum_queue_lengths));

%% 7. Plot Results

plot_simulation_results(...
    time, ...
    mean_queue, ...
    num_runs);