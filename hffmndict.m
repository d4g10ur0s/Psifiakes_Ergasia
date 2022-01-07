function dict = average(alph ,prob)
   %   alfavhto   symbol
   dict = [alph; zeros(1,numel(alph))];%o,ti 8a epistrafei
   dict(2,:) = "";
   %
   epe = [alph; prob];
   while (~(length(epe(1,:)) == 1 ))% oso ta elements mou einai katw apo 1 se pi8anothta
       epe = takeit_sorted(epe);   %elements sorted
       %ta 2 ta kanw 1
       %ta stoixeia einai sortarismena
       %pairnw ta 2 mikrotera
       n = numel(epe(1,:));
       %prin kanw append 8a valw times
       %to deksi 8a parei 1
       mstr = char(epe(1,n));
       disp("deksi "+mstr);
       for i =1:strlength(mstr)
           for j =1:numel(dict(1,:))
               if mstr(i) == dict(1,j)
                   dict(2,j)=append(dict(2,j),"1");
                   break;
               end
           end
       end
       %to aristero 8a parei 0
       mstr = char(epe(1,n-1));
       disp("aristero " + mstr);
       for i =1:strlength(mstr)
           for j =1:numel(dict(1,:))
               if mstr(i) == dict(1,j)
                   dict(2,j)=append(dict(2,j),"0");
                   break;
               end
           end
       end
       epe(1,n-1)= append(epe(1,n-1),epe(1,n));
       epe(2,n-1)= str2double(epe(2,n-1))+str2double(epe(2,n));
       epe = epe(:,1:n-1);
       disp(dict);
   end
end

function mdict = takeit_sorted(dict)
   [d,mprob] = sort(dict(2,:));%pairnw sortarisma +fwna me pi8anothtes
   dict = dict(:,flip(mprob));
   mdict = dict;
end
