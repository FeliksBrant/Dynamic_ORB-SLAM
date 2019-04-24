clc
close all
clear

set(0,'defaultAxesFontSize',20);
set(0, 'DefaultLineLineWidth', 2);

Ground_04 = load('04_ground_truth.txt');
Huber_04 = load('04_ORB_SLAM2_sol.txt');

DFF_04_1 = load('04_DFF1.txt');
DFF_04_2 = load('04_DFF2.txt');
DFF_04_3 = load('04_DFF3.txt');

dynamic = {DFF_04_1,DFF_04_2,DFF_04_3};
for i=1:length(dynamic)
    figure(i);
    plot(Ground_04(:,4),Ground_04(:,12));
    xlabel('x');
    ylabel('z');

    %title(['max velocity ', num2str((i-1)*5+10)]);
    hold on;
    plot(Huber_04(:,4),Huber_04(:,12));
    plot(dynamic{i}(:,4), dynamic{i}(:,12));
    plot(Ground_04(1,4),Ground_04(1,12),'*','MarkerSize',10);
    legend('ground truth','ORB-SLAM2','DFF','start point');
end

%% calculate relative error matrices and y-axis rotation error
[r,c] = size(Ground_04);
T_H = zeros(1,r);
T_S1 = zeros(1,r);
T_S2 = zeros(1,r);
T_S3 = zeros(1,r);
R_H = zeros(1,r);
R_S1 = zeros(1,r);
R_S2 = zeros(1,r);
R_S3 = zeros(1,r);
% calculate relative error matrices
for j = 1:r
Q = reshape(Ground_04(j,:),[3,4]);
P_H = reshape(Huber_04(j,:),[3,4]);
P_S1 = reshape(DFF_04_1(j,:),[3,4]);
P_S2 = reshape(DFF_04_2(j,:),[3,4]);
P_S3 = reshape(DFF_04_3(j,:),[3,4]);

T_H(j) = sqrt((Ground_04(j,4)-Huber_04(j,4))^2 + (Ground_04(j,12)-Huber_04(j,12))^2);
T_S1(j) = sqrt((Ground_04(j,4)-DFF_04_1(j,4))^2 + (Ground_04(j,12)-DFF_04_1(j,12))^2);
T_S2(j) = sqrt((Ground_04(j,4)-DFF_04_2(j,4))^2 + (Ground_04(j,12)-DFF_04_2(j,12))^2);
T_S3(j) = sqrt((Ground_04(j,4)-DFF_04_3(j,4))^2 + (Ground_04(j,12)-DFF_04_3(j,12))^2);

Eu_g = rotm2eul(Q(1:3,1:3));
Eu_h = rotm2eul(P_H(1:3,1:3));
Eu_s1 = rotm2eul(P_S1(1:3,1:3));
Eu_s2 = rotm2eul(P_S2(1:3,1:3));
Eu_s3 = rotm2eul(P_S3(1:3,1:3));
R_H(j) = sqrt(abs(Eu_g(2)^2 - Eu_h(2)^2));
R_S1(j) = sqrt(abs(Eu_g(2)^2 - Eu_s1(2)^2));
R_S2(j) = sqrt(abs(Eu_g(2)^2 - Eu_s2(2)^2));
R_S3(j) = sqrt(abs(Eu_g(2)^2 - Eu_s3(2)^2));
end
disp('Translation Root Mean Square Error (ORB-SLAM2): ');
disp(mean(T_H));
disp('Translation Root Mean Square Error (DFF): ');
T_S =[T_S1,T_S2,T_S3];
disp(mean(T_S));
disp('Rotation Root Mean Square Error (ORB-SLAM2): ');
disp(mean(R_H));
disp('Rotation Root Mean Square Error (DFF): ');
R_S = [R_S1,R_S2,R_S3];
disp(mean(R_S));