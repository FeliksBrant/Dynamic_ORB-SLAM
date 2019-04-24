ko = readKnownOrientations(pwd);

gps = readGpsTopocentric(pwd);
start_frame = 1;
end_frame = 2087;
gps = gps(start_frame:end_frame);

gt = zeros(3,1,size(gps,2));

%Create ground truth trajectory
for i=1:size(gps,2)
    gt(1,i) = gps(i).x;
    gt(2,i) = gps(i).y;
    gt(3,i) = gps(i).z;
    
end

traj = str2num(fileread(fullfile('CameraTrajectory_DORB_tuned.txt')));
traj1 = str2num(fileread(fullfile('CameraTrajectory_Kitti_Params.txt')));
traj2 = str2num(fileread(fullfile('CameraTrajectory_ORB_tuned.txt')));

T_tc = [ko(1).C_tc zeros(3,1);
        zeros(1,3) 1];
    
pose = orb2devon(T_tc, traj);
pose1 = orb2devon(T_tc, traj1);
pose2 = orb2devon(T_tc, traj2);


x = reshape(pose(1,4,:),1,[]);
y = reshape(pose(2,4,:),1,[]);
z = reshape(pose(3,4,:),1,[]);

x1 = reshape(pose1(1,4,:),1,[]);
y1 = reshape(pose1(2,4,:),1,[]);
z1 = reshape(pose1(3,4,:),1,[]);

x2 = reshape(pose2(1,4,:),1,[]);
y2 = reshape(pose2(2,4,:),1,[]);
z2 = reshape(pose2(3,4,:),1,[]);

figure(1)
plot(x,y,'DisplayName','DORB SLAM with tuned ORB Params')
title('Devon Island Rover X-Y Trajectories')
hold on
plot(x1,y1,'DisplayName','ORB SLAM with Kitti ORB Params')
plot(x2,y2,'DisplayName','ORB SLAM with tuned ORB Params')
plot(gt(1,:),gt(2,:),'DisplayName','GPS (Ground Truth)')
xlabel('$$x\,(m)$$','Fontsize',14,'Interpreter','latex')
ylabel('$$y\,(m)$$','Fontsize',14,'Interpreter','latex')
legend;

hold off

figure(2)
plot(z,'DisplayName','DORB SLAM with tuned ORB Params')
title('Devon Island Rover Z Trajectories')
hold on
plot(z1,'DisplayName','ORB SLAM with Kitti ORB Params')
plot(z2,'DisplayName','ORB SLAM with tuned ORB Params')

plot(gt(3,:),'DisplayName','GPS (Ground Truth)')
xlabel('$$Frame$$','Fontsize',14,'Interpreter','latex')
ylabel('$$z\,(m)$$','Fontsize',14,'Interpreter','latex')
leg = legend;
leg.Location = 'northwest';

