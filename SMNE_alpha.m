%P(k)
f = @(n,k,p) nchoosek(n,k)*p^k*(1-p)^(n-k);

%possibility array
qA = 0:0.01:1;

E = [];
for q = qA
   
    e1=0;
    e2=0;
    for a = 0:arg.n-1
        e1 = e1+f(arg.n-1,a,q).*Eci(a+1,1);
        e2 = e2+f(arg.n-1,a,q).*Eci(a+2,2);
    end
    E = [E;e1,e2];
    
end