duration=8;
f_sample=44100;
t=(((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;
[x1, f_sample]=audioread('x1.wav');
x1 = x1';

[x2, f_sample]=audioread('x2.wav');
x2 = x2';

[x3, f_sample]=audioread('x3.wav');
x3 = x3';

[x4, f_sample]=audioread('x4.wav');
x4 = x4';

[x5, f_sample]=audioread('x5.wav');
x5 = x5';

[x6, f_sample]=audioread('x6.wav');
x6 = x6';

h0=2000 * sin(2*pi*1000*t) ./ (2*pi*1000*t); 
h0(t==0) = 2000;

x1=ece301conv(x1,h0);
x2=ece301conv(x2,h0);
x3=ece301conv(x3,h0);

x1_dsb=x1.*cos(2*pi*1000*t);
x2_dsb=x2.*cos(2*pi*3500*t);
x3_dsb=x3.*cos(2*pi*6000*t);
x123 = x1_dsb + x2_dsb + x3_dsb;

% 強制將最大振幅壓縮至 0.99，避免任何削波發生
x123 = x123 / max(abs(x123)) * 0.99; 

audiowrite('radio1.wav', x123, 44100);
