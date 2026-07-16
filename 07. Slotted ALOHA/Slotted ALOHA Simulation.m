% Slotted ALOHA Simulation

clear;
clc;

% --------------------------------------------------
% Simulation parameters

simulationTime = 24;          % Total simulation time (hours)
slotLength = 0.01;            % Length of one time slot (hours)

arrivalRate = 10;             % Users arriving per hour
meanArrival = 1 / arrivalRate;

meanStay = 0.5;               % Average connection time (hours)

% --------------------------------------------------
% Generate user arrivals

arrivalTimes = [];
currentTime = 0;

while currentTime < simulationTime

    % Generate the next inter-arrival time
    interArrival = -meanArrival * log(rand());

    currentTime = currentTime + interArrival;

    if currentTime < simulationTime
        arrivalTimes = [arrivalTimes currentTime];
    end

end

% --------------------------------------------------
% Generate user departure times

numUsers = length(arrivalTimes);

stayTimes = -meanStay * log(rand(1, numUsers));

departureTimes = arrivalTimes + stayTimes;

% --------------------------------------------------
% Part 1
% Throughput versus time when p = 0.3

p = 0.3;

timeVector = 0:slotLength:simulationTime;
throughput = zeros(size(timeVector));

for t = 1:length(timeVector)

    currentSlot = timeVector(t);

    % Find users connected during this slot
    activeUsers = (arrivalTimes <= currentSlot) & ...
                  (departureTimes > currentSlot);

    numberOfUsers = sum(activeUsers);

    successfulTransmission = 0;

    if numberOfUsers > 0

        transmissions = rand(1, numberOfUsers) < p;

        if sum(transmissions) == 1
            successfulTransmission = 1;
        end

    end

    throughput(t) = successfulTransmission;

end

% Compute cumulative average throughput
averageThroughput = cumsum(throughput) ./ (1:length(throughput));

% --------------------------------------------------
% Plot average throughput versus time

figure;

plot(timeVector, averageThroughput, 'LineWidth',2);

title('Average Throughput vs Time (p = 0.3)');
xlabel('Time (hours)');
ylabel('Average Throughput');

grid on;

% --------------------------------------------------
% Part 2
% Throughput versus access probability

pValues = 0.1:0.1:0.9;

averageResults = zeros(size(pValues));

for k = 1:length(pValues)

    p = pValues(k);

    throughput = zeros(size(timeVector));

    for t = 1:length(timeVector)

        currentSlot = timeVector(t);

        activeUsers = (arrivalTimes <= currentSlot) & ...
                      (departureTimes > currentSlot);

        numberOfUsers = sum(activeUsers);

        successfulTransmission = 0;

        if numberOfUsers > 0

            transmissions = rand(1, numberOfUsers) < p;

            if sum(transmissions) == 1
                successfulTransmission = 1;
            end

        end

        throughput(t) = successfulTransmission;

    end

    averageResults(k) = mean(throughput);

end

% --------------------------------------------------
% Plot average throughput versus p

figure;

plot(pValues, averageResults,'-o','LineWidth',2);

title('Average Throughput vs Access Probability');
xlabel('Access Probability (p)');
ylabel('Average Throughput');

grid on;

% --------------------------------------------------
% Display results

disp('Average Throughput for each value of p');

for k = 1:length(pValues)

    fprintf('p = %.1f   Average Throughput = %.4f\n', ...
        pValues(k), averageResults(k));

end
