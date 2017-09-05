%连接数据库PATH_CREATE_FLOW_64并查询到样本数据
%


clc;
clear;
%conn = database('driver_data','root','2013150036','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/driver_data');
conn=database('orcl','C##WEEK','C##WEEK','oracle.jdbc.driver.OracleDriver','jdbc:oracle:thin:@localhost:1521:orcl');%连接到oracle

%query='SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_TRUN,COUNT_SUDDEN_ADD,COUNT_SUDDEN_SUB,COUNT_SUDDEN_OIL,COUNT_OVER_SPEED,COUNT_LANE_CHANGE,COUNT_WARM_REMIND,COUNT_TIMING_BELT,COUNT_TREMOR,COUNT_IDLE_SPEED,COUNT_JAR_FAULT,COUNT_LIQUID_TOOLOW,MILEAGE,ENGINE_RUNTIME,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,(COOL_LIQUID_TEMP1+COOL_LIQUID_TEMP2+COOL_LIQUID_TEMP3+COOL_LIQUID_TEMP4+COOL_LIQUID_TEMP5)/5 AS COOL_LIQUID_TIMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRES,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm';
% 15+7+5+2+7*5+1 增加正时皮带等报警项 算上FLOW数据7*5
queryTimes=4;
queryStr=cell(1,queryTimes);


queryStr(1)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% baseline 只用locate。

queryStr(2)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +急加速 COUNT_SUDDEN_ADD

queryStr(3)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_TRUN,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +急转弯 COUNT_SUDDEN_TRUN

queryStr(4)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_IDLE_SPEED,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +怠速不稳报警 COUNT_IDLE_SPEED

queryStr(5)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_OIL,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +急轰油次数 COUNT_SUDDEN_OIL

queryStr(6)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_LANE_CHANGE,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +变道次数 COUNT_LANE_CHANGE

queryStr(7)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_OVER_SPEED,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +超速次数 COUNT_OVER_SPEED

queryStr(8)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_SUB,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +急减速次数 COUNT_SUDDEN_SUB

queryStr(9)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,ENGINE_RUNTIME,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +发动机运行时间  ENGINE_RUNTIME

queryStr(10)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_TREMOR,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +震动报警 COUNT_TREMOR

queryStr(11)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_WARM_REMIND,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % % baseline +热车提醒 COUNT_WARM_REMIND

queryStr(12)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_LIQUID_TOOLOW,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +冷却液温度过低 COUNT_LIQUID_TOOLOW

queryStr(13)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_TIMING_BELT,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % % baseline +正时皮带 COUNT_TIMING_BELT

queryStr(14)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% %baseline+进气温度 AIR_INTAKE_TEMP1~5

queryStr(15)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +蓄电池电压  BATTERY_VOL1~5

queryStr(16)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,MILEAGE,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% %baseline+行驶里程 MILEAGE

queryStr(17)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% %baseline+空气流量 AIR_RATE_OF_FLOW1~5

queryStr(18)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,(COOL_LIQUID_TEMP1+COOL_LIQUID_TEMP2+COOL_LIQUID_TEMP3+COOL_LIQUID_TEMP4+COOL_LIQUID_TEMP5)/5 AS COOL_LIQUID_TIMP,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% %baseline+冷却液温度 COOL_LIQUID_TEMP1~5

queryStr(19)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRES,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% %baseline+大气压力 ATMOSPHERE_PRESSURE1~5

queryStr(20)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% %baseline+发动机转速 ENGINE_SPEED1~5

queryStr(21)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_JAR_FAULT,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% % baseline +电瓶故障报警 COUNT_JAR_FAULT

queryStr(22)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};
% %baseline+计算负荷 CALCULATE_COST1~5


% % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数
queryStr(23)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};

% % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒
queryStr(24)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};

% % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、行驶里程
queryStr(25)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,MILEAGE,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};

% % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、行驶里程、空气流量、冷却液温度值、大气压力、发动机转速、电瓶故障报警、计算负荷
queryStr(26)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,MILEAGE,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(COOL_LIQUID_TEMP1+COOL_LIQUID_TEMP2+COOL_LIQUID_TEMP3+COOL_LIQUID_TEMP4+COOL_LIQUID_TEMP5)/5 AS COOL_LIQUID_TIMP,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRES,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,COUNT_JAR_FAULT,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};


