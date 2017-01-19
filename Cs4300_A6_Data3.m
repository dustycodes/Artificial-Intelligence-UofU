clf;
[xt,at,zt,St] = CS4300_driver_proj(0,0,100,100,20,.1,1);


plot(xt(:,3),'b')
hold on
plot(xt(:,4),'r')

plot(at(:,3),'g')

plot(at(:,4),'k')

legend('Estimated Vel in X', 'Estimated Vel in Y', 'Actual vel in x',... 
'Actual vel in y');


xlabel('X')
ylabel('Y')


axis equal
hold off;