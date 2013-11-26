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

diff = abs(E(:,1)-E(:,2));
[mindist1,minInd1] = min(diff);
diff(minInd1)=1;
[mindist2,minInd2] = min(diff);

mprob=zeros(1,4);

if minInd2<minInd1
    t = minInd2;
    minInd2 = minInd1;
    minInd1 = t;
    t = mindist2;
    mindist2 = mindist1;
    mindist1 = t;
end

if mindist1 < 0.01
    mprob(1,1:2) = [mindist1, qA(minInd1)];
else
    mprob(1,1) = mindist1;
end

if mindist2 < 0.01
    mprob(1,3:4)=[mindist2, qA(minInd2)];
else
    mprob(1,3) = mindist2;
end

probv = [probv; mprob];


