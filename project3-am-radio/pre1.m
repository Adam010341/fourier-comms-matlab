duration=8;
f_sample=44100;
t=(((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;

[x1, f_sample]=audioread('x1.wav');
x1=x1';

%plot(t, x1)

h = 2000 * sin(2*pi*1000*t) ./ (2*pi*1000*t); 
h(t==0) = 2000; % 根據 L'Hôpital's rule 修正 t=0 的點plot(t,h);

x1_lpf=ece301conv(x1,h);
%sound(x1_lpf,f_sample);

y=x1_lpf.*cos(2*pi*4000*t);
%sound(y,f_sample); % Be careful! The new y signal is not audible.

y2=y.*cos(2*pi*4000*t);

w=2*ece301conv(y2,h)

sound(w,f_sample);
plot(t,x1_lpf, t, w);
legend('x1_lpf', 'w');
axis([-2.2715, -2.2685, 0.025, 0.052]);

