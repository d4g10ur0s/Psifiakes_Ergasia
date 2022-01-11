function [xq, D] = kmeans_quant(x, N)
    x = randn(4000,50) * 100;
    xq = zeros(size(x));
    [idx , centers] = kmeans(x,2^N);%exw parei ta kentroeidh
    for i = 1:length(x(:,1))%antikatastash me kentroeidh
        xq(i,:) = centers(idx(i),:);
    end
    k = 1;
    maxIterations = 20;%to polu 20 iterations
    D = zeros(maxIterations);
    disp(D(k));
    D(k) = sum((x-xq).^2,'all');%ypologismos paramorfwshs
     while k < maxIterations
        %arxika ypologizw nea kentroeidh
        k = k + 1;
        [idx , centers] = kmeans(xq,2^N);
        for i = 1:length(x(:,1))
            xq(i,:) = centers(idx(i),:);
        end
        D(k) = sum((x-xq).^2,'all');%ypologismos paramorfwshs
        if (abs(D(k-1)-D(k))<10^(-6)) 
            disp("egine");
            break;
        end
     end
end