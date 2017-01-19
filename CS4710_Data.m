M = csvread('goodtakeoff1.txt');
roll = M(:,1);
pitch = M(:,2);
yaw = M(:,3);
throttle = M(:,4);

clf;

plot(1:length(throttle), throttle, 'r');
hold on;
%plot(1:length(pitch), pitch, '*');
%plot(1:length(roll), roll, '+');
plot(1:length(yaw), yaw, '-');


