clear; close all;

%% Q2.1

% clean function
n = 10;
N=2^n;
x = linspace(-2,2,N);
fx = piecSmothFunc(x);
foriginal = fx;

% DWT mode aanpassen
dwtmode('symh') %default mode 'symh'

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
semilogy(abs(c2))
hold on
semilogy(abs(c4))
semilogy(abs(c6))
for i = 1:numel(l2)
    hold on
    xline(l2(i),"--");
end
xlabel('coefficient index')
ylabel('wavelet coefficient value')
xlim([0 l2(end)])
title('Coefficients per level')
legend('db2','db4','db6')

%% Support on different order
figure()
[c,l] = wavedec(fx,n,'db2');
w = abs(detcoef(c,l,3));
x = linspace(-2,2,numel(w));
semilogy(x,w)
hold on
[c,l] = wavedec(fx,n,'db4');
w = abs(detcoef(c,l,3));
x = linspace(-2,2,numel(w));
semilogy(x,w)
[c,l] = wavedec(fx,n,'db6');
w = abs(detcoef(c,l,3));
x = linspace(-2,2,numel(w));
semilogy(x,w)
xline(0);
xline(1);
xlabel('x')
ylabel('wavelet coefficient value')
title('Wavelet coefficients level 3: different order')
legend('order 2','order 4','order 6')

%% Different boundary conditions

figure()
dwtmode('per')
[c2,l2] = wavedec(fx,n,'db4');
w = abs(detcoef(c2,l2,3));
x = linspace(-2,2,numel(w));
semilogy(x,w)
hold on
dwtmode('symh')
[c2,l2] = wavedec(fx,n,'db4');
w = abs(detcoef(c2,l2,3));
x = linspace(-2,2,numel(w));
semilogy(x,w)
dwtmode('zpd')
[c2,l2] = wavedec(fx,n,'db4');
w = abs(detcoef(c2,l2,3));
x = linspace(-2,2,numel(w));
semilogy(x,w)
xline(0);
xline(1);
xlabel('x')
ylabel('wavelet coefficient value')
title('Wavelet coefficients level 3: different boundary conditions')
legend('per','symh','zpd')


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
