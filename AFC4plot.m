clc
clear
close all
initNavigation
ptr = 'r20160905001解析后.txt.csv';%IMU 坐标系 后-左-下
Data = load(ptr);

flightdata.AFCtime = Data(:,2) - Data(1,2);
flightdata.AFCtimedt = Data(2:end,2) - Data(1:end-1,2);

flightdata.IMUADIS16507.sts = Data(:,3);
flightdata.IMUADIS16507.wx = Data(:,4);
flightdata.IMUADIS16507.wy = Data(:,5);
flightdata.IMUADIS16507.wz = Data(:,6);
flightdata.IMUADIS16507.fbx = Data(:,7);
flightdata.IMUADIS16507.fby = Data(:,8);
flightdata.IMUADIS16507.fbz = Data(:,9);
flightdata.IMUADIS16507.IMUtem = Data(:,10);
flightdata.IMUADIS16507.IMUtime = Data(:,11);
flightdata.IMUADIS16507.IMUdt = Data(2:end,11) - Data(1:end-1,11);
% 
flightdata.GPS.lat = Data(:,12);
flightdata.GPS.lon = Data(:,13);
flightdata.GPS.H = Data(:,14);
flightdata.GPS.type = Data(:,15);
flightdata.GPS.hdop = Data(:,16);
flightdata.GPS.vxecef = Data(:,17);
flightdata.GPS.vyecef = Data(:,18);
flightdata.GPS.vzecef = Data(:,19);

flightdata.TOF.dist = Data(:,20);
flightdata.TOF.Inten = Data(:,21);
flightdata.TOF.sts = Data(:,22);
%% 速度转换
[flightdata.GPS.vn,flightdata.GPS.ve,flightdata.GPS.vd] = ecef2nedv(flightdata.GPS.vxecef,...
                                flightdata.GPS.vyecef,...
                                flightdata.GPS.vzecef,...
                                flightdata.GPS.lat(1),flightdata.GPS.lon(1));

%%
figure(1)
subplot(4,2,1)
plot(flightdata.AFCtime,flightdata.IMUADIS16507.wx,'LineWidth',1.5);
grid on;
legend('wx');
xlabel('time/s');
ylabel('deg/s');
subplot(4,2,3)
plot(flightdata.AFCtime,flightdata.IMUADIS16507.wy,'LineWidth',1.5);
grid on;
legend('wy');
xlabel('time/s');
ylabel('deg/s');
subplot(4,2,5)
plot(flightdata.AFCtime,flightdata.IMUADIS16507.wz,'LineWidth',1.5);
grid on;
legend('wz');
xlabel('time/s');
ylabel('deg/s');
subplot(4,2,2)
plot(flightdata.AFCtime,flightdata.IMUADIS16507.fbx,'LineWidth',1.5);
grid on;
legend('fbx');
xlabel('time/s');
ylabel('m/s2');
subplot(4,2,4)
plot(flightdata.AFCtime,flightdata.IMUADIS16507.fby,'LineWidth',1.5);
grid on;
legend('fby');
xlabel('time/s');
ylabel('m/s2');
subplot(4,2,6)
plot(flightdata.AFCtime,flightdata.IMUADIS16507.fbz,'LineWidth',1.5);
grid on;
legend('fbz');
xlabel('time/s');
ylabel('m/s2');
subplot(4,2,7)
plot(flightdata.AFCtime,flightdata.IMUADIS16507.IMUtem,'LineWidth',1.5);
grid on;
legend('temperature');
xlabel('time');
ylabel('T');
subplot(4,2,8)
plot(flightdata.AFCtime(1:end-1),flightdata.IMUADIS16507.IMUdt/100,'LineWidth',1.5);
hold on;
plot(flightdata.AFCtime(1:end-1),flightdata.AFCtimedt,'LineWidth',1.5);
grid on;
legend('IMUdt','AFCdt');
xlabel('time');
set(gcf,'position',[500,100,1200,800]); 
%%
figure(2)
subplot(4,2,1)
plot(flightdata.AFCtime,flightdata.GPS.lat,'LineWidth',1.5);
grid on;
legend('latitude');
xlabel('time/s');
ylabel('deg');
subplot(4,2,3)
plot(flightdata.AFCtime,flightdata.GPS.lon,'LineWidth',1.5);
grid on;
legend('lontitude');
xlabel('time/s');
ylabel('deg');
subplot(4,2,5)
plot(flightdata.AFCtime,flightdata.GPS.H,'LineWidth',1.5);
grid on;
legend('altitude');
xlabel('time/s');
ylabel('H');
subplot(4,2,7)
plot(flightdata.AFCtime,flightdata.GPS.hdop,'LineWidth',1.5);
hold on;
plot(flightdata.AFCtime,flightdata.GPS.type,'LineWidth',1.5);
grid on;
legend('GPShdop','GPStype');
xlabel('time/s');
subplot(4,2,[2,4,6,8])
plot3(flightdata.GPS.lat,flightdata.GPS.lon,flightdata.GPS.H,'o-','LineWidth',1.5)
grid on;
xlabel('latitude');
ylabel('lontitude');
zlabel('Altitude');
legend('traj');
set(gcf,'position',[300,100,1500,800]); 

%%
figure(3)
subplot(3,2,1)
plot(flightdata.AFCtime,flightdata.GPS.vxecef,'LineWidth',1.5);
grid on;
legend('vx_e_c_e_fGPS');
xlabel('time/s');
ylabel('m/s');
subplot(3,2,3)
plot(flightdata.AFCtime,flightdata.GPS.vyecef,'LineWidth',1.5);
grid on;
legend('vy_e_c_e_f-GPS');
xlabel('time/s');
ylabel('m/s');
subplot(3,2,5)
plot(flightdata.AFCtime,flightdata.GPS.vzecef,'LineWidth',1.5);
grid on;
legend('vz_e_c_e_f-GPS');
xlabel('time/s');
ylabel('m/s');
subplot(3,2,2)
plot(flightdata.AFCtime,flightdata.GPS.vn,'LineWidth',1.5);
grid on;
legend('vn-GPS');
xlabel('time/s');
ylabel('m/s');
subplot(3,2,4)
plot(flightdata.AFCtime,flightdata.GPS.ve,'LineWidth',1.5);
grid on;
legend('ve-GPS');
xlabel('time/s');
ylabel('m/s');
subplot(3,2,6)
plot(flightdata.AFCtime,flightdata.GPS.vd,'LineWidth',1.5);
grid on;
legend('vd-GPS');
xlabel('time/s');
ylabel('m/s');
set(gcf,'position',[300,100,1500,800]); 

%%
figure(4)
subplot(2,1,1)
plot(flightdata.AFCtime,flightdata.TOF.dist/100,'LineWidth',1.5);
grid on;
legend('dist');
xlabel('time/s');
ylabel('m');
subplot(2,1,2)
plot(flightdata.AFCtime,flightdata.TOF.Inten,'LineWidth',1.5);
grid on;
legend('Inten');
xlabel('time/s');

