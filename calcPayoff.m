function [ex_curr_payoff, ex_cha_payoff, best, nbest] = calcPayoff( arg )

  %  arg.agent
  %  arg.vector'
    tvec = arg.vector;

    if arg.vector(arg.agent,1)==0
        payoff = vectorPayoff(arg);
        ex_curr_payoff = 1 + payoff(1,1);
        arg.vector(arg.agent)=1;
        payoff = vectorPayoff(arg);
        ex_cha_payoff = payoff(1,2);
        
        if ex_curr_payoff<ex_cha_payoff
            nbest = tvec;
            tvec(arg.agent,1) = 1;
            best = tvec;
        else
            best = tvec;
            tvec(arg.agent,1) = 1;
            nbest = tvec;
        end
    else
        payoff = vectorPayoff(arg);
        ex_curr_payoff = payoff(1,2);
        arg.vector(arg.agent)=0;
        payoff = vectorPayoff(arg);
        ex_cha_payoff = 1 + payoff(1,1);
        
        if ex_curr_payoff<ex_cha_payoff
            nbest = tvec;
            tvec(arg.agent,1) = 0;
            best = tvec;
        else
            best = tvec;
            tvec(arg.agent,1) = 0;
            nbest = tvec;
        end
    end
    
    %best'
    %nbest'
    
    %ex_curr_payoff
   % ex_cha_payoff
    
end