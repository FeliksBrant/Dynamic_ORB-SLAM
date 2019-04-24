function pose = orb2devon(T_tc, traj)

traj(:,13:15) = 0;
traj(:,16) = 1;
pose = zeros(4,4,size(traj,1));

for i=1:size(traj,1)
    pose(1,1:4,i) = traj(i,1:4);
    pose(2,1:4,i) = traj(i,5:8);
    pose(3,1:4,i) = traj(i,9:12);
    pose(4,1:4,i) = traj(i,13:16);
    pose(:,:,i) = T_tc * pose(:,:,i);
    
end


end