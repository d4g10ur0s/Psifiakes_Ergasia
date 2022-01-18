function dec = dechuff(dict,mstr)
    
    tstr = mstr;%to code pou kanw decode
    dec = "";%arxika to dec den einai tpt
    j = 1;%enas counter gia na perasw to string
    while strlength(tstr{1})>j%sto telos den 8a exw alla pragmata na kanw decode
        tdict = dict;%temporary dictionary
        i = 1;%deikths gia na pernaw to dictionary
        k = 1;%deikths gia iteration tou code
        %vlepw epomeno gramma, an tairiazei kratw
        while numel(tdict(1,:)) > 1 %8a exei meinei mono 1 sto telos
            tcode = tdict(2,i);%pairnw to code
            if tcode{1}(k) == mstr{1}(j)%an einai idia paw mia 8esh mprosta
                i = i + 1;
                %an to k == tcode.length ,tote exw kati pou tairiazei
                if k == strlength(tcode)
                    tdict = tdict(:,i-1);
                    break;
                end
            else%an den einai idia to element feugei
                tdict(:,i) = [];
            end
            %an eftasa sto telos tou dictionary, i=1 j+=1 k+=1
            if numel(tdict(1,:)) < i
                i = 1;
                j = j+1;
                k = k+1;%oti exei epizhsei, an einai iso me k-1
            end
        end
        j = j+1;
        dec = append(dec,tdict(1,1));
    end
end