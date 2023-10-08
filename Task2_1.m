clear; close all;

%% Q2.1

% clean function
n = 10;
N=2^n;
x = linspace(-2,2,N);
fx = piecSmothFunc(x);
foriginal = fx;

figure()
plot(x,fx)
title('Original function')

% DWT mode aanpassen
%dwtmode('per') %default mode 'symh'

%wavelet and scaling coefficients
[c2,l2] = wavedec(fx,n,'db2');
s2 = appcoef(c2,l2,'db2');
w2 = c2(numel(s2)+1:end);
 
[c4,l4] = wavedec(fx,n,'db4');
s4 = appcoef(c4,l2,'db4');
w4 = c4(numel(s4)+1:end);
 
[c6,l6] = wavedec(fx,n,'db6');
s6 = appcoef(c6,l2,'db6');
w6 = c6(numel(s6)+1:end);
 

figure()
semilogy(abs(w2))
hold on
semilogy(abs(w4))
semilogy(abs(w6))
xlabel('coefficient index')
ylabel('wavelet coefficient value')
title('Coefficients per level')
legend('db2','db4','db6')

figure()
semilogy(abs(s2))
hold on
semilogy(abs(s4))
semilogy(abs(s6))
xlabel('coefficient index')
ylabel('scaling coefficient value')
title('Coefficients per level')
legend('db2','db4','db6')


%% Task 2.2

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
[c,l] = wavedec(fx,4,'db4');
s = appcoef(c,l,'db4');
w = c(numel(s)+1:end);


threshHold = 1e-2*max(c);


wd_Soft = softThresholding(w,threshHold);
sd_Soft = softThresholding(s,threshHold);

wd_Hard = hardThresholding(w,threshHold);
sd_Hard = hardThresholding(s,threshHold);


c_rec_SS = [sd_Soft,wd_Soft];
c_rec_SH = [sd_Soft,wd_Hard];
c_rec_HS = [sd_Hard,wd_Soft];
c_rec_HH = [sd_Hard,wd_Hard];

fdenoised_SS = waverec(c_rec_SS,l,'db4');
fdenoised_HH = waverec(c_rec_HH,l,'db4');
fdenoised_SH = waverec(c_rec_SH,l,'db4');
fdenoised_HS = waverec(c_rec_HS,l,'db4');


figure()
plot(x,fdenoised_SS)
hold on
plot(x,fdenoised_HH, '--')
plot(x,fdenoised_SH,'-.')
plot(x,fdenoised_HS,'--')
plot(x,foriginal)
legend('Soft-Soft thresholding','Hard-Hard thresholding','Soft-Hard thresholding','Hard-Soft thresholding','original')
title("Denoised signal with threshold 1e-2*max(c)")


sum(abs(foriginal-fdenoised_SS))/numel(foriginal)
sum(abs(foriginal-fdenoised_HH))/numel(foriginal)
sum(abs(foriginal-fdenoised_SH))/numel(foriginal)
sum(abs(foriginal-fdenoised_HS))/numel(foriginal)

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
y = zeros(size(x));
    for i = 1:numel(x)
    if abs(x(i))>=delta
        y(i)=sig(x(i)).*(abs(x(i))-delta);
    else
        y(i)=0;
    end
    end
end

function y = hardThresholding(x,delta)
y = zeros(size(x));
for i = 1:numel(x)
    if abs(x(i))>=delta
        y(i)=x(i);
    else
        y(i)=0;
    end
end
end