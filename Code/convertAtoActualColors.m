function B = convertAtoActualColors(A, cmap)
    B = zeros(size(A));
    for i=1:size(A,1)
        for j=1:size(A,2)
            if A(i,j) == 0
                B(i,j) = 0;
            else
                B(i,j) = cmap(A(i,j)+1,1);
            end
        end
    end
end