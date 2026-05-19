function negativeNumber = getNegativeNumber()

% Keep asking the user for a number until
% a negative value is entered

while true

    % Ask the user to enter a number
    number = input('Enter a negative number: ');

    % Check if the number is negative
    if number < 0

        % Store the negative number
        negativeNumber = number;

        % Display confirmation message
        disp(['Accepted number: ' num2str(negativeNumber)]);

        % Exit the loop
        break;

    else
        % Display error message if the number is not negative
        disp('Error: the number must be negative.');

    end

end

end