%将5个取样数据用取均值的做法
queryStr(27)={'SELECT COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,(SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,MILEAGE,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(COOL_LIQUID_TEMP1+COOL_LIQUID_TEMP2+COOL_LIQUID_TEMP3+COOL_LIQUID_TEMP4+COOL_LIQUID_TEMP5)/5 AS COOL_LIQUID_TIMP,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRESSURE,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,COUNT_JAR_FAULT,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};

%将5个取样数据用取均值的做法 去除掉mileage
queryStr(28)={'SELECT COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,(SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(COOL_LIQUID_TEMP1+COOL_LIQUID_TEMP2+COOL_LIQUID_TEMP3+COOL_LIQUID_TEMP4+COOL_LIQUID_TEMP5)/5 AS COOL_LIQUID_TIMP,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRESSURE,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,COUNT_JAR_FAULT,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};


% % baseline+急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、（将行驶里程去除）、空气流量
queryStr(29)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};

% % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、（将行驶里程去除）、空气流量、冷却液温度值、大气压力、发动机转速、电瓶故障报警、计算负荷
queryStr(30)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(COOL_LIQUID_TEMP1+COOL_LIQUID_TEMP2+COOL_LIQUID_TEMP3+COOL_LIQUID_TEMP4+COOL_LIQUID_TEMP5)/5 AS COOL_LIQUID_TIMP,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRES,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,COUNT_JAR_FAULT,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};



% % (去除发动机运行时间\里程)baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、(去除发动机运行时间)、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、（将行驶里程去除）、空气流量、冷却液温度值、大气压力、发动机转速、电瓶故障报警、计算负荷
queryStr(31)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,COUNT_TREMOR,COUNT_WARM_REMIND,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(COOL_LIQUID_TEMP1+COOL_LIQUID_TEMP2+COOL_LIQUID_TEMP3+COOL_LIQUID_TEMP4+COOL_LIQUID_TEMP5)/5 AS COOL_LIQUID_TIMP,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRES,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,COUNT_JAR_FAULT,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};

% %(去除冷却液温度\里程) baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、（将行驶里程去除）、空气流量、(去除冷却液温度)、大气压力、发动机转速、电瓶故障报警、计算负荷
queryStr(32)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRES,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,COUNT_JAR_FAULT,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};

% %(去除蓄电池电压\里程)baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、(去除电池电压)、（将行驶里程去除）、空气流量、冷却液温度值、大气压力、发动机转速、电瓶故障报警、计算负荷
queryStr(33)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(COOL_LIQUID_TEMP1+COOL_LIQUID_TEMP2+COOL_LIQUID_TEMP3+COOL_LIQUID_TEMP4+COOL_LIQUID_TEMP5)/5 AS COOL_LIQUID_TIMP,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRES,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,COUNT_JAR_FAULT,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};

% %(去除发动机运行时间\冷却液温度\蓄电池电压\里程) baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、(去除发动机运行时间)、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、(去除电池电压)、（将行驶里程去除）、空气流量、(去除冷却液温度)、大气压力、发动机转速、电瓶故障报警、计算负荷
queryStr(34)={'SELECT (SPEED_1+SPEED_2+SPEED_3+SPEED_4+SPEED_5)/5 AS SPEED,(TURN_SPEED_1+TURN_SPEED_2+TURN_SPEED_3+TURN_SPEED_4+TURN_SPEED_5)/5 AS TURN_SPEED,(ACC_SPEED1+ACC_SPEED2+ACC_SPEED3+ACC_SPEED4+ACC_SPEED5)/5 AS ACC_SPEED,COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE,COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,COUNT_TREMOR,COUNT_WARM_REMIND,COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(AIR_RATE_OF_FLOW1+AIR_RATE_OF_FLOW2+AIR_RATE_OF_FLOW3+AIR_RATE_OF_FLOW4+AIR_RATE_OF_FLOW5)/5 AS AIR_TATE_OF_FLOW,(ATMOSPHERE_PRESSURE1+ATMOSPHERE_PRESSURE2+ATMOSPHERE_PRESSURE3+ATMOSPHERE_PRESSURE4+ATMOSPHERE_PRESSURE5)/5 AS ATMOSPHERE_PRES,(ENGINE_SPEED1+ENGINE_SPEED2+ENGINE_SPEED3+ENGINE_SPEED4+ENGINE_SPEED5)/5 AS ENGINE_SPEED,COUNT_JAR_FAULT,(CALCULATE_COST1+CALCULATE_COST2+CALCULATE_COST3+CALCULATE_COST4+CALCULATE_COST5)/5 AS CALCULATE_COST,IF_ALARM,VEH_ID from PATH_CREATE_FLOW_64  order by if_alarm'};


