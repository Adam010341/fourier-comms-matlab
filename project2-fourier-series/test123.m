period = 9;

active_left = -2;

active_right = 1.5;

 

 

[t_array, rect_array] = peri_rect(total_range_left, total_range_right, period, active_left, active_right);

[omega0, a0, a1, a2, a3, a4, a5, a6]=student_own_program(period, active_left, active_right);

azero2an=[a0, a1, a2, a3, a4, a5, a6];
[t2, CTFS_array] = CTFS_synthesis(total_range_left, total_range_right, omega0, azero2an);

plot(t_array, rect_array, t2, CTFS_array);

axis([total_range_left, total_range_right, min(-0.1,min(CTFS_array)-0.1), max(1.2, max(CTFS_array)+0.1)]);

grid on;