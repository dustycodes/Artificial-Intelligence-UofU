function [ res ] = CS4300_Net_Driver( to_remove  )
%CS4300_IMAGE_PROCESSING Summary of this function goes here
%   Detailed explanation goes here

path(path, 'Z:\Repositories\ai-matlab');
load('G');
load('P');
load('W');

im_iterator = 1:9;
if to_remove ~= 0
    im_iterator(to_remove) = [];
end
% used = [];
% for i = 1:to_remove
%     r = randi(9);
%     while find(used, r)
%         r = randi(9);
%     end
%     
%     im_iterator(r) = [];
%     used = [used, r];
% end

for i = im_iterator
    im = G(i).im;
    im = im > 100;
    im =  imresize(im,[15,15]);
    X(i,:) = im(:);
    y(i)  = 1;
end

for i = im_iterator
    im = P(i).im;
    im = im > 100;
    im =  imresize(im,[15,15]);
    X(i+9,:) = im(:);
    y(i+9)  = 2;
end

for i = im_iterator
    im = W(i).im;
    im = im > 100;
    im =  imresize(im,[15,15]);
    X(i+18,:) = im(:);
    y(i+18)  = 3;
end
% 1 is gold,2= pit, 3 = wumpus
[res, pc1] = CS4300_perceptron_learning(X,y == 1,0.1,250, 0);


[res, pc2] = CS4300_perceptron_learning(X,y == 2,0.1,250, 0);


[res, pc3] = CS4300_perceptron_learning(X,y == 3,0.1,250, 0);

subplot(3,1,1);
plot(pc1);
title(strcat(num2str(to_remove), ' Image Removed, Percentage correct'));
ylabel('Gold');
subplot(3,1,2);
plot(pc2);
ylabel('Pit');
subplot(3,1,3);
plot(pc3);
xlabel('weights');
ylabel('Wumpus');


end

