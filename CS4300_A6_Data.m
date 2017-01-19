
clf;
[xt,at,zt,St] = CS4300_A6_driver_lin(0,0,20,20,20,0.25,2);

plot(at(:,1), at(:,2), 'b.')
hold on;
plot(xt(:,1), xt(:,2), 'kx')
plot(zt(:,1), zt(:,2), 'go')

legend('Actual', 'Estimated (points)', 'Sensors');

xlabel('X')
ylabel('Y')

s = 1;
for s = 1:length(St)
    if( mod( s , 5 ) == 0 )
       sig = St(s).Sigma2;
       error_ellipse(sig(1:2,1:2), xt(s,1:2));
    end
end


hold off;
