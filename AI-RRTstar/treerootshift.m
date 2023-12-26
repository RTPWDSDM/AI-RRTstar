function [RRTree3,treeclass,treeclasstemp,tree3isneed] = treerootshift(x_start,x_goal,linktype,RRTree3,cbest,treeclass,treeclasstemp,clusterclass_p,clustercenter_p)
tree3isneed = 1;
if linktype == 12 && length(RRTree3)>1
    if (distancecost(RRTree3(1).coord,x_start.coord)+distancecost(RRTree3(1).coord,x_goal.coord))>cbest   
        for i = 1:clusterclass_p
            if distancecost(clustercenter_p(i,:),x_start.coord)+distancecost(clustercenter_p(i,:),x_goal.coord)<cbest
                if ~ismember(i,treeclasstemp)
                treeclass = i;
                treeclasstemp = [treeclasstemp treeclass];
                RRTree3 = [];
                tree3isneed = 1;
                x_mid.coord = floor(clustercenter_p(i,:));
                x_mid.cost = 0;
                x_mid.parent = 0;
                x_mid.narrow = 1;
                RRTree3 = x_mid;
                return
                end
            end
        end
        tree3isneed = 0;
%         RRTree3 = [];
        treeclass = 0;
        treeclasstemp = 0;
    end
end
    
