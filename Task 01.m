A = [ 1 5 3 7
      2 6 4 8
      4 3 2 1 ];
disp(A);

% 1) Assign the even-numbered columns of A to B
B = A(:, 2:2:end);
disp('Even-numbered columns (B):');
disp(B);

% 2) Assign the odd-numbered rows of A to C
C = A(1:2:end, :);
disp('Odd-numbered rows (C):');
disp(C);

% 3) Convert A into a 4-by-3 array
D = reshape(A, 4, 3);
disp('Reshaped A (4x3):');
disp(D);

% 4) Compute the reciprocal of each element of A
E = 1 ./ A;
disp('Reciprocal of A:');
disp(E);

% 5) Compute the square root of each element of A
% A.^(1/2) is mathematically equivalent to sqrt(A)
F = A.^(1/2);
disp('Square root of A:');
disp(F);
