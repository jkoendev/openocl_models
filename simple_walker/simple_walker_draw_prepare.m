function h = simple_walker_draw_prepare()

figure; hold on; 
h1 = plot(0,0, 'or'); % center
h2 = plot(0,0, 'og'); % foot 1
h3 = plot(0,0, 'ob'); % foot 2
h4 = plot(0,0, '-k'); % leg 1
h5 = plot(0,0, '-k'); % leg 2
h = {h1,h2,h3,h4,h5};
xlim([-5 5])
ylim([-5 5])