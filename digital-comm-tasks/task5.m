t = linspace(-4,4,2000);
f0 = (t>0 & t<1);
f1 = cos(2*pi*t) .* (t>0 & t<1);

plot(t,f0,'b','LineWidth',1.5)
hold on
%plot(t,f1,'r','LineWidth',1.5)
hold off
ylim([-1.2 1.2])
xlabel('t')
ylabel('f(t)')
legend('f_0(t)','f_1(t)')
title('Signals f_0(t) and f_1(t) on t \in [-4,4]')
grid on