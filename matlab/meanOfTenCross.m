function [ tenCross ] = meanOfTenCross( full_result,line,cols )
%���ڰ�ʮ�ν�����֤�Ľ��ȡƽ�����õ����յ�һ������
%   full_resultΪ��ʼ���������10*ÿһ�ν�����֤�õ��Ľ��
%lineΪ��ʼ���������(�������������)
%colsΪ����
tenCross=zeros(line,cols);
for i=1:line
    tenCross(i,:)=mean(full_result(i:line:line*10,:));
end

end

