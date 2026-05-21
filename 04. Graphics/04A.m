% Generate average monthly temperatures only once
% Random integer values between 20 and 30 degrees Celsius
temps = randi([20 30], 1, 12);

% Create a vector with the months of the year
months = 1:12;

% Keep running until the user chooses to stop
while true

    % Display menu options
    disp(' ');
    disp('Press 1 to display the highest temperature');
    disp('Press 2 to display the lowest temperature');
    disp('Press 3 to display all temperatures');
    disp('Press 0 to exit');

    % Ask the user to choose an option
    choice = input('Enter your choice: ');

    % Use switch to check the selected option
    switch choice

        case 1
            % Find the highest temperature
            highest = max(temps);

            % Display the result
            disp(['Highest temperature: ' num2str(highest)]);

            % Plot all temperatures
            figure;
            plot(months, temps, '-o');

            % Add labels and title
            title('Monthly Average Temperatures');
            xlabel('Month');
            ylabel('Temperature (°C)');
            grid on;

            % Highlight the highest temperature
            hold on;
            plot(find(temps == highest), highest, 'r*');
            hold off;

        case 2
            % Find the lowest temperature
            lowest = min(temps);

            % Display the result
            disp(['Lowest temperature: ' num2str(lowest)]);

            % Plot all temperatures
            figure;
            plot(months, temps, '-o');

            % Add labels and title
            title('Monthly Average Temperatures');
            xlabel('Month');
            ylabel('Temperature (°C)');
            grid on;

            % Highlight the lowest temperature
            hold on;
            plot(find(temps == lowest), lowest, 'r*');
            hold off;

        case 3
            % Display all temperatures
            disp('All temperatures:');
            disp(temps);

            % Plot all temperatures
            figure;
            plot(months, temps, '-o');

            % Add labels and title
            title('Monthly Average Temperatures');
            xlabel('Month');
            ylabel('Temperature (°C)');
            grid on;

        case 0
            % Exit the loop
            disp('Program terminated.');
            break;

        otherwise
            % Display message for invalid input
            disp('Invalid option.');

    end

end
