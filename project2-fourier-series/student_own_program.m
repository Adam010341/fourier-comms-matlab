function [omega0, a0, a1, a2, a3, a4, a5, a6]=student_own_program(period, active_left, active_right);

T1=(active_right-active_left)/2; 
omega0=2*pi/period;
t_shift=(active_left+active_right)/2;

a0=(active_right-active_left)/period;
a1=sin(1*omega0*T1)/(1*pi)*exp(-j*1*omega0*t_shift); 
a2=sin(2*omega0*T1)/(2*pi)*exp(-j*2*omega0*t_shift);
a3=sin(3*omega0*T1)/(3*pi)*exp(-j*3*omega0*t_shift);
a4=sin(4*omega0*T1)/(4*pi)*exp(-j*4*omega0*t_shift);
a5=sin(5*omega0*T1)/(5*pi)*exp(-j*5*omega0*t_shift);
a6=sin(6*omega0*T1)/(6*pi)*exp(-j*6*omega0*t_shift);
