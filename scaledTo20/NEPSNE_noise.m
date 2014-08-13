%%
%NEPSNE with noise

% # of reps
rep = 1;

%group size
arg.g = 2;

% # of agents
agents = 4;%:arg.g:6;

%group payoff
perspays = 1:0.05:2;

%beta for normal NEPSNE
arg.b = 30;

for a = agents
    
    datamat = [];
    
    for re=1:rep

        arg.n = a;
        data = [];

        for p = perspays

            %half of group payoff
            arg.rs = p/arg.g;

            %variance
            variance = 0;

            dest=arg.n;
            destnoise=arg.n;

            while dest==destnoise&&(dest~=1&&destnoise~=1)

                %initial vector
                arg.vector = 20*ones(arg.n,1);
                arg.vectornoise = 20*ones(arg.n,1);
                arg.noisevec = normrnd(zeros(arg.n,1),variance);

                %prepare phase
                prephase = true;
                prephasenoise = true;

                paygiving = 0;
                paynotgiving = 20;
                paygivingnoised = 0;
                paynotgivingnoised = 20;

                while(paygiving>paynotgiving)||prephase

                    %normal NEPSNE
                    payoff = vectorPayoff(arg);
                    paygiving = payoff(1,2);

                    ind = find(arg.vector==20);
                    if length(ind)~=0
                        arg.vector(ind(1,1))=0;
                    else
                        disp('no one is contributing to NEPSNE');
                        if prephase == true
                            arg.vector = arg.n-1;
                        end
                        break;
                    end

                    payoff = vectorPayoff(arg);
                    paynotgiving = 20 + payoff(1,1);

                    if paygiving>paynotgiving
                        prephase = false;
                    end 

                end

                while(paygivingnoised>paynotgivingnoised)||prephasenoise

                    %noised NEPSNE
                    payoffnoised = vectorPayoffNoised(arg);
                    paygivingnoised = payoffnoised(1,2);

                    ind = find(arg.vectornoise==20);
                    if length(ind)~=0
                        arg.vectornoise(ind(1,1))=0;
                    else
                        disp('no one is contributing to noised NEPSNE');
                        if prephase == true
                            arg.vectornoise = arg.n-1;
                        end
                        break;
                    end

                    payoffnoise = vectorPayoffNoised(arg);
                    paynotgivingnoise = 20 + payoffnoise(1,1);

                    if paygivingnoised>paynotgivingnoised
                        prephasenoise = false;
                    end 
                end

                dest = arg.n-sum(arg.vector);
                destnoise = arg.n-sum(arg.vectornoise);

                variance = variance + 0.05;

            end

            data = [data,variance]; 

        end
        
        datamat = [datamat; data];
        
    end

    datamat %save(['task2/task2-a-' num2str(arg.n) '.mat'], 'datamat');

end
