clear; close all

% showing original image
[A,cmap] = imread('cameraman.png');

A = convertAtoActualColors(A, cmap);

figure
imshow(A)
title('Original figure')

% adding noise to the image
epsilon = 0.3;
for i=1:size(A,1)
    for j=1:size(A,2)
        A(i,j)=A(i,j)+epsilon*(-0.5+rand());
    end
end
figure
imshow(A)
title('Original image with noise')

B = denoisingScheme(A, false, 4, 'haar', 0.02);
SNR = signalToNoiseRatio(A, B);

figure
imshow(B)
title('Denoised image (hard, haar)')