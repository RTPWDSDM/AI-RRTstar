function feasible=checkpath(x_new,x_nearest,map)
feasible=true;
dir=atan2(x_nearest(1)-x_new(1),x_nearest(2)-x_new(2));
for r=0:1:sqrt(sum((x_new-x_nearest).^2))
    posCheck=x_new+r.*[sin(dir) cos(dir)];
    if ~(feasiblepoint(ceil(posCheck),map) && feasiblepoint(floor(posCheck),map) && ... 
            feasiblepoint([ceil(posCheck(1)),floor(posCheck(2))],map) && feasiblepoint([floor(posCheck(1)),ceil(posCheck(2))],map))
        feasible=false;break;
    end
    if ~feasiblepoint(x_nearest,map), feasible=false; end
end