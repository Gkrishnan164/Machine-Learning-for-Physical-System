function [Balancedsleep3ClasstestUSCell, ThreeClasstest] = DataPreprocess(BalancedsleepDataTesting,counttest1,NoofClasses,dataset)

if strcmp('Testing',dataset)
    if NoofClasses == 3
  Balancedsleep3ClasstestUSCell1 = BalancedsleepDataTesting(1:counttest1(1)+counttest1(2)+counttest1(3),:);
    Balancedsleep3ClasstestUSCell2 = BalancedsleepDataTesting(counttest1(1)+counttest1(2)+counttest1(3)+counttest1(4)+1:counttest1(1)+counttest1(2)+counttest1(3)+counttest1(4)+counttest1(5),:);
Balancedsleep3ClasstestUSCell = [Balancedsleep3ClasstestUSCell1;Balancedsleep3ClasstestUSCell2];
    ThreeClasstest(1:counttest1(1)+counttest1(2)+counttest1(3)) = "NREM";
    ThreeClasstest(counttest1(1)+counttest1(2)+counttest1(3)+1:counttest1(1)+counttest1(2)+counttest1(3)+counttest1(5)) = "Wake";
%     ThreeClasstest(counttest1(1)+counttest1(2)+counttest1(3)+counttest1(4)+1:counttest1(1)+counttest1(2)+counttest1(3)+counttest1(4)+counttest1(5)) = "Wake";
elseif NoofClasses == 2
  Balancedsleep3ClasstestUSCell = BalancedsleepDataTesting(counttest1(1)+counttest1(2)+counttest1(3)+1:counttest1(1)+counttest1(2)+counttest1(3)+counttest1(4)+counttest1(5),:);
    ThreeClasstest(1:counttest1(4)) = "REM";
    ThreeClasstest(counttest1(4)+1:counttest1(4)+counttest1(5)) = "Wake";
end





else
if NoofClasses == 3
    X_rand = randi(counttest1,1,ceil(counttest1/3));
    Balancedsleep3ClasstestUSCell1 = BalancedsleepDataTesting(X_rand,:);
    X_rand = randi([counttest1+1,2*counttest1],1,ceil(counttest1/3));
    Balancedsleep3ClasstestUSCell2 = BalancedsleepDataTesting(X_rand,:);
    X_rand = randi([2*counttest1+1,3*counttest1],1,ceil(counttest1/3));
    Balancedsleep3ClasstestUSCell3 = BalancedsleepDataTesting(X_rand,:);
    ThreeClasstest(1:3*ceil(counttest1/3)) = "NREM";
    Balancedsleep3ClasstestUSCell4 = BalancedsleepDataTesting(4*counttest1+1:5*counttest1,:);
    ThreeClasstest(3*ceil(counttest1/3)+1:3*ceil(counttest1/3)+counttest1) = "Wake";
%   Balancedsleep3ClasstestUSCell5 = BalancedsleepDataTesting(4*counttest1+1:5*counttest1,:);
%     ThreeClasstest(3*ceil(counttest1/3)+counttest1+1:3*ceil(counttest1/3)+2*counttest1) = "Wake";
Balancedsleep3ClasstestUSCell = [Balancedsleep3ClasstestUSCell1;Balancedsleep3ClasstestUSCell2;Balancedsleep3ClasstestUSCell3;Balancedsleep3ClasstestUSCell4];
elseif NoofClasses == 2
%     X_rand = randi(counttest1,1,ceil(counttest1/3));
%     Balancedsleep3ClasstestUSCell1 = BalancedsleepDataTesting(X_rand,:);
%     X_rand = randi([counttest1+1,2*counttest1],1,ceil(counttest1/3));
%     Balancedsleep3ClasstestUSCell2 = BalancedsleepDataTesting(X_rand,:);
%     X_rand = randi([2*counttest1+1,3*counttest1],1,ceil(counttest1/3));
%     Balancedsleep3ClasstestUSCell3 = BalancedsleepDataTesting(X_rand,:);
%     ThreeClasstest(1:3*ceil(counttest1/3)) = "NREM";
    Balancedsleep3ClasstestUSCell4 = BalancedsleepDataTesting(3*counttest1+1:4*counttest1,:);
    ThreeClasstest(1:counttest1) = "REM";
      Balancedsleep3ClasstestUSCell5 = BalancedsleepDataTesting(4*counttest1+1:5*counttest1,:);
    ThreeClasstest(counttest1+1:2*counttest1) = "Wake";
 Balancedsleep3ClasstestUSCell = [Balancedsleep3ClasstestUSCell4;Balancedsleep3ClasstestUSCell5];

end
end
end




