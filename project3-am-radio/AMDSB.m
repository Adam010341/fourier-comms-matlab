function [ y ] =AMDSB(ch)
% ch: is an input deciding which signal you would like to tune into.
% ch = 1, 2, 3 for AM-DSB and ch=1,…, 6 for AM-SSB.

duration=8;
f_sample=44100;
t=(((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;
[radio1, f_sample]=audioread('radio1.wav');
radio1=radio1';

% Fill in your main body here
h0=2000 * sin(2*pi*1000*t) ./ (2*pi*1000*t); 
h0(t==0) = 2000;

switch ch
    case 1
        x1 = radio1; 
        h1= 4000 * sin(2*pi*2000*t) ./ (2*pi*2000*t); 
        h1(t==0) = 4000; 
        x1_lpf=ece301conv(x1,h1);
        x1_dsb = 2*x1_lpf .* cos(2 * pi * 1000 * t);
        x1_dsb=ece301conv(x1_dsb,h0);
        y = x1_dsb;
    case 2
        x2 = radio1; 
        h2_1= 9200 * sin(2*pi*4600*t) ./ (2*pi*4600*t); 
        h2_1(t==0) = 9200; 
        h2_2= 4800 * sin(2*pi*2400*t) ./ (2*pi*2400*t); 
        h2_2(t==0) = 4800;
        h2=h2_1-h2_2;
        x2_lpf=ece301conv(x2,h2);
        x2_dsb = 2*x2_lpf .* cos(2 * pi * 3500 * t);
        x2_dsb=ece301conv(x2_dsb,h0);
        y = x2_dsb;
    case 3
        x3 = radio1; 
        h3_1= 14400 * sin(2*pi*7200*t) ./ (2*pi*7200*t); 
        h3_1(t==0) = 14400;
        h3_2= 9600 * sin(2*pi*4800*t) ./ (2*pi*4800*t); 
        h3_2(t==0) = 9600; 
        h3=h3_1-h3_2;
        x3_lpf=ece301conv(x3,h3);
        x3_dsb = 2*x3_lpf .* cos(2 * pi * 6000 * t);
        x3_dsb=ece301conv(x3_dsb,h0);
        y = x3_dsb;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%x1_dsb=x1.*cos(2*pi*1000*t);
%x2_dsb=x2.*cos(2*pi*3500*t);
%x3_dsb=x3.*cos(2*pi*6000*t);
%x123=x1_dsb+x2_dsb+x3_dsb;
%audiowrite('radio1.wav', x123,44100);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%