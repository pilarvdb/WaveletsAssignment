clear; close all

[A,cmap] = imread('cameraman.png');

A = convertAtoActualColors(A, cmap);

figure
imshow(A)
title('Original figure')

% toevoegen noise
epsilon = 0.3;
for i=1:size(A,1)
    for j=1:size(A,2)
        A(i,j)=A(i,j)+epsilon*(-0.5+rand());
    end
end
figure
imshow(A)
title('Original figure with noise')

B = redudantDenoisingScheme(A, false, 4, 'bior4.4', 0.02);
SNR = signalToNoiseRatio(A, B);

figure
imshow(B)
title('Denoised image with redundant wavelet transform (hard, bior4.4)')