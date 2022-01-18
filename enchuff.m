function enc = enchuff(dict,mstr)
    %to dict sthn prwth grammh stoixeia alphavitou , sthn 2h to code
    %prepei na parw ka8e element tou mstr ke na vrw ti code einai mesa sto
    enc = "";
    lngt = strlength(mstr);
    for i = 1:lngt
        for j = 1:numel(dict(1,:))
            if mstr(1,i) == dict(1,j)
                enc = append(enc,dict(2,j));
            end
        end
    end
end