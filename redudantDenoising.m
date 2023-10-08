function [A] = redudantDenoising(A, soft, level, wavelet)
    [C,H,V,D] = swt2(A,level,wavelet);
    
    if soft 
        [threshold, Cnew, Hnew, Vnew, Dnew] = softThresholding(C,H,V,D);
    else
        [threshold, Cnew, Hnew, Vnew, Dnew] = hardThreshold(C,H,V,D);
    end
    A = iswt2(Cnew,Hnew,Vnew,Dnew,wavelet);

    end

    %% functions

function [threshold, Cnew, Hnew, Vnew, Dnew] = softThresholding(C,H,V,D)
    bigTensor = cat(3,C,H,V,D);
    threshold = 0.02* max(max(max(abs(bigTensor))));
    Cnew = C;
    Hnew = H;
    Vnew = V;
    Dnew = D;
    for i=1:size(C,1)
        for j=1:size(C,2)
            for k=1:size(C,3)
                if abs(C(i,j,k)) < threshold
                    Cnew(i,j,k) = 0;
                else
                    Cnew(i,j,k) = sign2(C(i,j,k))*(abs(C(i,j,k)) - threshold);
                end
                if abs(H(i,j,k)) < threshold
                    Hnew(i,j,k) = 0;
                else
                    Hnew(i,j,k) = sign2(H(i,j,k))*(abs(H(i,j,k)) - threshold);
                end
                if abs(V(i,j,k)) < threshold
                    Vnew(i,j,k) = 0;
                else
                    Vnew(i,j,k) = sign2(V(i,j,k))*(abs(V(i,j,k)) - threshold);
                end
                if abs(D(i,j,k)) < threshold
                    Dnew(i,j,k) = 0;
                else
                    Dnew(i,j,k) = sign2(D(i,j,k))*(abs(D(i,j,k)) - threshold);
                end   
            end
        end
    end
end

function [threshold, Cnew, Hnew, Vnew, Dnew] = hardThreshold(C,H,V,D)
    bigTensor = cat(3,C,H,V,D);
    threshold = 0.02* max(max(max(abs(bigTensor))));
    Cnew = C;
    Hnew = H;
    Vnew = V;
    Dnew = D;
    for i=1:size(C,1)
        for j=1:size(C,2)
            for k=1:size(C,3)
                if abs(C(i,j,k)) < threshold
                    Cnew(i,j,k) = 0;
                end
                if abs(H(i,j,k)) < threshold
                    Hnew(i,j,k) = 0;
                end
                if abs(V(i,j,k)) < threshold
                    Vnew(i,j,k) = 0;
                end
                if abs(D(i,j,k)) < threshold
                    Dnew(i,j,k) = 0;
                end   
            end
        end
    end
end