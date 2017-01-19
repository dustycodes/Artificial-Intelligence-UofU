[data, avg_data, lower_confidences, higher_confidences] = CS4300_Arc_Consistency_Test();

[p1,s1] = polyfit(avg_data(:,1),avg_data(:,4), 2);
[p2,s2] = polyfit(avg_data(:,1),avg_data(:,5), 2);

f1 = polyval(p1,avg_data(:,1));
f2 = polyval(p2,avg_data(:,1));

plot(avg_data(:,1),avg_data(:,4),'*',avg_data(:,1),f1,'-',avg_data(:,1),avg_data(:,5),'o',avg_data(:,1),f2,'-');

n_4 = data(1:1200,:);
n_5 = data(1201:2400,:);
n_6 = data(2401:3600,:);
n_7 = data(3601:4800,:);
n_8 = data(4801:6000,:);
n_9 = data(6001:7200,:);
n_10 = data(7201:8400,:);

n_4_l = data(1:1200,6);
n_5_l = data(1201:2400,6);
n_6_l = data(2401:3600,6);
n_7_l = data(3601:4800,6);
n_8_l = data(4801:6000,6);
n_9_l = data(6001:7200,6);
n_10_l = data(7201:8400,6);

n_4_r = data(1:1200,2);
n_5_r = data(1201:2400,2);
n_6_r = data(2401:3600,2);
n_7_r = data(3601:4800,2);
n_8_r = data(4801:6000,2);
n_9_r = data(6001:7200,2);
n_10_r = data(7201:8400,2);

n4 = data(1:1200,6);
n4(:,2) = data(1:1200,2);

n5 = data(1201:2400,6);
n5(:,2) = data(1201:2400,2);

n6 = data(2401:3600,6);
n6(:,2) = data(2401:3600,2);

n7 = data(3601:4800,6);
n7(:,2) = data(3601:4800,2);

n8 = data(4801:6000,6);
n8(:,2) = data(4801:6000,2);

n9 = data(6001:7200,6);
n9(:,2) = data(6001:7200,2);

n10 = data(7201:8400,6);
n10(:,2) = data(7201:8400,2);

[UA, ~, idx] = unique(n4(:,1));
n4 = [UA, accumarray(idx, n4(:,2),[],@mean)];
[UA, ~, idx] = unique(n5(:,1));
n5 = [UA, accumarray(idx, n5(:,2),[],@mean)];
[UA, ~, idx] = unique(n6(:,1));
n6 = [UA, accumarray(idx, n6(:,2),[],@mean)];
[UA, ~, idx] = unique(n7(:,1));
n7 = [UA, accumarray(idx, n7(:,2),[],@mean)];
[UA, ~, idx] = unique(n8(:,1));
n8 = [UA, accumarray(idx, n8(:,2),[],@mean)];
[UA, ~, idx] = unique(n9(:,1));
n9 = [UA, accumarray(idx, n9(:,2),[],@mean)];
[UA, ~, idx] = unique(n10(:,1));
n10 = [UA, accumarray(idx, n10(:,2),[],@mean)];

plot(n4(1:end,1), n4(1:end,2));
hold on;
plot(n5(1:end,1), n5(1:end,2));
plot(n6(1:end,1), n6(1:end,2));
plot(n7(1:end,1), n7(1:end,2));
plot(n8(1:end,1), n8(1:end,2));
plot(n9(1:end,1), n9(1:end,2));
plot(n10(1:end,1), n10(1:end,2));
legend('N=4', 'N=5', 'N=6', 'N=7', 'N=8', 'N=9', 'N=10');
xlabel('Starting Number of Labels');
ylabel('Expected Reduction in Labels');
hold off;