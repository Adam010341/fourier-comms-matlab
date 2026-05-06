function [] = impulse_center(file_name)
%Takes an impulse response and centers the impulse in an 8
%second window. The input file_name is the string name of the original
%file. Ensure that the name is enclosed in single quotes ('') and doesn't
%include the .wav extension. The original WAV file must also have been
%recorded at a sampling rate of 44.1kHz and must have at least 4 seconds
%befor and after the impulse. The function will then create a new WAV file
%in the current directory called new_file.wav

[old_sig, f_sample] = audioread(file_name);
[M,I] = max(old_sig);
samp_high = I + (f_sample * 4) - 1;
samp_low = I - (f_sample * 4);
new_sig = old_sig(samp_low:samp_high);
audiowrite('new_file.wav',new_sig,f_sample);

end

