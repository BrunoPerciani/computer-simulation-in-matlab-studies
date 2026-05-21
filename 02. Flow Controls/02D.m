% Keep running the script until the user provides no input
while true

    % Ask the user to enter a temperature in Fahrenheit
    F = input('Enter temperature in Fahrenheit: ');

    % Check if the input is empty
    % If no value is entered, stop the loop
    if isempty(F)
        disp('Program terminated.');
        break;
    end

    % Convert Fahrenheit to Celsius
    C = (F - 32) * 5 / 9;

    % --------------------------------------------------
    % Display the result
    % num2str() converts the number into text for display
    disp([num2str(F) ' Fahrenheit = ' num2str(C) ' Celsius']);

end
