impulse_center('Library 1.wav');
duration = 8;
f_sample = 44100;
t = (((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;
[x1,f_sample1] = audioread('x1.wav');
x1 = x1';
[impulse,f_sample2] = audioread('new_file.wav');
impulse = impulse';
%plot(t,x1) 
%soundsc(x1,f_sample1)
output = ece301conv(impulse,x1);
soundsc(output,f_sample);
output = output / max(abs(output));
audiowrite('libraryConvolved.wav', output, f_sample);
