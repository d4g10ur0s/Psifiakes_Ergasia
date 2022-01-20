function [xq, D] = kmeans_quant(x, N)
    x = randn(10000,10000);
    %x = randn(10000,1);
    mb = 1;
    ma = ones(10000,1);
    for i=1:10000
        ma(i,1) = ma(i,1)/i;
    end
    x = filter(mb,ma,x);

    xq = zeros(size(x));
    [idx , centers] = kmeans(x,2^N);%exw parei ta kentroeidh
    for i = 1:length(x(:,1))%antikatastash me kentroeidh
        xq(i,:) = centers(idx(i),:);
    end
    k = 1;
    maxIterations = 20;%to polu 20 iterations
    D = zeros(maxIterations,1);
    D(k) = sum((x-xq).^2,'all');%ypologismos paramorfwshs
     while k < maxIterations
        %arxika ypologizw nea kentroeidh
        k = k + 1;
        [idx , centers] = kmeans(xq,2^N);
        for i = 1:length(x(:,1))
            xq(i,:) = centers(idx(i),:);
        end
        for i=1:10000
            D(k) = D(k) + sum( (x(1,:)-xq(i,:)).^2 ,'all');%ypologismos paramorfwshs
        end
        D(k) = D(k)/100;
        if (abs(D(k-1)-D(k))<10^(-6)) 
            break;
        end
     end
     sqnr = 0;
     for i=1:10000
         sqnr = sqnr + mean( x(i,:).^2 ) / mean( (x(i,:)-xq(i,:)).^2 ) ;
     end
     disp("SQNR : " + log10(sqnr/10000)*10);
end