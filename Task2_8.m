clear; close all;

% clean function
n = 10;
N=2^n;
x = linspace(-2,2,N);
fx = piecSmothFunc(x);
foriginal = fx;

figure()
plot(x,fx)
title('Original function')

%% Task 2.8

% contaminate function with noise
epsilon = 0.1;
for i=1:size(fx,2)
    fx(i)=fx(i)+epsilon*(-0.5+rand());
end
foriginalNoise = fx;
figure()
plot(fx)
title('Original function with noise')

% take wavelet transform of noisy function
swc = swt(fx,4,'db4');

threshHold = 1e-2*max(max(swc));


swc_soft = softThresholding(swc,threshHold);

swc_hard = hardThresholding(swc,threshHold);

f_swc_soft = iswt(swc_soft, 'db4');
f_swc_hard = iswt(swc_hard, 'db4');

figure()
plot(x,f_swc_soft)
hold on
plot(x,f_swc_hard)
plot(x,foriginal)
legend('Soft thresholding','Hard thresholding','original')
title("Denoised signal with threshold 1e-2*max(c)")


figure()
x = linspace(-2,2,size(swc,2));
plot(x,swc_soft(3,:))
xlabel('x')
ylabel('coefficients')
title("Coefficient redundant wavelet transform")


%% Functions

function y = piecSmothFunc(x)
    y=(2+cos(x)).*abs(x).*sig(x-1);
end

%sign function 1 x>=0 0 x<0
function y = sig(x)
    for i = 1:numel(x)
    if x(i)>=0
        y(i)=1;
    else
        y(i)=-1;
    end
    end
end

function y = softThresholding(x,delta)
    y = size(x);
    for i = 1:size(x,1)
        for j = 1:size(x,2)
            if abs(x(i,j))>=delta
                y(i,j)=sig(x(i,j)).*(abs(x(i,j))-delta);
            else
                y(i,j)=0;
            end
        end
    end
end

function y = hardThresholding(x,delta)
    y = (x);
    for i = 1:size(x,1)
        for j = 1:size(x,2)
            if abs(x(i,j))<delta
                y(i,j)=0;
            end
        end
    end
end