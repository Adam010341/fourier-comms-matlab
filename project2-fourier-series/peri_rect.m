function [t_array, peri_rect_array] = peri_rect(total_range_left, total_range_right, period, active_left, active_right, resoln)
% Define functions f0 and f1 and plot them over t = -4 to 4
t = linspace(-4,4,1000);
f0 = cos(2*pi*t);   % cos(2π t)
f1 = cos(4*pi*t);   % cos(4π t)

figure;
plot(t,f0,'b-','DisplayName','f0(t)=cos(2\pi t)'); hold on;
plot(t,f1,'r--','DisplayName','f1(t)=cos(4\pi t)');
xlabel('t'); ylabel('f(t)');
legend('show'); grid on;
title('f0(t)=cos(2\pi t) and f1(t)=cos(4\pi t) over t = -4..4');
%PERI_RECT It outputs an array of a periodic rectangular signal. 
% To plot the array, simply use the following command:
% plot(t_array,peri_rec_array);

if(nargin==5)
    resoln=50;
end

if(total_range_left<=active_left) && (active_left<=active_right) && (active_right<=total_range_right)

t_array=total_range_left:(1/resoln):total_range_right;

peri_rect_array=zeros(size(t_array));

for(jjj=1:length(t_array))
    for(iii=(-(ceil((total_range_right-total_range_left)/period)+1)) : (ceil((total_range_right-total_range_left)/period)+1)) 
        if(  t_array(1,jjj)+(iii-1)*period >active_left) && (  t_array(1,jjj)+(iii-1)*period <active_right)
            peri_rect_array(1,jjj)=1;
        end
    end
end
else
    error('Incorrect range input');
end
        

end

