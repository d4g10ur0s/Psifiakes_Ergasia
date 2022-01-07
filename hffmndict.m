function dict = hffmndict(alph ,prob)
   %   alfavhto   symbol
   dict = [alph; zeros(1,numel(alph))];%o,ti 8a epistrafei
   dict(2,:) = "";
   %
   epe = [alph; prob];
   while (~(length(epe(1,:)) == 1 ))% oso ta elements mou einai katw apo 1 se pi8anothta
       epe = takeit_sorted(epe);   %elements sorted
       epe = sum_and_code(epe);    %ta 2 elements eginan 1,prepei na kanw eval se dict
       %to teleutaio element einai to 1 symbol
       msymbol = epe(1,numel(epe(1,:)));
       for k = 1:strlength(msymbol)
           for l = 1:length(dict(1,:))
               if string(msymbol{1}(k:k))==string(dict(1,l))
                   disp(dict(1,l));
                   if k == strlength(msymbol)%tote vazw 1,nea symvola
                       dict(2,l) = append( string(dict(2,l)) , "0");
                   else%tote vazw 0, palia symvola
                       dict(2,l) = append( string(dict(2,l)) , "1");
                   end
               end%locate symbol
           end%gia ka8e symbol sto dict
       end%gia ka8e symbol sto msymbol
       %disp(dict);
   end
end

function mdict = takeit_sorted(dict)
   mprob = dict(2,:);
   %%ksekinaw
   mprob = flip(sort(mprob));
   ndict = [dict(1,:); mprob];%temp dictionary
   for i = 1:numel(mprob)
       %vazw kleidia se antistoixh 8esh
       for j = 1:numel(dict(1,:))
           if str2double(mprob(i)) == str2double(dict(2,j))
              ndict(1,i) = dict{1,j};%vazw to antistoixo key sthn pi8anothta
              dict(2,j) = -1;%vazw -1 gia na mhn elegx8ei pali          
              break;
           end
       end
   end
   %sorted ke me times pou eixe prin
   dict = [ndict(1,:);ndict(2,:)];
   mdict = dict;
end

function mdict = sum_and_code(dict)
    %pairnw ta 2 mikrotera
    %disp(dict);
    n = numel(dict(2,:));
    %disp(n);
    %sum oi pi8anothtes
    mel = [dict(2,n-1), dict(2,n)];
    disp(mel);
    sum = str2double(mel(1))+ str2double(mel(2));
    %vazw a8roisma pi8anothtwn
    dict(2,n-1) = sum; 
    dict(2,n) = sum;
    %petaw to teleutaio ,to kanw append gia na ginei ena symvolo
    %teleutaio 8a mpainei to symvolo pou einai mono tou
    if strlength(string(dict(1,n)))==1
        dict(1,n-1) = append( string(dict(1,n-1)) , string(dict(1,n)));
    else
        dict(1,n-1) = append( string(dict(1,n)) , string(dict(1,n-1)));
    end
    mdict = [dict(1,1:n-1); dict(2,1:n-1)];
end
