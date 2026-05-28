% Practice 6.2

% Define the file name
fileName = 'Characters.txt';

% Open the file in write mode
fileID = fopen(fileName, 'w');

% Write data into the file
% fprintf writes formatted data to the file
fprintf(fileID, 's 115\n');
fprintf(fileID, 'h 104\n');
fprintf(fileID, 'i 105\n');
fprintf(fileID, 'b 98\n');
fprintf(fileID, 'a 97\n');
fprintf(fileID, 'u 117\n');
fprintf(fileID, 'r 114\n');
fprintf(fileID, 'A 65\n');

% Close the file after writing
fclose(fileID);

% Open the file in read mode
fileID = fopen(fileName, 'r');

% Display file contents line by line using fgetl()
disp('Reading file using fgetl():');

line = fgetl(fileID);

while ischar(line)

    % Display the current line
    disp(line);

    % Read the next line
    line = fgetl(fileID);

end

% Close the file
fclose(fileID);

% Open the file again for fscanf()
fileID = fopen(fileName, 'r');

% Read formatted data using fscanf()
% %c reads characters
% %d reads integers
data = fscanf(fileID, '%c %d', [2 Inf]);

% Display data read with fscanf()
disp('Reading file using fscanf():');
disp(data);

% Close the file
fclose(fileID);