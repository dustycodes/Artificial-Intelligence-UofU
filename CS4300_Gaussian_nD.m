function p = CS4300_Gaussian_nD(x,mu,Sigma)
% CS4300_Gaussian_nD - nD Gaussian distribution
% On input:
%     x (nx1 vector): a n-dimensional vector
%     mu (nx1 vector): mean of distribution
%     Sigma (nxn array): variance of distribution
% On output:
%     p (float): probability of sampling value x from distribution
% Call:
%     p = CS4300_Gaussian_nD([0.3;0.8],[0;0],eye(2,2));
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

p = det(2*pi*Sigma)^(-1/2)*exp((-1/2)*(x-mu)'*inv(Sigma)*(x-mu));