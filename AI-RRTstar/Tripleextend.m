function [RRTree,x_new,x_newfound] = Tripleextend(RRTree,map,goal,x_rand,pathfound,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up,h)
global stepsize threshhold_tree threshhold_rewire
global idx121 idx122 idx131 idx133 idx212 idx211 idx232 idx233 idx313 idx311 idx323 idx322
global link12 link13 link23 nolink linktype
global cost_pre13 cost_now13 cost_pre23 cost_now23 cost_pre12 cost_now12 sum_type1 sum_type2
global cbest
global radiusclass display x_start x_goal


if display
figure(1)
pause(0.1);
end

intree = false;


x_newfound = false;

temp = [];
for i = 1:length(RRTree)
    temp = [temp;RRTree(i).coord];
end
[val1,idx] = min(distancecost(temp,x_rand));
x_near = RRTree(idx);

if val1 > stepsize
    
    theta=atan2(x_rand(1)-x_near.coord(1),x_rand(2)-x_near.coord(2));  % direction to extend sample to produce new node
    x_new.coord = double(int32(x_near.coord + stepsize * [sin(theta)  cos(theta)]));
    x_new.narrow = 0;
    
else
    x_new.coord = double(int32(x_rand));
    x_new.narrow = 0;
    
end
% if clustercenter_up~=0
% [val,idx] = min(distancecost(x_new.coord,clustercenter_up));
% if val<=stepsize
%     x_new.coord = floor(2*x_new.coord-clustercenter_up);
% end
% end
% if clustercenter_p~=0
%     [val,idx] = min(distancecost(x_new.coord,clustercenter_p));
%     if val<=stepsize
%         x_new.coord = floor(2*x_new.coord-clustercenter_p);
%     end
% end

for i = 1:size(RRTree)
    if x_new.coord == RRTree(i).coord
        intree = true;
        break;
    end
end
% if ~isempty(clustercenter_up)
%     for i = 1:clusterclass_up
%         if distancecost(clustercenter_up(i,:),x_new.coord)<=2*stepsize
%             return
%         end
%     end
% end
x_new.cost = distancecost(x_new.coord, x_near.coord) + x_near.cost;

if feasiblepoint(x_new.coord,map)&&checkpath(x_new.coord, x_near.coord, map)&&(~intree)
    x_newfound = true;
    
else
    
    return
end

x_nearest = [];
%         threshhold = 20;
neighbor_count = 1;
for j = 1:1:length(RRTree)
    if distancecost(RRTree(j).coord, x_new.coord) <= threshhold_rewire
        if checkpath(RRTree(j).coord, x_new.coord, map)
            x_nearest(neighbor_count).coord = RRTree(j).coord;
            x_nearest(neighbor_count).cost = RRTree(j).cost;
            neighbor_count = neighbor_count+1;
        end
    end
end
%     x_new.coord
%     x_nearest.coord
%     [x_new.coord(2),x_nearest.coord(2)],[x_new.coord(1),x_nearest.coord(1)]

x_min = x_near;
C_min = x_new.cost;

% Iterate through all nearest neighbors to find alternate lower
% cost paths

for k = 1:1:length(x_nearest)
    if x_nearest(k).cost + distancecost(x_nearest(k).coord, x_new.coord) < C_min
        if checkpath(x_nearest(k).coord, x_new.coord, map)
            x_min = x_nearest(k);
            C_min = x_nearest(k).cost + distancecost(x_nearest(k).coord, x_new.coord);
        end
    end
    x_new.cost = C_min;
end

x_near = x_min;
d = length(RRTree); %jubing duiyingdijigediandelianxian
if feasiblepoint(x_new.coord,map)&&checkpath(x_new.coord, x_near.coord, map)
    if display
    if goal.coord==x_goal.coord
        %                      scatter(x_new.coord(2),x_new.coord(1),'o','filled','MarkerFaceColor',[0 0.4470 0.7410]);
        %                      hold on
        
        h(d)=line([x_new.coord(2),x_near.coord(2)],[x_new.coord(1),x_near.coord(1)],'Color',[0 0.4470 0.7410],'LineWidth',1.5);
        hold on
    elseif goal.coord==x_start.coord
        %                      scatter(x_new.coord(2),x_new.coord(1),'o','filled','MarkerFaceColor',[0.8500 0.3250 0.0980]);
        %                      hold on
        h(d)=line([x_new.coord(2),x_near.coord(2)],[x_new.coord(1),x_near.coord(1)],'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
        hold on
    else
        %             scatter(x_new.coord(2),x_new.coord(1),'o','filled','MarkerFaceColor',[0.9290 0.6940 0.1250]);
        %             hold on
        h(d)=line([x_new.coord(2),x_near.coord(2)],[x_new.coord(1),x_near.coord(1)],'Color',[  0.2344    0.6992    0.4414],'LineWidth',1.5);
        hold on
    end
    
    pause(0.05)
end
    for j = 1:1:length(RRTree)
        if RRTree(j).coord == x_min.coord
            parentNew = RRTree(j).parent;
            if parentNew~=0
                costNew = RRTree(parentNew).cost + distancecost(RRTree(parentNew).coord,x_new.coord);
                
                if checkpath(RRTree(parentNew).coord,x_new.coord,map)&&costNew<C_min
                    x_new.parent = parentNew;
                    x_new.cost = costNew;
                    x_min.coord = RRTree(parentNew).coord;
                else
                    x_new.parent = j;
                end
                
            else
                x_new.parent = j;
            end
        end
    end
    for j = 1:1:length(RRTree)
        if distancecost(RRTree(j).coord, x_new.coord) <= threshhold_rewire
            if checkpath(RRTree(j).coord, x_new.coord, map)
                if RRTree(j).cost>(distancecost(RRTree(j).coord,x_new.coord)+x_new.cost)
                    RRTree(j).cost = (distancecost(RRTree(j).coord,x_new.coord)+x_new.cost);
                    RRTree(j).parent = d+1;
%                     if display
%                     delete(h(j-1));
%                     h(j-1) = line([RRTree(RRTree(j).parent).coord(2),RRTree(j).coord(2)],[RRTree(RRTree(j).parent).coord(1),RRTree(j).coord(1)],'Color','y','LineWidth',1.5);
%                     h(j-1)= line([x_new.coord(2),RRTree(j).coord(2)],[x_new.coord(1),RRTree(j).coord(1)],'Color','c','LineWidth',1.5);
%                     pause(0.05)
%                     end
                end
            end
        end
    end
    RRTree = [RRTree x_new];
end

