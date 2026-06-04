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

h0 = 2000 * sin(2*pi*1000*t) ./ (2*pi*1000*t);
h0(t==0) = 2000;
x1=ece301conv(x1,h0);
x2=ece301conv(x2,h0);
x3=ece301conv(x3,h0);
x4=ece301conv(x4,h0);
x5=ece301conv(x5,h0);
x6=ece301conv(x6,h0);

h2 = 4400 * sin(2*pi*2200*t) ./ (2*pi*2200*t);
h3 = 6600 * sin(2*pi*3300*t) ./ (2*pi*3300*t);
h4 = 8800 * sin(2*pi*4400*t) ./ (2*pi*4400*t);
h5 = 11000 * sin(2*pi*5500*t) ./ (2*pi*5500*t);
h6 = 13200 * sin(2*pi*6600*t) ./ (2*pi*6600*t);
h2(t==0) = 4400;
h3(t==0) = 6600;
h4(t==0) = 8800;
h5(t==0) = 11000;
h6(t==0) = 132000;


x2 = x2 .* cos(2*pi*2200*t);
x3 = x3 .* cos(2*pi*3300*t);
x4 = x4 .* cos(2*pi*4400*t);
x5 = x5 .* cos(2*pi*5500*t);
x6 = x6 .* cos(2*pi*6600*t);

x2 = ece301conv(x2, h2);
x3 = ece301conv(x3, h3);
x4 = ece301conv(x4, h4);
x5 = ece301conv(x5, h5);
x6 = ece301conv(x6, h6);

x123=x1+x2+x3+x4+x5+x6;

x123 = x123 / max(abs(x123)) * 0.99; 

audiowrite('radio2.wav', x123, 44100);
