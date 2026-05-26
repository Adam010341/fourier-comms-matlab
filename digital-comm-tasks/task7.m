% Parameters (you can modify b1,b2,b3 as needed)
b1 = 1;
b2 = 0;
b3 = 1;

% Time vector
t = linspace(-3,9,2000);

% Define f0 and f1 as anonymous functions operating on vector t
f0 = @(tt) double(tt>0 & tt<1);
f1 = @(tt) (cos(2*pi*tt) .* (tt>0 & tt<1));

% Construct x(t) with shifted components at 0, 3, 6
x = (1-b1).*f0(t) + b1.*f1(t) ...
  + (1-b2).*f0(t-2) + b2.*f1(t-2) ...
  + (1-b3).*f0(t-4) + b3.*f1(t-4);

% Plot
figure;
plot(t,x,'LineWidth',1.2);
xlabel('t');
ylabel('x(t)');
title('x(t) = sum of shifted weighted f0 and f1');
grid on;
xlim([-3 9]);
ylim([-3 3]);