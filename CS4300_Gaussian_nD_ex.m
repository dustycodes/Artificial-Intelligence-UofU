function d = CS4300_Gaussian_nD_ex(sigma2_x,sigma2_y)
% CS4300_Gaussian_nD_ex - example of n-dim Gaussian
% On input:
%     sigma2_x (float): variance of x
%     sigma2_y (float): variance of y
% On output:
%     d (kxk array): probabilities of vectors in x = [-1:1], and
%         y = [-1,1] square of plane
% Call:
%     d = CS4300_Gaussian_nD_ex(1,3);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

mu = [0;0];
Sigma = eye(2,2);
Sigma(1,1) = sigma2_x;
Sigma(2,2) = sigma2_y;
x_vals = [-1:0.1:1];
y_vals = [-1:0.1:1];
num_vals = length(x_vals);
d = zeros(num_vals,num_vals);

for r = 1:num_vals
    x = x_vals(r);
    for c = 1:num_vals
        y = y_vals(c);
        d(r,c) = CS4300_Gaussian_nD([x;y],mu,Sigma);
    end
end