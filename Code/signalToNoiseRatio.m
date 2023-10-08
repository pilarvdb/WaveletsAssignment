function SNR = signalToNoiseRatio(A, A_)
    Avec = reshape(A, [1,size(A,1)*size(A,2)]);
    A_vec = reshape(A_, [1,size(A_,1)*size(A_,2)]);
    num = sum(power(Avec,2));
    denum = sum(power((Avec-A_vec),2));
    SNR = 10*log10(num/denum);
end