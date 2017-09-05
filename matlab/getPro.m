function [TP,FN,FP,TN,Accuracy,Precision,Recall,F1] = getPro( resultEnd,resultDriver,total,rate,count1,count2 )
% function [correct,errorRate,leavingOutRate,driverRate,chushiRate] = getPro( resultEnd,resultDriver,total,rate,count1,count2 )
%GETRADIO
%correct(��ȷ��),errorRate(������),leavingOutRate(©����),driverRate(ѡ�й켣�м�ʻԱռ�ܳ��¼�ʻԱ�İٷֱ�),chushiRate���¸���
%resultEnd(Ԥ����������Ԥ��ֵ����ʵֵ),resultDriver(��������ֵ�복��ID),total_risk_driver(�ܵĳ��µĳ���ID��),total(�켣������),count1(����Ϊ��ȫ�켣����Ŀ),count2(����ΪΣ�չ켣) 
%   �˴���ʾ��ϸ˵��
    TP=0;%true positive ��ʵΪ1��Ԥ��Ϊ1
    FN=0;%false negative ��ʵΪ1��Ԥ��Ϊ0
    FP=0;%false positive ��ʵΪ0��Ԥ��Ϊ1
    TN=0;%true negative ��ʵΪ0��Ԥ��Ϊ0
    
    FN=sum(resultEnd(1:count1));%��ʵΪ1��Ԥ��Ϊ0
    TN=count1-FN;%��ʵΪ0��Ԥ��Ϊ0
    
    TP=sum(resultEnd(count1+1:total));
    FP=count2-TP;
    
    
    Precision=TP/(TP+FP);
    Recall=TP/(TP+FN);
    
    F1=2*(Precision*Recall)/(Precision+Recall);

    %TrueNegativeRate=TN/(TN+FP);
    Accuracy=(TP+TN)/(TP+TN+FP+FN);

    %NF=FN/(FN+TN);%©����
    %PF=FP/(TP+FP);%������PF

    
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
    %���³���ǰ��ʮ%��������
%     sortrows(resultDriver(find(resultDriver(:,1)==1),:),2)
%     T1=unique(resultDriver(find(resultDriver(:,1)==1),2))%�ҳ����µ����г�ID
%     length(T1)
%     T1(:,2)=zeros(length(T1),1);
%     T1
%     for i=1:1:length(T1)
%         d1=find(resultDriver(:,2)==T1(i,1));%�ҳ�����vehidΪ��ǰID���������
%         for i2=1:1:length(d1)
%             if(resultDriver(d1(i2),1)==1)
%                 T1(i,2)=T1(i,2)+1;%�������ȥ���
%             end
%         end
%     end
%     T1=sortrows(T1,2);
%     rate;%����ı�ֵ
%     driverRate=0;
%     chushiRate=0;
%     T2=unique(resultDriver(count1+1:total,2));
%     T3=T1(round(length(T1)*0.5):length(T1),1);%ȡǰ50%
%     T4=intersect(T2,T3);
%     driverRate=length(T4)/length(T3);
    
%     
%     
%     %Ԥ���ʻԱ����ʵ��ʻԱ�е�������
%     T1=unique(resultDriver(find(resultDriver(:,1)==1),2));%��ʵ��ʻԱVEHID
%     resultDriver(1:count1,1)=zeros(count1,1);
%     %���Ȱ�Xǰ������0
%    % riskDriver=length(unique(resultDriver(find(resultDriver(count1+1:total,1)==1),2)));
%     T2=unique(resultDriver(count1+1:total,2));%Ԥ��ĳ��¹ʼ�ʻԱ
%     
% %     length(intersect(T2,T1));
%     driverRate=length(intersect(T2,T1))/length(T1);%����ռ��ʵ��ʻԱ�ı���
% %     length(intersect(T2,T1));
%     length(T2);
%     chushiRate=length(intersect(T2,T1))/length(T2);%����ռԤ���ʻԱ�ı�����������
% %     driverRate=riskDriver/total_risk_driver;

end

