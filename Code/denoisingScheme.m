function [A] = denoisingScheme(A, soft, level, wavelet, thresholdFactor)
    [C,S] = wavedec2(A,level,wavelet);

    if soft == true
        [threshold,Cnew] = softThreshold(C, thresholdFactor);
    else 
        [threshold,Cnew] = hardThreshold(C, thresholdFactor);
    end

    A = waverec2(Cnew,S,wavelet);
    end

    %% functions 

function [threshold,Cnew] = softThreshold(C, thresholdFactor)
    T = max(abs(C));
    threshold = thresholdFactor*T;
    Cnew = C;
    for i=1:numel(C)
        if abs(C(i)) < threshold
            Cnew(i) = 0;
        else
            Cnew(i) = sign2(C(i))*(abs(C(i)) - threshold);
        end
    end
end

function [threshold,Cnew] = hardThreshold(C, thresholdFactor)
    T = max(abs(C));
    threshold = thresholdFactor*T;
    Cnew = C;
    for i=1:numel(C)
        if abs(C(i)) < threshold
            Cnew(i) = 0;
        end
    end
end