function [xq, D] = lmax(x, N, min_value, max_value)
    x = randn(10000,1);%random x 
    pcount = 2^N;%to plh8os twn shmeiwn pou prepei na xwrhsw
    %pairnw tyxaia shmeia kvantismou
    mrange = (max_value - min_value);%orizw step to range
    tskv = (0);
    while numel(tskv(:)) < pcount
        tskv = rand(pcount,1) * mrange + min_value;%pairnw pcount tyxaia shmeia entos tou range
        tskv = unique(tskv);%prepei ola ta shmeia na einai diaforetika
    end
    tskv = sort(tskv);% sorting
    limits = zeros(pcount,1);
    limits(1) = min_value; %to teleutaio    
    limits(pcount) = max_value; % to prwto
    for i = 2:(pcount-1)%prepei na vrw limits
        limits(i) = ( tskv(i) + tskv(i-1) )/2;%ypologismos kentroeidwn
    end
    xq = zeros(10000,1)*100;
    for i=1:length(x)%gia ka8e timh sto x 
        for j=2:pcount
            if ((x(i)>limits(j-1))&&(x(i)<=limits(j)) || x(i) < limits(j)) %euresh diasthmatos pou anhkei to x
                xq(i) = pcount-j+1; 
                break;
            end 
            if (j==pcount)
                xq(i) = 1;
            end
        end
    end
    %disp(limits);
    maxIterations = 10;%to polu 20 iterations
    k = 1;
    D = zeros(maxIterations,1);
    T = zeros(pcount,1);
    T(1) = min_value;
    T(pcount)=max_value;
    D(k) = sum((x-xq).^2);%ypologismos paramorfwshs
    while k < maxIterations
        %arxika ypologizw nea kentroeidh
        k = k + 1;
        for i =2:pcount-2
            T(i) = (limits(i)+limits(i-1))/2;
            limits(i) = T(i);
        end
        for i=1:length(x)%gia ka8e timh sto x 
            for j=2:pcount
                if ((x(i)>limits(j-1))&&(x(i)<=limits(j)) || x(i) < limits(j)) %euresh diasthmatos pou anhkei to x
                    xq(i) = pcount-j+1; 
                    break;
                end 
                if (j==pcount)
                    xq(i) = 1;%to megalutero epipedo kvadishs
                end
            end
        end
        D(k) = sum((x-xq).^2);%ypologismos paramorfwshs
        if (abs(D(k-1)-D(k))<10^(-6)) 
            disp( abs( D(k-1) - D(k) ) );
            break;
        end
    end
    disp("SQNR : " + mean( x.^2 ) / mean( (x-xq).^2 ) );
end
