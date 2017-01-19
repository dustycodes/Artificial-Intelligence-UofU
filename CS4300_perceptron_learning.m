function [ w, per_cor ] = CS4300_perceptron_learning( X,y, alpha,...
    max_iter, rate )
% CS4300_perceptron_learning - find linear separating hyperplane
% On input:
%   X (nxm array): n independent variable samples each of length m
%   y (nx1 vector): dependent variable samples
%   alpha (float): learning rate
%   max_iter (int): max number of iterations
%   rate (Boolean): if 1 then alpha = 1000/(1000+iter), else
%       constant
% On output:
%   w (m+1x1 vector): weights for linear function
%   per_cor (kxm+1 array): trace of percentage correct with weight
% Call:
%   [w,pc] = CS4300_perceptron_learning(X,y,0.1,10000,0);
% Author:
%   Dusty & Scott
%   UU
%   Fall 2016
%

done = false;
i = 0;
[num_samples, dim_x] = size(X);

w = 0.1*rand(dim_x + 1, 1);

while ~done
    i = i + 1;

    if(rate)
        alpha = 1000/(1000+i);
    end    
    h = ([ones(num_samples,1),X] * w) >= 0;
    
    per_corI = sum(y == reshape(h,size(y)))/ length(y);
    
    per_cor(i) = per_corI;
    
    if (per_corI == 1) || (i == max_iter)
        done = true;
    
    else
        index = randi(num_samples);
        x = [1, X(index,:)];
        
        
        for j = 1 : length(w)
            w(j) = w(j) + alpha*(y(index) - h(index)) * x(j);
         
            
        end
        
    end

    
    

end


end

