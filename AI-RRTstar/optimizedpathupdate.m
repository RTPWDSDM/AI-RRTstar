function [optimizedpath,cbest,update] = optimizedpathupdate(x_new,optimizedpath,map,selectpool,cbest)

% if checkpath(x_new,optimizedpath(selectpool,:),map)&&checkpath(x_new,optimizedpath(selectpool+2,:),map)
%     cbesttemp = 0;
%     optimizedpathtemp = [optimizedpath(1:selectpool,:);x_new;optimizedpath(selectpool+2:end,:)];
%     for i = 1:length(optimizedpath)-1
%         cbesttemp = cbesttemp + norm(optimizedpathtemp(i,:)-optimizedpathtemp(i+1,:));
%     end
%     if cbesttemp<=cbest
%         cbest = cbesttemp;
%         update = 1;
%         optimizedpath = optimizedpathtemp;
% %                 figure(1)
% %                 scatter(x_new(2),x_new(1),'filled','r');
% %                 hold on;
%     else
%         update = 0;
%     end
% else
%     update = 0;
% end

if checkpath(x_new,optimizedpath(selectpool,:),map)&&checkpath(x_new,optimizedpath(selectpool+2,:),map)
    cbesttemp = 0;
    optimizedpathtemp = [optimizedpath(1:selectpool,:);x_new;optimizedpath(selectpool+2:end,:)];
    for i = 1:length(optimizedpath)-1
        cbesttemp = cbesttemp + norm(optimizedpathtemp(i,:)-optimizedpathtemp(i+1,:));
    end
    if cbesttemp<=cbest
        cbest = cbesttemp;
        update = 1;
        optimizedpath = optimizedpathtemp;
%                 figure(1)
%                 scatter(x_new(2),x_new(1),'filled','r');
%                 hold on;
    else
        update = 0;
    end
else
    update = 0;
end