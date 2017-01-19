function p = CS4300_Gaussian_1D(x,mu,sigma2)
% CS4300_Gaussian_1D - 1D Gaussian distribution
% On input:
%     x (float): a real number
%     mu (float): mean of distribution
%     sigma2 (float): variance of distribution
% On output:
%     p (float): probability of sampling value x frm distribution
% Call:
%     p = CS4300_Gaussian_1D(0.3,0,1);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

p = (2*pi*sigma2)^(-1/2)*exp((-1/2)*(x-mu).^2/sigma2);