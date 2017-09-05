function [ tenCross ] = meanOfTenCross( full_result,line,cols )
%用于把十次交叉验证的结果取平均，得到最终的一个数组
%   full_result为初始结果，包含10*每一次交叉验证得到的结果
%line为初始结果的行数(单个结果的行数)
%cols为列数
tenCross=zeros(line,cols);
for i=1:line
    tenCross(i,:)=mean(full_result(i:line:line*10,:));
end

end

