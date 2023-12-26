function [idx1,idx2,idx3,idx4,link12,cost_pre12] = checkconnection(RRTree1,RRTree2,x_new1,threshhold_tree,map,idx1,idx2,idx3,idx4,link12,cost_pre12,pathfound)
% idx121 : idx of connection node in Tree1,when linktype is 12
% idx122 : idx of connection node in Tree2,when linktype is 12
% link12-- 1 : connection 12 feasible
%       -- 0 : connection 12 infeasible
% linknode1 : coord,cost,parent of linknode
% cost_pre12 : cost from the linknode1 to Tree2
if ~pathfound
    temp = [];
    for i = 1:length(RRTree2)
        temp = [temp;RRTree2(i).coord];
    end
    for i = 1:size(temp,1)

        if distancecost(temp(i,:),x_new1.coord)<threshhold_tree&&checkpath(RRTree2(i).coord,x_new1.coord,map)
            %                 disp('Tree1-Tree2 links');
            cost_now12 = RRTree2(i).cost + x_new1.cost + distancecost(RRTree2(i).coord,x_new1.coord);
            
            if cost_now12 < cost_pre12
                idx1 = length(RRTree1);
                idx2 = i;
                idx3 = 0;
                idx4 = 0;
                link12 = 1;% Tree1-Tree2 OK
                cost_pre12 = cost_now12;
            end
            

        end
    end
else
    %% optimization
    temp = [];
    for i = 1:length(RRTree2)
        temp = [temp;RRTree2(i).coord];
    end
    for i = 1:size(temp,1)

            if distancecost(temp(i,:),x_new1.coord)<threshhold_tree&&checkpath(RRTree2(i).coord,x_new1.coord,map)
                %                 disp('Tree1-Tree2 links');
                cost_now12 = RRTree2(i).cost + x_new1.cost + distancecost(RRTree2(i).coord,x_new1.coord);
                
                if cost_now12 < cost_pre12
                    idx1 = length(RRTree1);
                    idx2 = i;
                    idx3 = 0;
                    idx4 = 0;
                    link12 = 1;% Tree1-Tree2 OK
                    cost_pre12 = cost_now12;
                end
                
            end
        
    end
end