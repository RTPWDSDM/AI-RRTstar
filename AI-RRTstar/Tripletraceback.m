function initialpath = Tripletraceback(map,RRTree1,RRTree2,RRTree3,linktype,idx121,idx122,idx131,idx133,idx211,idx212,idx232,idx233,idx311,idx313,idx322,idx323)
% figure();
% imshow(map);
if linktype == 132
    initialpath1 = [RRTree1(idx131+idx311).coord];
    x_end1 = RRTree1(idx131+idx311);
    while x_end1.parent ~= 0
        start = x_end1.parent;
        %             pathLength0 = pathLength0 + norm(RRTree1(start).coord-x_end.coord);
%         line([x_end1.coord(2), RRTree1(start).coord(2)], [x_end1.coord(1), RRTree1(start).coord(1)], 'Color', 'r', 'LineWidth', 1);
%         hold on
        initialpath1 = [RRTree1(start).coord;initialpath1];
        x_end1 = RRTree1(start);
    end
    x_end3 = RRTree3(idx133+idx313);
    initialpath1 = [initialpath1; x_end3.coord];
    while x_end3.parent ~= 0
        start = x_end3.parent;
        %             pathLength0 = pathLength0 + norm(RRTree1(start).coord-x_end.coord);
%         line([x_end3.coord(2), RRTree3(start).coord(2)], [x_end3.coord(1), RRTree3(start).coord(1)], 'Color', 'r', 'LineWidth', 1);
%         hold on
        initialpath1 = [initialpath1;RRTree3(start).coord];
        x_end3 = RRTree3(start);
    end
    
    
    
    initialpath2 = [RRTree2(idx232+idx322).coord];
    x_end2 = RRTree2(idx232+idx322);
    while x_end2.parent ~= 0
        start = x_end2.parent;
        %             pathLength0 = pathLength0 + norm(RRTree1(start).coord-x_end.coord);
%         line([x_end2.coord(2), RRTree2(start).coord(2)], [x_end2.coord(1), RRTree2(start).coord(1)], 'Color', 'r', 'LineWidth', 1);
%         hold on
        initialpath2 = [initialpath2;RRTree2(start).coord];
        x_end2 = RRTree2(start);
    end
    x_end4 = RRTree3(idx323+idx233);
    initialpath2 = [x_end4.coord;initialpath2];
    while x_end4.parent ~= 0
        start = x_end4.parent;
        %             pathLength0 = pathLength0 + norm(RRTree1(start).coord-x_end.coord);
%         line([x_end4.coord(2), RRTree3(start).coord(2)], [x_end4.coord(1), RRTree3(start).coord(1)], 'Color', 'r', 'LineWidth', 1);
%         hold on
        initialpath2 = [RRTree3(start).coord;initialpath2];
        x_end4 = RRTree3(start);
    end
    initialpath = [initialpath1;initialpath2(2:end,:)];
    %                     scatter(linknode1.coord(2),linknode1.coord(1),'o','filled','y');
    %                     hold on
    %                     scatter(linknode2.coord(2),linknode2.coord(1),'o','filled','b');
    %                     hold on
    %                     scatter(RRTree3(idx3).coord(2),RRTree3(idx3).coord(1),'o','filled','g');
    %                     hold on
    %                     scatter(RRTree3(idx4).coord(2),RRTree3(idx4).coord(1),'o','filled','c');
    %                     hold on
end

if linktype == 12
    
    initialpath1 = RRTree1(idx121+idx211).coord;
    x_end1 =  RRTree1(idx121+idx211);
    while x_end1.parent ~= 0
        start = x_end1.parent;
        %             pathLength0 = pathLength0 + norm(RRTree1(start).coord-x_end.coord);
%         line([x_end1.coord(2), RRTree1(start).coord(2)], [x_end1.coord(1), RRTree1(start).coord(1)], 'Color', 'r', 'LineWidth', 3);
%         hold on
        initialpath1 = [RRTree1(start).coord;initialpath1];
        x_end1 = RRTree1(start);
    end
    
    initialpath2 = RRTree2(idx122+idx212).coord;
    x_end2 =  RRTree2(idx122+idx212);
    while x_end2.parent ~= 0
        start = x_end2.parent;
        %             pathLength0 = pathLength0 + norm(RRTree1(start).coord-x_end.coord);
%         line([x_end2.coord(2), RRTree2(start).coord(2)], [x_end2.coord(1), RRTree2(start).coord(1)], 'Color', 'r', 'LineWidth', 3);
%         hold on
        initialpath2 = [initialpath2;RRTree2(start).coord];
        x_end2 = RRTree2(start);
    end
    
    initialpath = [initialpath1;initialpath2];
end

