clear;
close all

[A,cmap] = imread('cameraman.png');

A = convertAtoActualColors(A, cmap);
A_original = A;

figure
imshow(A)
title('original figure')

% masks maken -> kies lege plekken
mask = zeros(size(A));
mask(200:240, 200:240) = 1;
mask(100:120,100:120) = 1;
mask = mask > 0;
A(mask) = 0;

figure
imshow(A)
title('original figure')

% mask complementMask
complementMask = mask == 0;

B = A;
B_pre=A;
i=1;
% while (SNRold-SNRnew) > 0.1 && i<1000
while (max(max(abs(B-B_pre))) > 1e-2 || i==1) && i<100
    K = redudantDenoising(B, true, 4, 'db4');
    K(complementMask) = 0;
    B_pre = B;
    B = A + K;
    i = i + 1;
end

 SNR = signalToNoiseRatio(A_original,B)

figure
imshow(B)