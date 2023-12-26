function initialpath = Bitraceback(RRTree1,RRTree2,idx1,idx2)

initialpath1 = RRTree1(idx1).coord;
    x_end1 =  RRTree1(idx1);
    while x_end1.parent ~= 0
        start = x_end1.parent;
        %             pathLength0 = pathLength0 + norm(RRTree1(start).coord-x_end.coord);
%         line([x_end1.coord(2), RRTree1(start).coord(2)], [x_end1.coord(1), RRTree1(start).coord(1)], 'Color', 'r', 'LineWidth', 3);
%         hold on
        initialpath1 = [RRTree1(start).coord;initialpath1];
        x_end1 = RRTree1(start);
    end
    
    initialpath2 = RRTree2(idx2).coord;
    x_end2 =  RRTree2(idx2);
    while x_end2.parent ~= 0
        start = x_end2.parent;
        %             pathLength0 = pathLength0 + norm(RRTree1(start).coord-x_end.coord);
%         line([x_end2.coord(2), RRTree2(start).coord(2)], [x_end2.coord(1), RRTree2(start).coord(1)], 'Color', 'r', 'LineWidth', 3);
%         hold on
        initialpath2 = [initialpath2;RRTree2(start).coord];
        x_end2 = RRTree2(start);
    end
    
    initialpath = [initialpath1;initialpath2];

