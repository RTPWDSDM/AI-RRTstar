function [uselesscluster]=repairclusterresult(clustercenter_p,clusterclass_p,nodeclass_p,clustercenter_up,clusterclass_up,nodeclass_up)
uselesscluster = [];
% p and up is too closed,repire
for i=1:clusterclass_p
    for j = 1:clusterclass_up
        if distancecost(clustercenter_p(i,:),clustercenter_up(j,:))<=100
            uselesscluster = [uselesscluster,i];
            break;
        end
    end
end
