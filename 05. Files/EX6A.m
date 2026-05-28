% Define the file name
fileName = 'Test.txt';

% Try to open the file in read mode
% fopen returns -1 if the file does not exist
fileID = fopen(fileName, 'r');

% Check whether the file exists or not
if fileID == -1

    % Display message if the file does not exist
    disp('File does not exist.');

else

    % Display message if the file exists
    disp('File opened successfully.');

    % Close the file
    status = fclose(fileID);

    % Check whether the file closed successfully
    % fclose returns 0 if successful
    if status == 0
        disp('File closed successfully.');
    else
        disp('Error while closing the file.');
    end

end
