function [ y ] =AMSSB(ch)
% ch: is an input deciding which signal you would like to tune into.
% ch = 1, 2, 3 for AM-DSB and ch=1,…, 6 for AM-SSB.

duration=8;
f_sample=44100;
t=(((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;
[radio2, f_sample]=audioread('radio2.wav');
radio2=radio2';
% Fill in your main body here

h0=2000 * sin(2*pi*1000*t) ./ (2*pi*1000*t); 
h0(t==0) = 2000;
x=radio2;

switch ch
    case 1
        x=ece301conv(x,h0);
        y = x;
    case 2
        h1 = 4400 * sin(2*pi*2200*t) ./ (2*pi*2200*t);
        h1(t==0) = 4400;
        h2 = 2200 * sin(2*pi*1100*t) ./ (2*pi*1100*t);
        h2(t==0) = 2200;
        h3 = h1 - h2;
        x = ece301conv(x,h3);
        x = 4 * x .* cos(2 * pi * 2200 * t);
        x = ece301conv(x,h0);
        y = x;
    case 3
        h1 = 6600 * sin(2*pi*3300*t) ./ (2*pi*3300*t);
        h1(t==0) = 6600;
        h2 = 4400 * sin(2*pi*2200*t) ./ (2*pi*2200*t);
        h2(t==0) = 4400;
        h3 = h1 - h2;
        x = ece301conv(x,h3);
        x = 4 * x .* cos(2 * pi * 3300 * t);
        x = ece301conv(x,h0);
        y = x;
    case 4
        h1 = 8800 * sin(2*pi*4400*t) ./ (2*pi*4400*t);
        h1(t==0) = 8800;
        h2 = 6600 * sin(2*pi*3300*t) ./ (2*pi*3300*t);
        h2(t==0) = 6600;
        h3 = h1 - h2;
        x = ece301conv(x,h3);
        x = 4 * x .* cos(2 * pi * 4400 * t);
        x = ece301conv(x,h0);
        y = x;
    case 5
        h1 = 11000 * sin(2*pi*5500*t) ./ (2*pi*5500*t);
        h1(t==0) = 11000;
        h2 = 8800 * sin(2*pi*4400*t) ./ (2*pi*4400*t);
        h2(t==0) = 8800;
        h3 = h1 - h2;
        x = ece301conv(x,h3);
        x = 4 * x .* cos(2 * pi * 5500 * t);
        x = ece301conv(x,h0);
        y = x;
    case 6
        h1 = 13200 * sin(2*pi*6600*t) ./ (2*pi*6600*t);
        h1(t==0) = 13200;
        h2 = 11000 * sin(2*pi*5500*t) ./ (2*pi*5500*t);
        h2(t==0) = 11000;
        h3 = h1 - h2;
        x = ece301conv(x,h3);
        x = 4 * x .* cos(2 * pi * 6600 * t);
        x = ece301conv(x,h0);
        y = x;
end
y = y / max(abs(y)) * 0.99;
end