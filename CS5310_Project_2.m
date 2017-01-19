upper_cut_start = [-2.75771,0.879738,-0.203636,0.867466,-0.5184,-0.02646,3.04725];
upper_cut_mid =  [-3.0323,1.3127,-0.859796,0.333257,0.234699,1.03275,3.04725];
upper_cut_end =  [-2.75771,0.879738,-0.203636,0.867466,-0.518486,-0.0264612,3.04725];

jab_start =  [-1.94854,2.14566,0.233549,1.01856,0.552617,0.595568,3.04687];
jab_mid =  [-2.45552,0.576393,-0.466714,0.132306,2.71285,0.137291,2.94601];
jab_end = [-1.94854,2.14566,0.233549,1.01856,0.552617,0.595568,3.04687];

colors = ['r','g','b', 'y', 'm', 'c', 'k'];

% Configure this for the timing
t0 = 0;
t1 = 5;
t2 = 10;
step = .1;
% set to 0 for jab
use_upper_cut = 0;



values = zeros(t2,7);
for b = 1:7
    
    if use_upper_cut
        P1 = upper_cut_start(b);
        P2 = upper_cut_mid(b);
        P3 = upper_cut_end(b);
    else
        P1 = jab_start(b);
        P2 = jab_mid(b);
        P3 = jab_end(b);
    end
    syms a2 a3 b1 b2 b3;
    eqn1 = a2*t1.^2 + a3*t1.^3 == P2-P1;
    eqn2 = 2*a2*t1 + 3*a3*t1.^2 - b1 == 0;
    eqn3 = 2*a2 + 6*a3*t1 - 2*b2 == 0;
    eqn4 = b1*(t2-t1) + b2*(t2-t1).^2 + b3*(t2-t1).^3 == P3 - P2;
    eqn5 = b1 + 2*b2*(t2-t1) + 3*b3*(t2-t1).^2 == 0;

%     a0 = P1;
%     a1 = 0;
%     a2 = (P2-P1)/(t1.^2);
%     b0 = P2;
%     b1 = (2*P2-2*P1)/t1;
%     b2 = (P2-P1)/t1.^2;
%     b3 = (P3-P2)/(t2-t1).^3 + (P1-P2)/(t1*(t2-t1).^2) + (P1-P2)/(t1.^2*(t2-t1));

%     a0 = P1;
%     a1 = 0;
%     a2 = -((a0+P2)/(t1.^2));
%     b0 = P2;
%     b1 = 2*a2*t1;
%     b2 = a2;
%     b3 = (P3-b0-b1*(t2-t1)-b2*(t2-t1).^2)/(t2-t1).^3;

    A= [1, 0, 0, 0, 0, 0, 0, 0, P1; 0, 1, 0, 0, 0, 0, 0, 0, 0; 1, t1, t1.^2, t1.^3, 0, 0, 0, 0, P2;
        0, 0, 0, 0, 1, 0, 0, 0, P2; 0, 1, 2*t1, 3*t1.^2, 0, -1, 0, 0, 0; 0, 0, 2, 6*t1, 0, 0, -2, 0, 0;
        0, 0, 0, 0, 1, t2-t1, (t2-t1).^2, (t2-t1).^3, P3; 0, 0, 0, 0, 0, 1, 2*(t2-t1), 3*(t2-t1).^2, 0];

    R = rref(A);
    % M(:,b) = R(:,9)

    a0 = R(1,9);
    a1 = R(2,9);
    a2 = R(3,9);
    a3 = R(4,9);
    b0 = R(5,9);
    b1 = R(6,9);
    b2 = R(7,9);
    b3 = R(8,9);
    arggg = 1;
    for t = t0:step:t1
        x1 = a0 + a1*t + a2*t.^2 + a3*t.^3;
        values(arggg, b) = x1;
        arggg = arggg + 1;
    end
    for t = t1:step:t2
        x2 = b0 + b1*(t-t1) + b2*(t-t1).^2 + b3*(t-t1).^3;
        values(arggg, b) = x2;
        arggg = arggg + 1;
    end
end

[p1,s1] = polyfit(transpose(t0:step:t2+step), values(:,1), 2);
[p2,s2] = polyfit(transpose(t0:step:t2+step), values(:,2), 2);
[p3,s3] = polyfit(transpose(t0:step:t2+step), values(:,3), 2);
[p4,s4] = polyfit(transpose(t0:step:t2+step), values(:,4), 2);
[p5,s5] = polyfit(transpose(t0:step:t2+step), values(:,5), 2);
[p6,s6] = polyfit(transpose(t0:step:t2+step), values(:,6), 2);
[p7,s7] = polyfit(transpose(t0:step:t2+step), values(:,7), 2);

f1 = polyval(p1,transpose(t0:step:t2+step));
f2 = polyval(p2,transpose(t0:step:t2+step));
f3 = polyval(p3,transpose(t0:step:t2+step));
f4 = polyval(p4,transpose(t0:step:t2+step));
f5 = polyval(p5,transpose(t0:step:t2+step));
f6 = polyval(p6,transpose(t0:step:t2+step));
f7 = polyval(p7,transpose(t0:step:t2+step));

plot(transpose(t0:step:t2+step),f1, 'color', colors(1)); hold on;
plot(transpose(t0:step:t2+step),f2, 'color', colors(2)); hold on;
plot(transpose(t0:step:t2+step),f3, 'color', colors(3)); hold on;
plot(transpose(t0:step:t2+step),f4, 'color', colors(4)); hold on;
plot(transpose(t0:step:t2+step),f5, 'color', colors(5)); hold on;
plot(transpose(t0:step:t2+step),f6, 'color', colors(6)); hold on;
plot(transpose(t0:step:t2+step),f7, 'color', colors(7)); hold on;


filename = 'jab.txt';
if use_upper_cut
    filename = 'uppercut.txt';
end
dlmwrite(filename, values);
