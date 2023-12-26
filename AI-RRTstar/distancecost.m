function h=distancecost(x_new,x_nearest)
h = sqrt((x_new(:,1)-x_nearest(:,1)).^2 + (x_new(:,2)-x_nearest(:,2)).^2 );