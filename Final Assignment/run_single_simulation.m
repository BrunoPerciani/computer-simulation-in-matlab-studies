function [queue_history, result] = run_single_simulation(...
    base_b_arrive, t_arrive, train_params, total_slots)

    %% 1. Dynamic Bus Configuration

    num_buses = length(base_b_arrive);

    % Generate different capacities and delays for each simulation
    bus_capacities = randi([70, 80], 1, num_buses);
    bus_delays = randi([0, 5], 1, num_buses);

    % Ensure the last bus does not exceed the simulation limit
    bus_delays(end) = 0;

    % Final bus arrival schedule
    b_arrive = min(...
        base_b_arrive + bus_delays, ...
        total_slots);

    %% 2. Pre-compute Bus Capacity by Minute

    slot_bus_capacity = zeros(1, total_slots + 1);

    for i = 1:num_buses
        idx = b_arrive(i) + 1;

        % Combine capacities if multiple buses arrive
        % at the same minute
        slot_bus_capacity(idx) = ...
            slot_bus_capacity(idx) + bus_capacities(i);
    end

    %% 3. Pre-compute Train Arrival Schedule

    is_train_arrival = false(1, total_slots + 1);
    is_train_arrival(t_arrive + 1) = true;

    %% 4. Initialize Simulation

    student_arrivals = [];
    queue_history = zeros(1, total_slots + 1);

    total_wait_time = 0;
    transported_students_total = 0;
    max_wait_time = 0;

    %% 5. Main Simulation Loop

    for slot = 0:total_slots

        % Train arrival
        if is_train_arrival(slot + 1)
            student_arrivals = train_arrive(...
                slot, ...
                student_arrivals, ...
                train_params);
        end

        % Bus arrival
        current_capacity = slot_bus_capacity(slot + 1);

        if current_capacity > 0
            [student_arrivals, ...
             total_wait_time, ...
             transported_students_total, ...
             max_wait_time] = bus_arrive(...
                slot, ...
                student_arrivals, ...
                current_capacity, ...
                total_wait_time, ...
                transported_students_total, ...
                max_wait_time);
        end

        % Record the queue length
        queue_history(slot + 1) = ...
            length(student_arrivals);
    end

    %% 6. Calculate Results

    if transported_students_total > 0
        avg_wait_time = ...
            total_wait_time / transported_students_total;
    else
        avg_wait_time = 0;
    end

    result.remaining_students = ...
        length(student_arrivals);

    result.transported_students = ...
        transported_students_total;

    result.average_wait_time = ...
        avg_wait_time;

    result.maximum_wait_time = ...
        max_wait_time;

    result.maximum_queue_length = ...
        max(queue_history);
end


function student_arrivals = train_arrive(...
    slot, student_arrivals, params)

    if slot < params.cutoff_time
        mu = params.mean_early;
        sigma = params.std_early;
    else
        mu = params.mean_late;
        sigma = params.std_late;
    end

    % Number of all students arriving at the station
    new_students = round(mu + sigma * randn);
    new_students = max(0, new_students);

    % Each student chooses whether to walk
    walking_students = ...
        sum(rand(1, new_students) < params.walk_rate);

    % Only non-walking students join the bus queue
    queue_students = new_students - walking_students;

    % Store arrival times of students joining the queue
    student_arrivals = ...
        [student_arrivals, ...
         repmat(slot, 1, queue_students)];
end


function [student_arrivals, total_wait, ...
          transported_count, max_wait] = bus_arrive(...
    slot, ...
    student_arrivals, ...
    bus_capacity, ...
    total_wait, ...
    transported_count, ...
    max_wait)

    transported_students = ...
        min(length(student_arrivals), bus_capacity);

    if transported_students > 0

        % FIFO: the earliest students board first
        boarding_students = ...
            student_arrivals(1:transported_students);

        % Calculate wait times
        wait_times = slot - boarding_students;

        % Update statistics
        total_wait = ...
            total_wait + sum(wait_times);

        transported_count = ...
            transported_count + transported_students;

        max_wait = ...
            max(max_wait, max(wait_times));

        % Remove transported students
        student_arrivals(1:transported_students) = [];
    end
end