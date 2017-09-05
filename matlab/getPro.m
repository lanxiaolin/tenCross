function [TP,FN,FP,TN,Accuracy,Precision,Recall,F1] = getPro( resultEnd,resultDriver,total,rate,count1,count2 )
% function [correct,errorRate,leavingOutRate,driverRate,chushiRate] = getPro( resultEnd,resultDriver,total,rate,count1,count2 )
%GETRADIO
%correct(正确率),errorRate(误判率),leavingOutRate(漏判率),driverRate(选中轨迹中驾驶员占总出事驾驶员的百分比),chushiRate出事概率
%resultEnd(预测结果，包括预测值与真实值),resultDriver(包括报警值与车辆ID),total_risk_driver(总的出事的车辆ID数),total(轨迹样本数),count1(分类为安全轨迹的数目),count2(分类为危险轨迹) 
%   此处显示详细说明
    TP=0;%true positive 真实为1且预测为1
    FN=0;%false negative 真实为1而预测为0
    FP=0;%false positive 真实为0而预测为1
    TN=0;%true negative 真实为0且预测为0
    
    FN=sum(resultEnd(1:count1));%真实为1而预测为0
    TN=count1-FN;%真实为0且预测为0
    
    TP=sum(resultEnd(count1+1:total));
    FP=count2-TP;
    
    
    Precision=TP/(TP+FP);
    Recall=TP/(TP+FN);
    
    F1=2*(Precision*Recall)/(Precision+Recall);

    %TrueNegativeRate=TN/(TN+FP);
    Accuracy=(TP+TN)/(TP+TN+FP+FN);

    %NF=FN/(FN+TN);%漏判率
    %PF=FP/(TP+FP);%误判率PF

    
%     leavingOutRate=sum(resultEnd(1:count1))/count1;
% %     errorRate=count1;
% %     leavingOutRate=count2;
%     errorRate=(count2-sum(resultEnd(count1+1:total)))/count2;
%     flag=0;
%     zeros(1,rateCount);
%     for i=1:1:count1
%         if resultEnd(i)==0
%             flag=flag+1;
%         end
%     end
%      for i=count1+1:1:total
%         if resultEnd(i)==1
%             flag=flag+1;
%         end
%      end
%     correct=flag/total;
    %出事车的前五十%的命中率
%     sortrows(resultDriver(find(resultDriver(:,1)==1),:),2)
%     T1=unique(resultDriver(find(resultDriver(:,1)==1),2))%找出出事的所有车ID
%     length(T1)
%     T1(:,2)=zeros(length(T1),1);
%     T1
%     for i=1:1:length(T1)
%         d1=find(resultDriver(:,2)==T1(i,1));%找出所有vehid为当前ID的数据序号
%         for i2=1:1:length(d1)
%             if(resultDriver(d1(i2),1)==1)
%                 T1(i,2)=T1(i,2)+1;%根据序号去相加
%             end
%         end
%     end
%     T1=sortrows(T1,2);
%     rate;%外面的比值
%     driverRate=0;
%     chushiRate=0;
%     T2=unique(resultDriver(count1+1:total,2));
%     T3=T1(round(length(T1)*0.5):length(T1),1);%取前50%
%     T4=intersect(T2,T3);
%     driverRate=length(T4)/length(T3);
    
%     
%     
%     %预测驾驶员在真实驾驶员中的命中率
%     T1=unique(resultDriver(find(resultDriver(:,1)==1),2));%真实驾驶员VEHID
%     resultDriver(1:count1,1)=zeros(count1,1);
%     %首先把X前部分清0
%    % riskDriver=length(unique(resultDriver(find(resultDriver(count1+1:total,1)==1),2)));
%     T2=unique(resultDriver(count1+1:total,2));%预测的出事故驾驶员
%     
% %     length(intersect(T2,T1));
%     driverRate=length(intersect(T2,T1))/length(T1);%交集占真实驾驶员的比例
% %     length(intersect(T2,T1));
%     length(T2);
%     chushiRate=length(intersect(T2,T1))/length(T2);%交集占预测驾驶员的比例；命中率
% %     driverRate=riskDriver/total_risk_driver;

end

