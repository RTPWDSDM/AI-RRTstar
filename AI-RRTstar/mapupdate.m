function  map = mapupdate(map,narrownode2)

for i=1:length(narrownode2)
    map(narrownode2(i,1),narrownode2(i,2))=0;
end
return 