N_row = 3;
N_station = 6;
y_max = 1000;

figure
subplot(N_row,6,1)
plot(sim_res.Time, sim_res.h1,'red')
hold on
plot(sim_res.Time,settings.control.level_min(1)*ones(size(sim_res.h1)),'black--')
hold on
plot(sim_res.Time,settings.control.level_max(1)*ones(size(sim_res.h1)),'black--')
ylabel("Level (m)")
title("Station 1 - Tank level")
grid on

subplot(N_row,6,2)
plot(sim_res.Time, sim_res.h2,'red')
hold on
plot(sim_res.Time,settings.control.level_min(2)*ones(size(sim_res.h1)),'black--')
hold on
plot(sim_res.Time,settings.control.level_max(2)*ones(size(sim_res.h1)),'black--')
grid on
ylabel("Level (m)")
title("Station 2 - Tank level")

subplot(N_row,6,3)
plot(sim_res.Time, sim_res.h3,'red')
hold on
plot(sim_res.Time,settings.control.level_min(3)*ones(size(sim_res.h1)),'black--')
hold on
plot(sim_res.Time,settings.control.level_max(3)*ones(size(sim_res.h1)),'black--')
grid on
ylabel("Level (m)")
title("Station 3 - Tank level")
grid on


subplot(N_row,6,4)
plot(sim_res.Time, sim_res.h4,'red')
hold on
plot(sim_res.Time,settings.control.level_min(4)*ones(size(sim_res.h1)),'black--')
hold on
plot(sim_res.Time,settings.control.level_max(4)*ones(size(sim_res.h1)),'black--')
grid on
ylabel("Level (m)")
title("Station 4 - Tank level")
grid on

subplot(N_row,6,5)
plot(sim_res.Time, sim_res.h5,'red')
hold on
plot(sim_res.Time,settings.control.level_min(5)*ones(size(sim_res.h1)),'black--')
hold on
plot(sim_res.Time,settings.control.level_max(5)*ones(size(sim_res.h1)),'black--')
grid on
ylabel("Level (m)")
title("Station 5 - Tank level")
grid on

subplot(N_row,6,6)
plot(sim_res.Time, sim_res.h6,'red')
hold on
plot(sim_res.Time,settings.control.level_min(6)*ones(size(sim_res.h1)),'black--')
hold on
plot(sim_res.Time,settings.control.level_max(6)*ones(size(sim_res.h1)),'black--')
grid on
ylabel("Level (m)")
title("Station 6 - Tank level")
grid on

subplot(N_row,6,7)
plot(sim_res.Time, sim_res.q1*3600,'blue')
hold on
plot(sim_res.Time, sim_res.q1_cso*3600)
legend('Gate','Overflow')
ylabel("Flow (m3/h)")
title("Station 1 - Gate flow")
grid on
ylim([0, y_max])

subplot(N_row,6,8)
plot(sim_res.Time, sim_res.q2*3600,'blue')
hold on
plot(sim_res.Time, sim_res.q2_cso*3600)
legend('Gate','Overflow')
ylabel("Flow (m3/h)")
title("Station 2 - Gate flow")
grid on
ylim([0, y_max])

subplot(N_row,6,9)
plot(sim_res.Time, sim_res.q3*3600,'blue')
hold on
plot(sim_res.Time, sim_res.q3_cso*3600)
legend('Gate','Overflow')
ylabel("Flow (m3/h)")
title("Station 3 - Gate flow")
grid on
ylim([0, y_max])

subplot(N_row,6,10)
plot(sim_res.Time, sim_res.q4*3600,'blue')
hold on
plot(sim_res.Time, sim_res.q4_cso*3600)
legend('Gate','Overflow')
ylabel("Flow (m3/h)")
title("Station 4 - Gate flow")
grid on
ylim([0, y_max])

subplot(N_row,6,11)
plot(sim_res.Time, sim_res.q5*3600,'blue')
hold on
plot(sim_res.Time, sim_res.q5_cso*3600)
legend('Gate','Overflow')
ylabel("Flow (m3/h)")
title("Station 5 - Gate flow")
grid on
ylim([0, y_max])

subplot(N_row,6,12)
plot(sim_res.Time, sim_res.q6*3600,'blue'),
hold on
plot(sim_res.Time, sim_res.q6_cso*3600)
legend('Gate','Overflow')
ylabel("Flow (m3/h)")
title("Station 6 - Gate flow")
grid on
ylim([0, y_max])

subplot(N_row,6,13)
plot(sim_res.Time, sim_res.OD1,'black')
ylabel("OD (-)")
title("Station 1 - Gate OD")
grid on

subplot(N_row,6,14)
plot(sim_res.Time, sim_res.OD2,'black')
ylabel("OD (-)")
title("Station 2 - Gate OD")
grid on

subplot(N_row,6,15)
plot(sim_res.Time, sim_res.OD3,'black')
ylabel("OD (-)")
title("Station 3 - Gate OD")
grid on

subplot(N_row,6,16)
plot(sim_res.Time, sim_res.OD4,'black')
ylabel("OD (-)")
title("Station 4 - Gate OD")
grid on

subplot(N_row,6,17)
plot(sim_res.Time, sim_res.OD5,'black')
ylabel("OD (-)")
title("Station 5 - Gate OD")
grid on

subplot(N_row,6,18)
plot(sim_res.Time, sim_res.OD6,'black')
ylabel("OD (-)")
title("Station 6 - Gate OD")
grid on
