% This file generates an WS graph and does some subsequent computation.
% TO DO: conduct multiple experiments and plot the average value to
% eliminate uncertainty

% Clear result of last computation
clear;
clc;
%%
% Value assignment
N = 500;
k= 12;
p = 0.1 ;

u = ones(500, 1); % an all-one vector with 500 rows and 1 column
num_simulation = 500;
% Define 3 cells to store arrays
Deg_bin = cell(num_simulation,1);
Deg_org = cell(num_simulation,1);
eigen_Q = cell(num_simulation,1);

%% Plot distribution of degree and eigenvalues for 1 WS graph
A = small_world(N, k, p);
Deg = A * u; % Deg is also 500-by-1
   
% Compute the Laplacian matrix and its eigenvalues
sorted_Deg = sort(Deg);
diag_matrix = diag(Deg);
Q1 = diag_matrix - A;
eigen_Q1 = eig(Q1);
        
%plot
plot(sorted_Deg);
hold on;
plot(eigen_Q1);
xlabel('k');
ylabel('Degree and the Laplacian eigenvalues');
title('The degree vector and the Laplacian eigenvalues of a graph (WS)');
legend('Ordered degree d_{(k)}','Laplacian eigenvalues u_{(k)}');
hold off;


%% Computation with 100000 random graph for both Degree and Eigenvalue
%Store all data in the cell, including unique array, and the original value
for i = 1:1:num_simulation
    % Generate the WS graph
    A = small_world(N, k, p);
    Deg = A * u; % Deg is also 500-by-1
    Diag_matrix = diag(Deg);
    Q = Diag_matrix - A;
    eigen_Q(i,1) = {eig(Q)};
    Deg_org(i,1) = {Deg};
    Deg_bin(i,1) = {unique(Deg)};
end

% compute all unique value from all data, and hist data
Deg_all = unique(cell2mat(Deg_bin));
Deg_hist = hist(cell2mat(Deg_org), Deg_all);

% Plots
figure
plot(Deg_all, Deg_hist/(N*num_simulation),'-o'); % divided by N to show probability
hold on;

% Laplacian eigenvalues distribution
rounded_eigen_Q = round(cell2mat(eigen_Q));
rounded_eigen_Q_bin = unique(rounded_eigen_Q);
rounded_eigen_Q_hist = hist(rounded_eigen_Q, rounded_eigen_Q_bin);

plot(rounded_eigen_Q_bin, rounded_eigen_Q_hist/(N*num_simulation),'-*' ); % divided by N to show probability
xlabel('x');
ylabel('f_u(x)');
title('The distribution of degrees and Laplacian eigenvalues (WS)');
legend('degree','Laplacian eigenvalues');
hold off;