function T = calcThresh(curve_1, curve_2)

if length(curve_1)>length(curve_2)
    curve_2(end+1:length(curve_1)) = 0;
elseif length(curve_2)>length(curve_1)
    curve_1(end+1:length(curve_2)) = 0;
end

n = 0;

for i = 1:length(curve_1)
    n = n+1;
    if curve_1(i)<curve_2(i)
        break;
    end
end
    
T = n;


%% show figures for testing
% figure
% subplot 211
% plot(curve_1>curve_2)
% 
% subplot 212
% plot(medfilt1(double(curve_1>=curve_2),100))
