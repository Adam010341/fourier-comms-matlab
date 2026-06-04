duration=8;
f_sample=44100;
t=(((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;

[radio, f_sample]=audioread('radio.wav');
radio= radio';

h1= 10000 * sin(2*pi*5000*t) ./ (2*pi*5000*t); 
h1(t==0) = 10000; % 根據 L'Hôpital's rule 修正 t=0 的點plot(t,h);

h2= 15000 * sin(2*pi*7500*t) ./ (2*pi*7500*t); 
h2(t==0) = 15000; % 根據 L'Hôpital's rule 修正 t=0 的點plot(t,h);

h4= 2000 * sin(2*pi*1000*t) ./ (2*pi*1000*t); 
h4(t==0) = 2000; % 根據 L'Hôpital's rule 修正 t=0 的點plot(t,h);

h3=h2-h1;

radio1=ece301conv(radio,h3);
%sound(x1_lpf,f_sample);

radio2=2*radio1.*cos(2*pi*6500*t);

x1=ece301conv(radio2,h4)

sound(x1,f_sample);
plot(t, x1);
axis([-2.28, -2.255, -0.08 0.08]);