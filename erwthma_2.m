function erwthma_2()
   mprob = [];
   %%fileID = fopen('D:\Sxolh\4o_Etos\Xeimerino\Psifiakes_Tilepikinonies\Project1\Assignment1\frequencies.txt');
   alph = readtable('D:\Sxolh\4o_Etos\Xeimerino\Psifiakes_Tilepikinonies\Project1\Assignment1\frequencies.txt','Format','%s%f');
   mystring = fileread('D:\Sxolh\4o_Etos\Xeimerino\Psifiakes_Tilepikinonies\Project1\Assignment1\cvxopt.txt');
   %%fclose(fileID);
   dict = zeros(2,length(alph{:,1}));
   tdict = zeros(2,length(alph{:,1}));%temporary
   dict = string(dict);
   tdict = string(tdict);
   %proetoimasia
   for i = 1:length(alph{:,1})%vazw katallhles times
       a = alph{i,1};%to gramma
       if a{1} == 'space'
           dict(1,i) = ' ';
           tdict(1,i) = ' ';
       else
           dict(1,i) = a{1};
           tdict(1,i) = a{1};
       end
       a = alph{i,2};%h pi8anothta
       mprob(1,i) = a;
       tdict(2,i) = a;
       dict(2,i) = "";%to code
   end
   %allazw pi8anothta gia erwthma 1
   for i =1:numel(tdict(1,:))
       
       a = count(mystring,dict(1,i),'IgnoreCase',true);
       tdict(2,i) = a/strlength(mystring);
       mprob(1,i) = tdict(2,i);
       
   end
   %proetoimasia
   while numel(tdict(1,:)) > 1
       tdict = takeit_sorted(tdict);
       %disp(tdict);
       %sum and merge
       n = numel(tdict(1,:));%posa elements to tdict
       tdict(2,n-1)= str2double(tdict(2,n-1))+str2double(tdict(2,n));%sum tis pi8anothtes
       %b = tdict(1,1);
       %disp(b);
       for j = 1:strlength(tdict( 1, n - 1 ) )%gia ka8e element mesa sto aristero string
           for i = 1:numel(dict(1,:))%vriskw se poia 8esh anhkei
               b = char( tdict( 1 , n-1) );
               if char(dict(1,i)) == b(j)
                   dict(2,i) = append(dict(2,i), "0");
                   break;
               end
           end
       end
       for j = 1:strlength(tdict( 1, n ))%gia ka8e element mesa sto deksi string
           for i = 1:numel(dict(1,:))%vriskw se poia 8esh anhkei
               b = char( tdict( 1 , n) );
               if char(dict(1,i)) == b(j)
                   dict(2,i) = append(dict(2,i), "1");
                   break;
               end
           end
       end
       %prepei na mergarw ke na meiwsw
       tdict(1,n-1) = append(tdict(1,n-1),tdict(1,n));%merge ta codes
       tdict = tdict(:,1:n-1);
   end
   dict(2,:) = reverse(dict(2,:));
   enc = enchuff(dict,mystring);
   dec = dechuff(dict,enc);
   disp("edosa");
   disp(mystring);
   disp("phra");
   disp(enc);
   disp("apokwdikopoih8hke");
   disp(dec);
   all_lengths = 0;
   for i = 1:numel(mprob(1,:))
       mprob(1,i) = mprob(1,i) * log(mprob(1,i));
       all_lengths = all_lengths+strlength(dict(2,i));
   end
   mprob = sum(mprob,'all');
   disp("Entropy : " + -mprob);
   disp("Average code length : " + all_lengths/numel(dict(1,:)));
end

function mdict = takeit_sorted(dict)
   [d,mprob] = sort(dict(2,:));%pairnw sortarisma +fwna me pi8anothtes
   dict = dict(:,flip(mprob));
   mdict = dict;
end

function enc = enchuff(dict,mstr)

    %prepei na parw ka8e element tou mstr ke na vrw ti code einai mesa sto
    %dict
    disp(dict);
    enc = "";
    %disp(mstr(1,1));
    lngt = strlength(mstr);
    for i = 1:lngt
        for j = 1:numel(dict(1,:))
            if mstr(1,i) == dict(1,j)
                enc = append(enc,dict(2,j));
            end
        end
    end
end

function dec = dechuff(dict,mstr)
    
    tstr = mstr;%to code pou kanw decode
    dec = "";%arxika to dec den einai tpt
    j = 1;%enas counter gia na perasw to string
    while strlength(tstr{1})>j%sto telos den 8a exw alla pragmata na kanw decode
        tdict = dict;%temporary dictionary
        i = 1;%deikths gia na pernaw to dictionary
        k = 1;%deikths gia iteration tou code
        %disp("+mvainei");
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
