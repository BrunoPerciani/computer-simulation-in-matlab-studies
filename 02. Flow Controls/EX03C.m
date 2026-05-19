% Practice 3)

% Create a 3x6 array of random numbers between 0 and 1
% rand(rows, columns)
A = rand(3, 6);

% Move through the array element by element
% If the value is less than 0.5, assign 0
% If the value is greater than or equal to 0.5, assign 1

for i = 1:size(A, 1)          % Loop through rows
    for j = 1:size(A, 2)      % Loop through columns
        
        if A(i, j) < 0.5
            A(i, j) = 0;
        else
            A(i, j) = 1;
        end
        
    end
end

% Display the modified array
disp('Modified array:');
disp(A);