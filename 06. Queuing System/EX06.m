% Queueing System Simulation

% Number of customers
numCustomers = 1000;

% Average inter-arrival time
% 10 customers per minute => mean inter-arrival time = 0.1 minute
meanArrival = 0.1;

% Average service time
% 2 minutes per customer
meanService = 2;

% --------------------------------------------------
% Test different numbers of servers
for servers = 1:100

    % Generate inter-arrival times using an exponential distribution
    interArrival = -meanArrival * log(rand(numCustomers,1));

    % Generate arrival times
    arrivalTime = cumsum(interArrival);

    % Assume the first customer arrives at time 0
    arrivalTime = arrivalTime - arrivalTime(1);

    % Generate service times using an exponential distribution
    serviceTime = -meanService * log(rand(numCustomers,1));

    % Store waiting times
    waitingTime = zeros(numCustomers,1);

    % Store the finish time of each server
    serverFinish = zeros(servers,1);

    % --------------------------------------------------
    % Simulate customer arrivals and service
    for i = 1:numCustomers

        % Find the server that becomes available first
        [nextFreeTime, serverIndex] = min(serverFinish);

        % Calculate waiting time
        waitingTime(i) = max(0, nextFreeTime - arrivalTime(i));

        % Determine when service begins
        startService = max(arrivalTime(i), nextFreeTime);

        % Update the finish time of the selected server
        serverFinish(serverIndex) = startService + serviceTime(i);

    end

    % --------------------------------------------------
    % Compute the average waiting time
    averageWait = mean(waitingTime);

    % Display results for each number of servers
    fprintf('Servers: %d | Average waiting time: %.4f minutes\n', ...
        servers, averageWait);

    % --------------------------------------------------
    % Stop when the average waiting time is less than 5 minutes
    if averageWait < 5

        disp(' ');
        disp(['Optimal number of servers: ' num2str(servers)]);
        disp(['Average waiting time: ' num2str(averageWait) ' minutes']);

        break;

    end

end