resultLR=zeros(queryTimes*21,9);
resultLRmax=zeros(queryTimes,10);
for query_index=1:1:queryTimes
    
    resultLR((query_index-1)*21+1,:)=[-query_index,-query_index,-query_index,-query_index,-query_index,-query_index,-query_index,-query_index,-query_index];
    curs=exec(conn,char(queryStr(query_index)));
    curs=fetch(curs);
    
    data=cell2mat(curs.Data(:,1:length(curs.Data(1,:))));
    close(curs);
    scale=size(data);
    row=scale(1);
    list=scale(2);%
    beforeNormal=data;
    %normalization
    for i=1:1:(list-2)
        minData=min(data(:,i));
        maxData=max(data(:,i));
        %dataNormal(:,i)=(data(:,i)-minData)/(maxData-minData);
        data(:,i)=(data(:,i)-minData)/(maxData-minData);
    end
    %     query2='SELECT count(*) from PATH_CREATE_FLOW_64  where if_alarm=1';
    %     curs2=exec(conn,query2);
    %     curs2=fetch(curs2);
    %     dataAlarm=cell2mat(curs2.Data);
    %     close(curs2);
    dataAlarm=sum(data(:,list-1));
    %接下来执行LR并计算
    
    noAlarm=row-dataAlarm;
    
    %接下来进行交叉验证操作
    
    %
    temp_tcross_result=zeros(190,9);%用于存放交叉验证的十次交叉对应的所有结果
    for tcross=1:10
        %mleft表示安全的数据集中测试集的左侧，mright表示右侧
        %nleft表示危险的数据集中测试集的左侧，nright表示右侧
        mleft=round(noAlarm/10)*(tcross-1)+1;
        mright=round(noAlarm/10)*(tcross+6);
        
        nleft=round(dataAlarm/10)*(tcross-1)+1;
        nright=round(dataAlarm/10)*(tcross+6);
        xSet=[];
        ySet=[];
        test_x=[];
        test_y=[];
        a_xSet=[];
        a_ySet=[];
        a_test_x=[];
        a_test_y=[];
        DRIVERS=[];
        if tcross>4
            xSet=[data(1:mod(mright,noAlarm),1:list-2) ; data(mleft:noAlarm,1:list-2);  data(noAlarm+1:noAlarm+mod(nright,dataAlarm),1:list-2) ; data(nleft+noAlarm:row,1:list-2)];
            ySet=[data(1:mod(mright,noAlarm),list-1) ; data(mleft:noAlarm,list-1);  data(noAlarm+1:noAlarm+mod(nright,dataAlarm),list-1) ; data(nleft+noAlarm:row,list-1)];
            test_x=[data(mod(mright,noAlarm)+1:mleft-1,1:list-2) ; data(noAlarm+mod(nright,dataAlarm)+1:nleft+dataAlarm-1,1:list-2)];
            test_y=[data(mod(mright,noAlarm)+1:mleft-1,list-1) ; data(noAlarm+mod(nright,dataAlarm)+1:nleft+dataAlarm-1,list-1)];
            DRIVERS=[data(mod(mright,noAlarm)+1:mleft-1,list) ; data(noAlarm+mod(nright,dataAlarm)+1:nleft+dataAlarm-1,list)];
            
            a_xSet=[beforeNormal(1:mod(mright,noAlarm),1:list-2) ; beforeNormal(mleft:noAlarm,1:list-2);  beforeNormal(noAlarm+1:noAlarm+mod(nright,dataAlarm),1:list-2) ; beforeNormal(nleft+noAlarm:row,1:list-2)];
            a_ySet=[beforeNormal(1:mod(mright,noAlarm),list-1) ; beforeNormal(mleft:noAlarm,list-1);  beforeNormal(noAlarm+1:noAlarm+mod(nright,dataAlarm),list-1) ; beforeNormal(nleft+noAlarm:row,list-1)];
            a_test_x=[beforeNormal(mod(mright,noAlarm)+1:mleft-1,1:list-2) ; beforeNormal(noAlarm+mod(nright,dataAlarm)+1:nleft+dataAlarm-1,1:list-2)];
            a_test_y=[beforeNormal(mod(mright,noAlarm)+1:mleft-1,list-1) ; beforeNormal(noAlarm+mod(nright,dataAlarm)+1:nleft+dataAlarm-1,list-1)];
            %DRIVERS=[beforeNormal(mod(mright,noAlarm)+1:mleft-1,list) ; beforeNormal(noAlarm+mod(nright,beforeNormalAlarm)+1:nleft+beforeNormalAlarm-1,list)];
            
        else
            xSet=[data(mleft:mright,1:list-2) ; data(nleft+noAlarm:nright+noAlarm,1:list-2)];
            ySet=[data(mleft:mright,list-1) ; data(nleft+noAlarm:nright+noAlarm,list-1)];
            test_x=[data(1:mleft-1,1:list-2) ; data(mright+1:noAlarm,1:list-2) ; data(noAlarm+1:nleft+noAlarm-1,1:list-2); data(noAlarm+nright+1:row,1:list-2)];
            test_y=[data(1:mleft-1,list-1) ; data(mright+1:noAlarm,list-1) ; data(noAlarm+1:nleft+noAlarm-1,list-1); data(noAlarm+nright+1:row,list-1)];
            DRIVERS=[data(1:mleft-1,list) ; data(mright+1:noAlarm,list) ; data(noAlarm+1:nleft+noAlarm-1,list); data(noAlarm+nright+1:row,list)];
            
            a_xSet=[beforeNormal(mleft:mright,1:list-2) ; beforeNormal(nleft+noAlarm:nright+noAlarm,1:list-2)];
            a_ySet=[beforeNormal(mleft:mright,list-1) ; beforeNormal(nleft+noAlarm:nright+noAlarm,list-1)];
            a_test_x=[beforeNormal(1:mleft-1,1:list-2) ; beforeNormal(mright+1:noAlarm,1:list-2) ; beforeNormal(noAlarm+1:nleft+noAlarm-1,1:list-2); beforeNormal(noAlarm+nright+1:row,1:list-2)];
            a_test_y=[beforeNormal(1:mleft-1,list-1) ; beforeNormal(mright+1:noAlarm,list-1) ; beforeNormal(noAlarm+1:nleft+noAlarm-1,list-1); beforeNormal(noAlarm+nright+1:row,list-1)];
            %DRIVERS=[beforeNormal(1:mleft-1,list) ; beforeNormal(mright+1:noAlarm,list) ; beforeNormal(noAlarm+1:nleft+noAlarm-1,list); beforeNormal(noAlarm+nright+1:row,list)];
            
        end
        
        b=glmfit(xSet,ySet,'binomial', 'link', 'logit');
        
        p = glmval(b,test_x, 'logit');
        result=[p test_y DRIVERS];
        
        
        testRow=length(result(:,1));
        result=sortrows(result,1);%按第一列对result进行排序
        resultEnd=result(:,2);
        resultDriver=result(:,2:3);%车辆
        
        rateCount=19;
        rate=linspace(0.5,0.95,rateCount);
        setSafe=zeros(1,rateCount);
        setRisk=zeros(1,rateCount);
        
        TP=zeros(1,rateCount);%true positive 真实为1且预测为1
        FN=zeros(1,rateCount);%false negative 真实为1而预测为0
        FP=zeros(1,rateCount);%false positive 真实为0而预测为1
        TN=zeros(1,rateCount);%true negative 真实为0且预测为0
        
        Accuracy=zeros(1,rateCount);
        Precision=zeros(1,rateCount);
        Recall=zeros(1,rateCount);
        F1=zeros(1,rateCount);
        TrueNegativeRate=zeros(1,rateCount);
        PF=zeros(1,rateCount);
        NF=zeros(1,rateCount);
        
        %finalResult=zeros(rateCount,9);
        for i=1:1:length(rate)
            setSafe(i)=round(testRow*rate(i));%安全的轨迹
            setRisk(i)=testRow-setSafe(i);%危险的轨迹数据
            
            [TP(i),FN(i),FP(i),TN(i),Accuracy(i),Precision(i),Recall(i),F1(i)]=getPro(resultEnd,resultDriver,testRow,rate(i),setSafe(i),setRisk(i));
            temp_tcross_result(rateCount*(tcross-1)+i,:)=[TP(i),FN(i),FP(i),TN(i),Accuracy(i),Precision(i),Recall(i),F1(i),1-rate(i)];
            %finalResult(i,:)=[TP(i),FN(i),FP(i),TN(i),Accuracy(i),Precision(i),Recall(i),F1(i),1-rate(i)];
            %resultLR((query_index-1)*21+i+1,:)=finalResult(i,:);%[TP(i),FN(i),FP(i),TN(i),Accuracy(i),Precision(i),Recall(i),F1(i),1-rate(i)];
        end
        
        
        %保存切分好的数据到文件中:
        
        if (query_index==1) %baseline 只用locate
            columns={'SPEED','TURN_SPEED','ACC_SPEED','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),'VariableNames',columns2);
            
        elseif query_index==2 % %baseline +急加速
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==3 % %baseline +急转弯
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_TRUN','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_TRUN'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==4 % baseline+怠速不稳报警
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_IDLE_SPEED','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_IDLE_SPEED'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==5  %baseline +急轰油
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_OIL','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_OIL'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==6   % COUNT_LANE_CHANGE    % baseline+变道次数
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_LANE_CHANGE','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_LANE_CHANGE'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==7     % baseline +超速次数
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_OVER_SPEED','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_OVER_SPEED'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==8    % % %baseline +急减速
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_SUB','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_SUB'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==9    % % baseline +发动机运行时间  ENGINE_RUNTIME
            columns={'SPEED','TURN_SPEED','ACC_SPEED','ENGINE_RUNTIME','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','ENGINE_RUNTIME'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==10  % % baseline+震动报警
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_TREMOR','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_TREMOR'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==11
            % %baseline +热车提醒
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_WARM_REMIND','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_WARM_REMIND'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==12
            % baseline +冷却液温度过低
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_LIQUID_TOOLOW','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_LIQUID_TOOLOW'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==13
            % % baseline +正时皮带
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_TIMING_BELT','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_TIMING_BELT'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==14
            % %baseline+进气温度 AIR_INTAKE_TEMP1~5
            columns={'SPEED','TURN_SPEED','ACC_SPEED','AIR_INTAKE_TEMP','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','AIR_INTAKE_TEMP'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==15
            % baseline +蓄电池电压
            columns={'SPEED','TURN_SPEED','ACC_SPEED','BATTERY_VOL','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','BATTERY_VOL'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==16
            % %baseline+行驶里程 MILEAGE
            columns={'SPEED','TURN_SPEED','ACC_SPEED','MILEAGE','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','MILEAGE'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==17
            % %baseline+空气流量 AIR_RATE_OF_FLOW1~5
            columns={'SPEED','TURN_SPEED','ACC_SPEED','AIR_RATE_OF_FLOW','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','AIR_RATE_OF_FLOW'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==18
            % %baseline+冷却液温度 COOL_LIQUID_TEMP1~5
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COOL_LIQUID_TEMP','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COOL_LIQUID_TEMP'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==19
            % %baseline+大气压力 ATMOSPHERE_PRESSURE1~5
            columns={'SPEED','TURN_SPEED','ACC_SPEED','ATMOSPHERE_PRESSURE','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','ATMOSPHERE_PRESSURE'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==20
            % %baseline+发动机转速 ENGINE_SPEED1~5
            columns={'SPEED','TURN_SPEED','ACC_SPEED','ENGINE_SPEED','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','ENGINE_SPEED'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==21
            % baseline+电瓶故障报警 COUNT_JAR_FAULT
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_JAR_FAULT','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_JAR_FAULT'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==22
            % %baseline+计算负荷 CALCULATE_COST1~5
            columns={'SPEED','TURN_SPEED','ACC_SPEED','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),'VariableNames',columns2);
            
        elseif query_index==23
            % % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数
            %15+5=20 COUNT_SUDDEN_ADD,COUNT_SUDDEN_TRUN,COUNT_IDLE_SPEED,COUNT_SUDDEN_OIL,COUNT_LANE_CHANGE
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),'VariableNames',columns2);
            
        elseif query_index==24
            % % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒
            %15+5+5=25 COUNT_OVER_SPEED,COUNT_SUDDEN_SUB,ENGINE_RUNTIME,COUNT_TREMOR,COUNT_WARM_REMIND
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),'VariableNames',columns2);
        elseif query_index==25
            % % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、行驶里程
            %15+5+5+13=38 COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,MILEAGE
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','MILEAGE','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','MILEAGE'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),'VariableNames',columns2);
        elseif query_index==26
            % % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、行驶里程、空气流量、冷却液温度值、大气压力、发动机转速、电瓶故障报警、计算负荷
            %15+5+5+13+26=64
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','MILEAGE','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_xSet(:,21),a_xSet(:,22),a_xSet(:,23),a_xSet(:,24),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','MILEAGE','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),a_test_x(:,21),a_test_x(:,22),a_test_x(:,23),a_test_x(:,24),'VariableNames',columns2);
        elseif query_index==27
            columns={'COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','ACC_SPEED','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','SPEED','TURN_SPEED','MILEAGE','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_xSet(:,21),a_xSet(:,22),a_xSet(:,23),a_xSet(:,24),a_ySet(:,1),'VariableNames',columns);
            columns2={'COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','ACC_SPEED','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','SPEED','TURN_SPEED','MILEAGE','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),a_test_x(:,21),a_test_x(:,22),a_test_x(:,23),a_test_x(:,24),'VariableNames',columns2);
        elseif query_index==28 %去除里程 没有再用5个sample值 而是将他们取一个平均
            columns={'COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','ACC_SPEED','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','SPEED','TURN_SPEED','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_xSet(:,21),a_xSet(:,22),a_xSet(:,23),a_ySet(:,1),'VariableNames',columns);
            columns2={'COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','ACC_SPEED','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','SPEED','TURN_SPEED','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),a_test_x(:,21),a_test_x(:,22),a_test_x(:,23),'VariableNames',columns2);
        elseif query_index==29
            % % baseline
            % +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、(去掉行驶里程）、空气流量
            %15+5+5+13=38 COUNT_LIQUID_TOOLOW,COUNT_TIMING_BELT,(AIR_INTAKE_TEMP1+AIR_INTAKE_TEMP2+AIR_INTAKE_TEMP3+AIR_INTAKE_TEMP4+AIR_INTAKE_TEMP5)/5 AS AIR_INTAKE_TEMP,(BATTERY_VOL1+BATTERY_VOL2+BATTERY_VOL3+BATTERY_VOL4+BATTERY_VOL5)/5 AS BATTERY_VOL,MILEAGE
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','AIR_RATE_OF_FLOW','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','AIR_RATE_OF_FLOW'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),'VariableNames',columns2);
        elseif query_index==30
            % % baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、（去除行驶里程）、空气流量、冷却液温度值、大气压力、发动机转速、电瓶故障报警、计算负荷
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_xSet(:,21),a_xSet(:,22),a_xSet(:,23),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),a_test_x(:,21),a_test_x(:,22),a_test_x(:,23),'VariableNames',columns2);
            
            
        elseif query_index==31
            % % (去除发动机运行时间\里程)baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、(去除发动机运行时间)、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、（将行驶里程去除）、空气流量、冷却液温度值、大气压力、发动机转速、电瓶故障报警、计算负荷
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_xSet(:,21),a_xSet(:,22),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),a_test_x(:,21),a_test_x(:,22),'VariableNames',columns2);
        elseif query_index==32
            % %(去除冷却液温度\里程) baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、电池电压、（将行驶里程去除）、空气流量、(去除冷却液温度)、大气压力、发动机转速、电瓶故障报警、计算负荷
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','AIR_RATE_OF_FLOW','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_xSet(:,21),a_xSet(:,22),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','BATTERY_VOL','AIR_RATE_OF_FLOW','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),a_test_x(:,21),a_test_x(:,22),'VariableNames',columns2);
            
        elseif query_index==33
            %(去除蓄电池电压\里程)baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、发动机运行时间、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、(去除电池电压)、（将行驶里程去除）、空气流量、冷却液温度值、大气压力、发动机转速、电瓶故障报警、计算负荷
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_xSet(:,21),a_xSet(:,22),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','ENGINE_RUNTIME','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','AIR_RATE_OF_FLOW','COOL_LIQUID_TEMP','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),a_test_x(:,21),a_test_x(:,22),'VariableNames',columns2);
            
        elseif query_index==34
            % %(去除发动机运行时间\冷却液温度\蓄电池电压\里程) baseline +急加速、急转弯、怠速不稳、急轰油次数、变道次数、超速次数、急减速次数、(去除发动机运行时间)、震动报警、热车提醒、冷却液温度过低、正时皮带、进气温度、(去除电池电压)、（将行驶里程去除）、空气流量、(去除冷却液温度)、大气压力、发动机转速、电瓶故障报警、计算负荷
            columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','AIR_RATE_OF_FLOW','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST','IF_ALARM'};
            train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_ySet(:,1),'VariableNames',columns);
            columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_ADD','COUNT_SUDDEN_TRUN','COUNT_IDLE_SPEED','COUNT_SUDDEN_OIL','COUNT_LANE_CHANGE','COUNT_OVER_SPEED','COUNT_SUDDEN_SUB','COUNT_TREMOR','COUNT_WARM_REMIND','COUNT_LIQUID_TOOLOW','COUNT_TIMING_BELT','AIR_INTAKE_TEMP','AIR_RATE_OF_FLOW','ATMOSPHERE_PRESSURE','ENGINE_SPEED','COUNT_JAR_FAULT','CALCULATE_COST'};
            test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),'VariableNames',columns2);
            
        end
        
        columns3={'IF_ALARM','VEHID'};
        test_y_csv=table(a_test_y(:,1),DRIVERS,'VariableNames',columns3);
        
        writetable(train_csv,strcat('D:\Workspaces\python\ten_cross\DATA\expandDriverAlarm\train',num2str(query_index),'_',num2str(tcross),'.csv'));
        writetable(test_csv,strcat('D:\Workspaces\python\ten_cross\DATA\expandDriverAlarm\test',num2str(query_index),'_',num2str(tcross),'.csv'));
        writetable(test_y_csv,strcat( 'D:\Workspaces\python\ten_cross\DATA\expandDriverAlarm\xgb_real',num2str(query_index),'_',num2str(tcross),'.csv'));
        
        
    end
    %这个时候temp_tcross_result存放了10次交叉的结果
    %需要对这十次结果进行求均值。
    tcross_result=meanOfTenCross(temp_tcross_result,19,9);
    resultLR((query_index-1)*21+2:query_index*21-1,:)=tcross_result;
    resultLRmax(query_index,:)=[query_index,tcross_result(find(tcross_result(:,8)==max(tcross_result(:,8))),:)];
    %unique(result(find(result(:,2)==1),3));%所有出事故的车辆编号
    %total_risk_driver=length(unique(result(find(result(:,2)==1),3)));%出事故的车辆数目
    
    %     testRow=length(result(:,1));
    %     result=sortrows(result,1);%按第一列对result进行排序
    %     resultEnd=result(:,2);
    %     resultDriver=result(:,2:3);%车辆
    %
    %     rateCount=19;
    %     rate=linspace(0.5,0.95,rateCount);
    %     setSafe=zeros(1,rateCount);
    %     setRisk=zeros(1,rateCount);
    %
    %     TP=zeros(1,rateCount);%true positive 真实为1且预测为1
    %     FN=zeros(1,rateCount);%false negative 真实为1而预测为0
    %     FP=zeros(1,rateCount);%false positive 真实为0而预测为1
    %     TN=zeros(1,rateCount);%true negative 真实为0且预测为0
    %
    %     Accuracy=zeros(1,rateCount);
    %     Precision=zeros(1,rateCount);
    %     Recall=zeros(1,rateCount);
    %     F1=zeros(1,rateCount);
    %     TrueNegativeRate=zeros(1,rateCount);
    %     PF=zeros(1,rateCount);
    %     NF=zeros(1,rateCount);
    %
    %     finalResult=zeros(rateCount,9);
    %     for i=1:1:length(rate)
    %         setSafe(i)=round(testRow*rate(i));%安全的轨迹
    %         setRisk(i)=testRow-setSafe(i);%危险的轨迹数据
    %
    %         [TP(i),FN(i),FP(i),TN(i),Accuracy(i),Precision(i),Recall(i),F1(i)]=getPro(resultEnd,resultDriver,testRow,rate(i),setSafe(i),setRisk(i));
    %         %finalResult(i,:)=[correct,errorRate,leavingOutRate,driverRate,chushiRate,1-rate(i)];
    %         %ZZ=[TP,FN,FP,TN,Accuracy,Precision,Recall,F1,TrueNegativeRate,PF,NF,1-rate(i)];
    %
    %         finalResult(i,:)=[TP(i),FN(i),FP(i),TN(i),Accuracy(i),Precision(i),Recall(i),F1(i),1-rate(i)];
    %         resultLR((query_index-1)*21+i+1,:)=finalResult(i,:);%[TP(i),FN(i),FP(i),TN(i),Accuracy(i),Precision(i),Recall(i),F1(i),1-rate(i)];
    %     end
    %{'TP','FN','FP','TN','Accuracy','Precision','Recall','TrueNegativeRate','PF','NF'};
    %resultLRmax(query_index,:)=[query_index,finalResult(find(finalResult(:,8)==max(finalResult(:,8))),:)];
    
    
    
    
    %保存文件
    
    %     a_xSet=[beforeNormal(train1_1:train1_2,1:list-2);beforeNormal(train2_1:train2_2,1:list-2)];%最后一列是车辆ID，所以减2
    %     a_ySet=[beforeNormal(train1_1:train1_2,list-1);beforeNormal(train2_1:train2_2,list-1)];
    %
    %     a_test_x=[beforeNormal(test1_1:test1_2,1:list-2);beforeNormal(test2_1:test2_2,1:list-2)];
    %     a_test_y=[beforeNormal(test1_1:test1_2,list-1);beforeNormal(test2_1:test2_2,list-1)];
    %     DRIVERS=[beforeNormal(test1_1:test1_2,list);beforeNormal(test2_1:test2_2,list)];
    
    
    %保存文件
    
    % % % 15+7+5+2+7*5+1 增加正时皮带等报警项 算上FLOW数据7*5
    % columns={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_TRUN','COUNT_SUDDEN_ADD','COUNT_SUDDEN_SUB','COUNT_SUDDEN_OIL','COUNT_OVER_SPEED','COUNT_LANE_CHANGE','COUNT_WARM_REMIND','COUNT_TIMING_BELT','COUNT_TREMOR','COUNT_IDLE_SPEED','COUNT_JAR_FAULT','COUNT_LIQUID_TOOLOW','MILEAGE','ENGINE_RUNTIME','ENGINE_SPEED','COOL_LIQUID_TEMP','BATTERY_VOL','CALCULATE_COST','AIR_INTAKE_TEMP','AIR_RATE_OF_FLOW','ATMOSPHERE_PRESSURE','IF_ALARM'};
    % train_csv=table(a_xSet(:,1),a_xSet(:,2),a_xSet(:,3),a_xSet(:,4),a_xSet(:,5),a_xSet(:,6),a_xSet(:,7),a_xSet(:,8),a_xSet(:,9),a_xSet(:,10),a_xSet(:,11),a_xSet(:,12),a_xSet(:,13),a_xSet(:,14),a_xSet(:,15),a_xSet(:,16),a_xSet(:,17),a_xSet(:,18),a_xSet(:,19),a_xSet(:,20),a_xSet(:,21),a_xSet(:,22),a_xSet(:,23),a_xSet(:,24),a_xSet(:,25),a_xSet(:,26),a_xSet(:,27),a_xSet(:,28),a_xSet(:,29),a_xSet(:,30),a_xSet(:,31),a_xSet(:,32),a_xSet(:,33),a_xSet(:,34),a_xSet(:,35),a_xSet(:,36),a_xSet(:,37),a_xSet(:,38),a_xSet(:,39),a_xSet(:,40),a_xSet(:,41),a_xSet(:,42),a_xSet(:,43),a_xSet(:,44),a_xSet(:,45),a_xSet(:,46),a_xSet(:,47),a_xSet(:,48),a_xSet(:,49),a_xSet(:,50),a_xSet(:,51),a_xSet(:,52),a_xSet(:,53),a_xSet(:,54),a_xSet(:,55),a_xSet(:,56),a_xSet(:,57),a_xSet(:,58),a_xSet(:,59),a_xSet(:,60),a_xSet(:,61),a_xSet(:,62),a_xSet(:,63),a_xSet(:,64),a_ySet(:,1),'VariableNames',columns);
    %
    % columns2={'SPEED','TURN_SPEED','ACC_SPEED','COUNT_SUDDEN_TRUN','COUNT_SUDDEN_ADD','COUNT_SUDDEN_SUB','COUNT_SUDDEN_OIL','COUNT_OVER_SPEED','COUNT_LANE_CHANGE','COUNT_WARM_REMIND','COUNT_TIMING_BELT','COUNT_TREMOR','COUNT_IDLE_SPEED','COUNT_JAR_FAULT','COUNT_LIQUID_TOOLOW','MILEAGE','ENGINE_RUNTIME','ENGINE_SPEED','COOL_LIQUID_TEMP','BATTERY_VOL','CALCULATE_COST','AIR_INTAKE_TEMP','AIR_RATE_OF_FLOW','ATMOSPHERE_PRESSURE'};
    % test_csv=table(a_test_x(:,1),a_test_x(:,2),a_test_x(:,3),a_test_x(:,4),a_test_x(:,5),a_test_x(:,6),a_test_x(:,7),a_test_x(:,8),a_test_x(:,9),a_test_x(:,10),a_test_x(:,11),a_test_x(:,12),a_test_x(:,13),a_test_x(:,14),a_test_x(:,15),a_test_x(:,16),a_test_x(:,17),a_test_x(:,18),a_test_x(:,19),a_test_x(:,20),a_test_x(:,21),a_test_x(:,22),a_test_x(:,23),a_test_x(:,24),a_test_x(:,25),a_test_x(:,26),a_test_x(:,27),a_test_x(:,28),a_test_x(:,29),a_test_x(:,30),a_test_x(:,31),a_test_x(:,32),a_test_x(:,33),a_test_x(:,34),a_test_x(:,35),a_test_x(:,36),a_test_x(:,37),a_test_x(:,38),a_test_x(:,39),a_test_x(:,40),a_test_x(:,41),a_test_x(:,42),a_test_x(:,43),a_test_x(:,44),a_test_x(:,45),a_test_x(:,46),a_test_x(:,47),a_test_x(:,48),a_test_x(:,49),a_test_x(:,50),a_test_x(:,51),a_test_x(:,52),a_test_x(:,53),a_test_x(:,54),a_test_x(:,55),a_test_x(:,56),a_test_x(:,57),a_test_x(:,58),a_test_x(:,59),a_test_x(:,60),a_test_x(:,61),a_test_x(:,62),a_test_x(:,63),a_test_x(:,64),'VariableNames',columns2);
    
    
    
    
end
close(conn);
col={'TP','FN','FP','TN','Accuracy','Precision','Recall','F1','rate'};
LR_csv=table(resultLR(:,1),resultLR(:,2),resultLR(:,3),resultLR(:,4),resultLR(:,5),resultLR(:,6),resultLR(:,7),resultLR(:,8),resultLR(:,9),'VariableNames',col);
writetable(LR_csv, 'D:\Workspaces\MATLAB\ten_cross\resultOfLR.csv');

%保存每一个属性集合得到的最佳结果
col2={'index','TP','FN','FP','TN','Accuracy','Precision','Recall','F1','rate'};
LRmax_csv=table(resultLRmax(:,1),resultLRmax(:,2),resultLRmax(:,3),resultLRmax(:,4),resultLRmax(:,5),resultLRmax(:,6),resultLRmax(:,7),resultLRmax(:,8),resultLRmax(:,9),resultLRmax(:,10),'VariableNames',col2);
writetable(LRmax_csv, 'D:\Workspaces\MATLAB\ten_cross\resultOfLRmax.csv');