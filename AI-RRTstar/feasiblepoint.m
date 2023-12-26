function feasible=feasiblepoint(x_new,map)
feasible=true;
if ~(x_new(1)>=1 && x_new(1)<=size(map,1) && x_new(2)>=1 && x_new(2)<=size(map,2) && map(x_new(1),x_new(2))==1)
    feasible=false;
end