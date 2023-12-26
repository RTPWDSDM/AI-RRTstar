function [idx1,idx2,cost_pre,pathfound] = Bicheckconnection(RRTree1,RRTree2,x_new1,threshhold_tree,map,cost_pre,pathfound,idx1,idx2)


temp = [];
for i = 1:length(RRTree2)
    temp = [temp;RRTree2(i).coord];
end
[val,idx] = min(distancecost(temp,x_new1.coord));

if val<threshhold_tree&&checkpath(x_new1.coord,RRTree2(idx).coord,map)
    cost_now = x_new1.cost + RRTree2(idx).cost + distancecost(x_new1.coord,RRTree2(idx).coord);
    if cost_now<cost_pre
        idx1 = length(RRTree1);
        idx2 = idx;
        cost_pre = cost_now;
        pathfound = 1;
    end
end