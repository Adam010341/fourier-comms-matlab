t = linspace(-4,4,1000);
%f0 = cos(2*pi*t);   % cos(2π t)
f1 = cos(4*pi*t);   % cos(4π t)

figure;
%plot(t,f0,'b-','DisplayName','f0(t)=cos(2\pi t)'); hold on;
plot(t,f1,'r--','DisplayName','f1(t)=cos(4\pi t)');
xlabel('t'); ylabel('f(t)');
legend('show'); grid on;
title('f0(t)=cos(2\pi t) and f1(t)=cos(4\pi t) over t = -4..4');