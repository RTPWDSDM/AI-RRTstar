function drawpath(optimizedpath,r)

figure(r)

temp = [];

for i = 1: length(optimizedpath)-1
temp = [temp;line([optimizedpath(i,2),optimizedpath(i+1,2)],[optimizedpath(i,1),optimizedpath(i+1,1)], 'Color', 'c', 'LineWidth', 1)];
end
pause(0.5)
delete(temp)