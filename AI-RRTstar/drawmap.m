C1 = addcolor(215);
C3 = addcolor(178);
C5 = addcolor(240);
C4 = addcolor(232);

        
        figure
        map0=map;
         subplot(122)
        imshow(map0);box on;    axis on;hold on
        %draw RRTree1
        %draw RRTree2
        %draw RRTree3
        for i=2:length(RRTree1)
        scatter(RRTree1(i).coord(2),RRTree1(i).coord(1),10,'o','filled','MarkerFaceColor',[C3]);
        hold on
        end
        for i=2:length(RRTree2)
        scatter(RRTree2(i).coord(2),RRTree2(i).coord(1),10,'o','filled','MarkerFaceColor',[C1]);
        hold on
        end
        for i=2:length(RRTree3)
        scatter(RRTree3(i).coord(2),RRTree3(i).coord(1),10,'o','filled','MarkerFaceColor',[C5]);
        hold on
        end
         scatter(x_goal.coord(2),x_goal.coord(1),100,'p','filled','MarkerFaceColor',[C1]);
        hold on;
        scatter(x_start.coord(2),x_start.coord(1),100,'s','filled','MarkerFaceColor',[C3]);
        hold on;
        box on;
        subplot(121)
        imshow(map0); box on;hold on
          for i=2:68
        scatter(RRTree1(i).coord(2),RRTree1(i).coord(1),10,'o','filled','MarkerFaceColor',[C3]);
        hold on
        end
        for i=2:68
        scatter(RRTree2(i).coord(2),RRTree2(i).coord(1),10,'o','filled','MarkerFaceColor',[C1]);
        hold on
        end
         scatter(x_goal.coord(2),x_goal.coord(1),100,'p','filled','MarkerFaceColor',[C1]);
        hold on;
        scatter(x_start.coord(2),x_start.coord(1),100,'s','filled','MarkerFaceColor',[C3]);
        hold on;
          for i=2:length(RRTree3)
        scatter(RRTree3(i).coord(2),RRTree3(i).coord(1),10,'o','filled','MarkerFaceColor',[C5]);
        hold on
        end
        box on;
            axis on
        %draw drawxnew
        
%         subplot(133)
%         imshow(map0)
        %draw optimized path