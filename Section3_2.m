clear;

[A,cmap] = imread('cameraman.png');

figure
imshow(A,cmap)
title('original figure')

A = cast(A,'double');

mask = zeros(size(A));
mask(50:60,70:80) = 1;
mask = mask > 0;
A(mask) = 0;

B = cast(A,'uint8');

figure
imshow(B,cmap)
title('figure met missing inf.')

mask = A == 0;
