
clf;
[xt,at,zt,St] = CS4300_driver_proj(0,0,100,100,20,.1,1);

plot(at(:,1), at(:,2), '.b');
hold on;
plot(xt(:,1), xt(:,2), '.r');
plot(zt(:,1), zt(:,2), 'go');
legend('Actual Trajectory', 'Observed Trajectory', 'Estimated Trajectory');
xlabel('X')
ylabel('Y')

for s = 1 : length(St)
    sigma = St(s).Sigma2;
    error_ellipse(sigma(1:2,1:2), xt(s,1:2));  
end

hold off;