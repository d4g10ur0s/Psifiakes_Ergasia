function dec = dechuff(dict,mstr)
    tstr = mstr;%to code pou kanw decode
    dec = "";%arxika to dec den einai tpt
    j = 1;%enas counter gia na perasw to string
    while strlength(tstr{1})>j%sto telos den 8a exw alla pragmata na kanw decode
        disp("egine");
        tdict = dict;%se ena temp dict 8a exw ta ypopshfia ka8e fora
        i = 1;%enas counter gia na pernaw to dictionary
        k = 1;%enas counter gia to position mesa sto code
        while numel(tdict(1,:)) > 1%oso den exw vrei akoma ta elements
            tcode = tdict(2,i);%pairnw to code tou grammatos
            if k > strlength(tcode)
                %to gramma feugei
                disp("8a fugei " + tdict(1,i));
                tdict(:,i) = [];
            elseif tcode{1}(k)==tstr{1}(j)%an ta codes einai idia paw para pera
                i = i+1;%to element menei
            else
                %to gramma feugei
                disp("8a fugei " + tdict(1,i));
                tdict(:,i) = [];
            end
            if i > numel(tdict(1,:))%an eftasa sto telos tou dictionary,to i=1 kai j+=1
                i=1;
                j=j+1;
                k=k+1;
            end
        end%oso den exw vrei akoma ta elements
        dec = append(dec,tdict(1,1));%vazw to gramma
        %an den eftasa sto telos pros8etw sto j kati
        j = j + strlength(tdict(2,1)) - k + 1;
        disp(dec);
        disp(j);
    end
end