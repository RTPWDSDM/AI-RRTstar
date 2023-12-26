function [initialpath,RRTree1,RRTree2] = Birrt(x_goal,x_start,map,h,w,RRTree1,RRTree2,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up)

global stepsize threshhold_tree threshhold_rewire
global k0 k1 k2 k3 
global cbest cbestdraw

figure(1)
h1(1)= line([0,0],[0,0]);
h2(1) = line([0,0],[0,0]);
idx1 = 0;
idx2 = 0;

epoch = 0;
epoch_max = 100;

pathfound = false;
pathlength = inf;
cost_pre = cbest;

%% find the initial path
while ~pathfound
    
    % RRTree1
    x_new1found = false;
    while ~x_new1found
        if ~pathfound
            [x_rand1] = uniformsampler(h,w,x_goal,k0);
        else
            [x_rand1] = informedsampler(x_goal,x_start,h,w,cost_pre);
        end
        [RRTree1,x_new1,x_new1found] = Biextend(RRTree1,map,x_goal,x_rand1,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up,h1);
    end
    [idx1,idx2,cost_pre,pathfound] = Bicheckconnection(RRTree1,RRTree2,x_new1,threshhold_tree,map,cost_pre,pathfound,idx1,idx2);
    
    % RRTree2
    x_new2found = false;
    while ~x_new2found
        if ~pathfound
            [x_rand2] = uniformsampler(h,w,x_start,k0);
        else
            [x_rand2] = informedsampler(x_goal,x_start,h,w,cost_pre);
        end
        [RRTree2,x_new2,x_new2found] = Biextend(RRTree2,map,x_start,x_rand2,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up,h2);
    end
    [idx2,idx1,cost_pre,pathfound] = Bicheckconnection(RRTree2,RRTree1,x_new2,threshhold_tree,map,cost_pre,pathfound,idx2,idx1);
    cbestdraw = [cbestdraw cost_pre];
    epoch = epoch + 1;
    
end



%% remake path and cost

initialpath = Bitraceback(RRTree1,RRTree2,idx1,idx2);
cbest = cost_pre;

