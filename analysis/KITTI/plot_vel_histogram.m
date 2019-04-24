data = csvread("04_log.csv",1,0);

binNum = 10;
frameNum = 6;
displayRows = 3;
velMax = 200;

displayCols = ceil(frameNum / displayRows);
frames = floor(rand(frameNum,1)*data(end,1));

pfirstClasses = zeros(frameNum,1);
figure(1)
suptitle('Velocity Estimation without DFF')
for i = 1:displayRows
    for j = 1:displayCols
        fid = (i-1)*displayCols+j;
        subplot(displayRows, displayCols, fid)
        did1 = find(frames(fid) == data(:,1));
        did2 = did1(data(did1,9) < velMax);
        
        histogram(data(did2, 9), binNum)
        xlabel('velocity: m/s')
        ylabel('counts')
        totalNum = length(data(did1, 9));
        pfirstClass = sum(data(did1, 9) < velMax/binNum) / totalNum;
        pfirstClasses(fid) = pfirstClass;
        title(sprintf('frame %d \n(total: %d, first class: %d%%)',frames(fid), totalNum, floor(100*pfirstClass)));
    end
end

figure(2)
suptitle('Velocity Estimation with DFF')
for i = 1:displayRows
    for j = 1:displayCols
        fid = (i-1)*displayCols+j;
        subplot(displayRows, displayCols, fid)
        did1 = find(frames(fid) == data(:,1));
        did2 = did1(data(did1,10) < velMax);
        
        histogram(data(did2, 10), binNum)
        xlabel('velocity: m/s')
        ylabel('counts')
        totalNum = length(data(did1, 10));
        pfirstClass = sum(data(did1, 10) < velMax/binNum) / totalNum;
        pfirstClasses(fid) = pfirstClass;
        title(sprintf('frame %d \n(total: %d, first class: %d%%)',frames(fid), totalNum, floor(100*pfirstClass)));
    end
end

fprintf('vel_threshold: %f m/s, p_mean: %f, p_mode: %f, p_std: %f\n', velMax/binNum, mean(pfirstClasses), mode(pfirstClasses), std(pfirstClasses))

