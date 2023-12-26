function [initialpath,linktype,cbest,pathfound] = checklinktype(map,link12,link13,link23,cost_pre12,cost_pre13,cost_pre23,RRTree1,RRTree2,RRTree3,idx121,idx122,idx131,idx133,idx211,idx212,idx232,idx233,idx311,idx313,idx322,idx323)

if link12&&((~link13)||(~link23))
    
    linktype = 12;
    cbest = 0;
    
    initialpath =  Tripletraceback(map,RRTree1,RRTree2,RRTree3,linktype,idx121,idx122,idx131,idx133,idx211,idx212,idx232,idx233,idx311,idx313,idx322,idx323);
    for i = 1:length(initialpath)-1
        cbest = cbest+distancecost(initialpath(i,:),initialpath(i+1,:));
    end
    pathfound = true;
    return
end
if link13&&link23&&(~link12)
    
    linktype = 132;
    cbest = 0;
    
    initialpath =  Tripletraceback(map,RRTree1,RRTree2,RRTree3,linktype,idx121,idx122,idx131,idx133,idx211,idx212,idx232,idx233,idx311,idx313,idx322,idx323);
    for i = 1:length(initialpath)-1
        cbest = cbest+distancecost(initialpath(i,:),initialpath(i+1,:));
    end
    pathfound = true;
    return
end
if link13&&link23&&link12
    cbest1 = cost_pre12;
    cbest2 = cost_pre13 + cost_pre23;
    if cbest1 < cbest2
        linktype = 12;
        cbest = 0;
        
        initialpath =  Tripletraceback(map,RRTree1,RRTree2,RRTree3,linktype,idx121,idx122,idx131,idx133,idx211,idx212,idx232,idx233,idx311,idx313,idx322,idx323);
        for i = 1:length(initialpath)-1
            cbest = cbest+distancecost(initialpath(i,:),initialpath(i+1,:));
        end
        pathfound = true;
        return
    else
        linktype = 132;
        cbest = 0;
        
        initialpath =  traceback(map,RRTree1,RRTree2,RRTree3,linktype,idx121,idx122,idx131,idx133,idx211,idx212,idx232,idx233,idx311,idx313,idx322,idx323);
        for i = 1:length(initialpath)-1
            cbest = cbest+distancecost(initialpath(i,:),initialpath(i+1,:));
        end
        pathfound = true;
        return
    end
end
initialpath = inf;
linktype = 0;
cbest = inf;
pathfound = false;


