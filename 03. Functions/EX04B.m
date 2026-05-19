function convertTemperature()

% Ask the user to enter a temperature in Celsius
degreesC = input('Enter temperature in Celsius: ');

% Convert Celsius to Fahrenheit
degreesF = 9/5 * degreesC + 32;

% Convert Celsius to Kelvin
degreesK = degreesC + 273.15;

% Display the converted temperatures
disp(['Temperature in Fahrenheit: ' num2str(degreesF)]);
disp(['Temperature in Kelvin: ' num2str(degreesK)]);

end