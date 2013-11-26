%NEPNE
for a = arg.n-1:-1:2
   k=-1;
   if a==arg.n
       
       %senseless its always better to give nothing if everyone else gives
       %all
       if Eci(a,1)>=Eci(a+1,2)
           k=a;
           break;
       end
       
   elseif a==0
       
       %senseless its always better to keep giving nothing if everyone else
       %gives nothing
       k=-1;
       
   else
       
       if Eci(a,1)>=Eci(a+1,2)&&Eci(a,2)>=Eci(a-1,1)
           k=a;
           break;
       end
       
   end
    
end

K = [K;k];