function [narrownode,searchmethod] = decidesearchmethod(narrownode1,narrownode2,safedist)

%searchmethod -- false -->b-rrt   get away from narrownode
%searchmethod -- true -->triple-rrt  sample in narrownode
if safedist == 1
    narrownode = narrownode1;
    searchmethod = true;
    return
end
if isempty(narrownode1)
    narrownode = [];
    searchmethod = false;
else
    if ~isempty(narrownode2)
        narrownode = setdiff(narrownode1,narrownode2,'rows');
        if isempty(narrownode)
            searchmethod = false;
        else
            searchmethod = true;
        end
    else
        narrownode = narrownode1;
        searchmethod = true;
    end
end
