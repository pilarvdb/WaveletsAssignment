clear; close all;

[A,cmap] = imread('cameraman.png');

A = convertAtoActualColors(A, cmap);

figure
imshow(A)
title('original figure')

% toevoegen grid
A(1:10:end,:)=0;
A(:,1:10:end)=0;

B = A;

figure
imshow(B)
title('grid')

A = redudantDenoising(A, false, 4, 'db4');
B = A;

figure
imshow(B)
title('reconstruction figure with db4 and the redudant wavelet transform')
