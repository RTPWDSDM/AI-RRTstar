function RRTree3 = treeextend(appendix,RRTree3,x_mid)
if appendix ~= 0
    for i = 1:length(appendix)
        temp.coord = appendix(i,:);
        temp.cost = distance(x_mid.coord,temp.coord);
        temp.parent = 1;
        temp.narrow = 1;
        RRTree3 = [RRTree3 temp];
    end
end
