% Create a random integer vector with 10 elements
% Values range from 2 to 28
% randi([min max], rows, columns)
A = randi([2 28], 1, 10);

% Sort the vector in ascending order
% sort() returns the elements ordered from smallest to largest
B = sort(A);

% Display results
disp('Original random vector:');
disp(A);

disp('Sorted vector in ascending order:');
disp(B);
