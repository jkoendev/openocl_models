function simple_walker_draw_frame(h, q)

p0 = [q(1);q(2)];
[p1, p2] = sw_model_fkine(q);

set(h{1}, 'Xdata', p0(1), 'Ydata', p0(2));   % center
set(h{2}, 'Xdata', p1(1), 'Ydata', p1(2)); % foot 1
set(h{3}, 'Xdata', p2(1), 'Ydata', p2(2)); % foot 2

set(h{4}, 'Xdata', [p0(1) p1(1)], 'Ydata', [p0(2) p1(2)]);
set(h{5}, 'Xdata', [p0(1) p2(1)], 'Ydata', [p0(2) p2(2)]);