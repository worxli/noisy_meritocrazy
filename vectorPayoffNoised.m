function [ payoff ] = vectorPayoffNoised( arg )

    vector = arg.vectornoise;
    noisedvec = vector+arg.noisevec;
    
    mat = [noisedvec,vector];
    
    mat = sortrows(mat,1);
    
    arg.vec = mat(:,2);
    
    arg.payoff = order_payoff(arg);

    %disp('noised payoff');
    payoff = arg.payoff;

end

