clear;

A = imread('cameraman.tif');

figure
imshow(A)
A = cast(A,'double');

% toevoegen noise
epsilon = 50;
for i=1:size(A,1)
    for j=1:size(A,2)
        A(i,j)=A(i,j)+epsilon*(-0.5+rand());
    end
end

A = cast(A,'uint8');
figure
imshow(A)
A = cast(A,'double');

%% db soft

[C,S] = wavedec2(A,4,'db4');

[threshold,Cnew] = softThreshold(C);

A1 = waverec2(Cnew,S,'db4');
B = cast(A1,'uint8');

figure
imshow(B)
title('reconstruction figure with db4 and soft thresholding')

%% db hard

[C,S] = wavedec2(A,4,'db4');

[threshold,Cnew] = hardThreshold(C);

A1 = waverec2(Cnew,S,'db4');
B = cast(A1,'uint8');

figure
imshow(B)
title('reconstruction figure with db4 and hard thresholding')

%% coif soft

[C,S] = wavedec2(A,4,'coif4');

[threshold,Cnew] = softThreshold(C);

A1 = waverec2(Cnew,S,'coif4');
B = cast(A1,'uint8');

figure
imshow(B)
title('reconstruction figure with coif4 and soft thresholding')

%% coif hard

[C,S] = wavedec2(A,4,'coif4');

[threshold,Cnew] = hardThreshold(C);

A1 = waverec2(Cnew,S,'coif4');
B = cast(A1,'uint8');

figure
imshow(B)
title('reconstruction figure with coif4 and hard thresholding')

%% bior soft

[C,S] = wavedec2(A,4,'bior4.4');

[threshold,Cnew] = softThreshold(C);

A1 = waverec2(Cnew,S,'bior4.4');
B = cast(A1,'uint8');

figure
imshow(B)
title('reconstruction figure with bior4.4 and soft thresholding')

%% bior hard

[C,S] = wavedec2(A,4,'bior4.4');

[threshold,Cnew] = hardThreshold(C);

A1 = waverec2(Cnew,S,'bior4.4');
B = cast(A1,'uint8');

figure
imshow(B)
title('reconstruction figure with bior4.4 and hard thresholding')
%% functions 

function [threshold,Cnew] = softThreshold(C)
    T = max(abs(C));
    threshold = 0.01*T;
    Cnew = C;
    for i=1:numel(C)
        if abs(C(i)) < threshold
            Cnew(i) = 0;
        else
            Cnew(i) = C(i) - threshold;
        end
    end
end

function [threshold,Cnew] = hardThreshold(C)
    T = max(abs(C));
    threshold = 0.01*T;
    Cnew = C;
    for i=1:numel(C)
        if abs(C(i)) < threshold
            Cnew(i) = 0;
        end
    end
end