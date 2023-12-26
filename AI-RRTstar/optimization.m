function [optimizedpath,cbestdraw] = optimization(initialpath,map)
global cbest cbestdraw
global drawxnew
global d
%%
optimizedpath = initialpath;


% for i = 1:length(optimizedpath)-2
%     partialcbest(i,1) = distancecost(optimizedpath(i,:),optimizedpath(i+2,:));
% end
% partialcbest = [partialcbest zeros(length(partialcbest),1) zeros(length(partialcbest),1)]; % [partiallength  noupdatetime]
% seperatednum = zeros(length(partialcbest),1) + 1; % seperated nodes number
epoch = 1;
N = length(optimizedpath);
p = [];
fixnum = N;
pinitial = 1/(N-2)*ones(1,N-2);
p = pinitial; % possibility
for t = 1:N-2
    proulette(1,t) = sum(pinitial(1:t));
end
proulette = [0,proulette];
k = zeros(1,N-2); % success count
u = zeros(1,N-2); % fail count
w = zeros(1,N-2); % para
r = zeros(1,N-2); % encourage or disencourage
failnum = 50;
temperature = 0.8;
% wi(t+1) = wi(t) + (ri(t+1) – wi(t))/(ki(t)+1);
d=zeros(1,N-2); %plot
while epoch< 5000
    
    randnum = rand;
    for t = 1:N-2
        if proulette(t)<randnum&&randnum<proulette(t+1)
            selectpool = t;
            break
        end
    end
    x_new = samplinginpool(optimizedpath,selectpool,map);
    drawxnew = [drawxnew;x_new];
    %     figure(2)
    %     scatter(x_new(2),x_new(1));
    %     hold on
    [optimizedpath,cbest,update] = optimizedpathupdate(x_new,optimizedpath,map,selectpool,cbest);
    cbestdraw = [cbestdraw,cbest];
    if update
        r(1,selectpool) = 1;
        k(1,selectpool) = k(1,selectpool) + 1;
        u(1,selectpool) = 0;
        %update the neighbour sampling pool

%         partialcbest(selectpool,1) = distancecost(optimizedpath(selectpool,:),optimizedpath(selectpool+seperatednum(selectpool),:));
%         partialcbest(selectpool,2) = 0;
    else
        u(1,selectpool) = u(1,selectpool) + 1;
        k(1,selectpool) = k(1,selectpool) + 1;
%         partialcbest(selectpool,2) = partialcbest(selectpool,2) + 1;
%         if 2*failnum>partialcbest(selectpool,2)&&partialcbest(selectpool,2)>failnum
%             % probability cut down
%             1
%         elseif partialcbest >= 10*failnum
%             % change the ellipse
%             if partialcbest(selectpool,3)==0
%                 partialcbest(selectpool,3) = 1; %1 means it has been punished
%                 if selectpool + seperatednum(selectpool,1) + 1 <= length(optimizedpath)
%                     seperatednum(selectpool,1) = seperatednum(selectpool,1) + 1;
%                     2
%                 end
%             end
%         end
        if u(1,selectpool) >= failnum&&u(1,selectpool) <= 10*failnum
%     if u(1,selectpool) >= failnum
            r(1,selectpool) = -1;
        else
            r(1,selectpool) = 0;
        end
    end
    w(1,selectpool) = w(1,selectpool) + abs(r(1,selectpool))*(r(1,selectpool) - w(1,selectpool))/(k(1,selectpool) + 1);
       %update the neighbour sampling pool
    if selectpool==1
        r(1,selectpool+1)=1/2;
        w(1,selectpool+1) = w(1,selectpool+1) + (r(1,selectpool+1))/(k(1,selectpool+1) + 1);
    elseif selectpool==N-2
        r(1,selectpool-1) = 1/2;
        w(1,selectpool-1) = w(1,selectpool-1) + (r(1,selectpool-1))/(k(1,selectpool-1) + 1);
    else
        r(1,selectpool+1)=1/2;
        w(1,selectpool+1) = w(1,selectpool+1) + (r(1,selectpool+1))/(k(1,selectpool+1) + 1);
        r(1,selectpool-1) = 0.1;
        w(1,selectpool-1) = w(1,selectpool-1) + (r(1,selectpool-1))/(k(1,selectpool-1) + 1);

    end
    psum = 0;
    for i=1:length(p)
        psum = exp(w(1,i)/temperature)+psum;
    end
    for i=1:length(p)
        p(1,i) = exp(w(1,i)/temperature)/psum;
    end
    proulette = [];
    for t = 1:N-2
        proulette(1,t) = sum(p(1:t));
    end
    proulette = [0,proulette];
    for i=1:length(proulette)-1
        d(epoch,i)=proulette(i+1)-proulette(i);
    end
    
    epoch = epoch +1 ;
    
end
% partialcbest
