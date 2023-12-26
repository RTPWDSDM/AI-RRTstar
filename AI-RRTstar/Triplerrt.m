function [initialpath,RRTree1,RRTree2,RRTree3] = Triplerrt(x_goal,x_start,map,h,w,RRTree1,RRTree2,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up,narrownode,nodeclass_p)


global k0 k1 k2 k3
global stepsize threshhold_tree threshhold_rewire
global idx121 idx122 idx131 idx133 idx212 idx211 idx232 idx233 idx313 idx311 idx323 idx322
global link12 link13 link23 nolink linktype
global cost_pre13 cost_now13 cost_pre23 cost_now23 cost_pre12 cost_now12 sum_type1 sum_type2
global cbest cbestdraw clusterclass_up_add display
if display
    
    figure(1)
    h1(1)= line([0,0],[0,0]);
h2(1) =line([0,0],[0,0]);
h3(1) = line([0,0],[0,0]);
end
h1(1)= 0;
h2(1) = 0;
h3(1) = 0;

% [x_mid,x_midfound,appendix] = generatenodenarrow(map,h,w,num_samplingnode_narrow_attempt,num_samplingnode_narrow_max,x_midfound,narrownode);
temp = inf;
update=0;
for i = 1:clusterclass_p
    if ismember(i,clusterclass_up_add)
        temp0 = distancecost(clustercenter_p(i,:),x_goal.coord)+distancecost(clustercenter_p(i,:),x_start.coord);
        if temp0<temp
            idx = i;
            temp = temp0;
            update = 1;
        end
    end
end
if update
x_mid.coord = floor(clustercenter_p(idx,:));
else
    idx=ceil(rand()*size(clustercenter_p,1));
    x_mid.coord = floor(clustercenter_p(idx,:));
end

feasiblepoint(x_mid.coord,map);
x_mid.cost = 0;
x_mid.parent = 0;
x_mid.narrow = 1;
treeclass = idx;
treeclasstemp = treeclass;
if display
    figure(1)
    scatter(x_mid.coord(1,2),x_mid.coord(1,1),'o','filled','c');
    hold on
    title('generate the root of the 3rd tree')
end
RRTree3 = x_mid;
% RRTree3 = treeextend(appendix,RRTree3,x_mid);
%% find the initial path
epoch = 0;
epoch_max = 100;

pathfound = false;
pathlength = [inf];
tree3isneed = 1;
% tempdraw = 0;
% pic_num = 1;
if display
    title('search the configuration space')
end
while epoch<100
    
    % RRTree1
    x_new1found = false;
    while ~x_new1found
        if ~pathfound
            [x_rand1] = uniformsampler(h,w,x_goal,k0);
        else
            [x_rand1] = informedsampler(x_goal,x_start,h,w,cbest);
        end
        [RRTree1,x_new1,x_new1found] = Tripleextend(RRTree1,map,x_goal,x_rand1,pathfound,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up,h1);
    end
    [idx121,idx122,idx211,idx212,link12,cost_pre12] = Triplecheckconnection(RRTree1,RRTree2,x_new1,threshhold_tree,map,idx121,idx122,idx211,idx212,link12,cost_pre12,pathfound);
    [idx131,idx133,idx311,idx313,link13,cost_pre13] = Triplecheckconnection(RRTree1,RRTree3,x_new1,threshhold_tree,map,idx131,idx133,idx311,idx313,link13,cost_pre13,pathfound);
    % RRTree2
    x_new2found = false;
    while ~x_new2found
        if ~pathfound
            [x_rand2] = uniformsampler(h,w,x_start,k0);
        else
            [x_rand2] = informedsampler(x_goal,x_start,h,w,cbest);
        end
        [RRTree2,x_new2,x_new2found] = Tripleextend(RRTree2,map,x_start,x_rand2,pathfound,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up,h2);
    end
    [idx212,idx211,idx121,idx122,link12,cost_pre12] = Triplecheckconnection(RRTree2,RRTree1,x_new2,threshhold_tree,map,idx212,idx211,idx121,idx122,link12,cost_pre12,pathfound);
    [idx232,idx233,idx322,idx323,link23,cost_pre23] = Triplecheckconnection(RRTree2,RRTree3,x_new2,threshhold_tree,map,idx232,idx233,idx322,idx323,link23,cost_pre23,pathfound);
    % RRTree3
    x_new3found = false;
    
    while  ~x_new3found&&tree3isneed
        [x_rand3] = hybridsampler(h,w,pathfound,k1,k2,k3,x_start,x_goal,cbest,narrownode,treeclass,nodeclass_p);
        [RRTree3,x_new3,x_new3found] = Tripleextend(RRTree3,map,x_mid,x_rand3,pathfound,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up,h3);
    end
    if tree3isneed
        [idx313,idx311,idx131,idx133,link13,cost_pre13] = Triplecheckconnection(RRTree3,RRTree1,x_new3,threshhold_tree,map,idx313,idx311,idx131,idx133,link13,cost_pre13,pathfound);
        [idx323,idx322,idx232,idx233,link23,cost_pre23] = Triplecheckconnection(RRTree3,RRTree2,x_new3,threshhold_tree,map,idx323,idx322,idx232,idx233,link23,cost_pre23,pathfound);
        
        % draw lines
        %    line([x_new1.coord(2),RRTree2(idx2).coord(2)],[x_new1.coord(1),RRTree2(idx2).coord(1)],'Color','r','LineWidth',1);
        %    hold on
        
        [initialpath,linktype,cbest,pathfound] = checklinktype(map,link12,link13,link23,cost_pre12,cost_pre13,cost_pre23,RRTree1,RRTree2,RRTree3,idx121,idx122,idx131,idx133,idx211,idx212,idx232,idx233,idx311,idx313,idx322,idx323);
      
        [RRTree3,treeclass,treeclasstemp,tree3isneed] = treerootshift(x_start,x_goal,linktype,RRTree3,cbest,treeclass,treeclasstemp,clusterclass_p,clustercenter_p);
    end
    cbestdraw = [cbestdraw cbest];
    epoch = epoch + 1;
    %     F=getframe(gcf);
    %     y=frame2im(F);
    %     [y,e]=rgb2ind(y,256);
    %     if pic_num == 1
    %         imwrite(y,e,'test1.gif','gif','Loopcount',inf,'DelayTime',0.05);
    %
    %     else
    %         imwrite(y,e,'test1.gif','gif','WriteMode','append','DelayTime',0.05);
    %
    %     end
    %
    %     pic_num = pic_num + 1;
end


