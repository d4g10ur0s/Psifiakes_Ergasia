function dict = hffmndict(alph ,prob)
   disp(prob);
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
       tdict(2,i) = a;
       dict(2,i) = "";%to code
   end
   %proetoimasia
   while numel(tdict(1,:)) > 1
       tdict = takeit_sorted(tdict);
       %disp(tdict);
       %sum and merge
       n = numel(tdict(1,:));%posa elements to tdict
       tdict(2,n-1)= str2double(tdict(2,n-1))+str2double(tdict(2,n));%sum tis pi8anothtes
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
   disp(dict);
   dict(2,:) = reverse(dict(2,:));
   enc = enchuff(dict,mystring);
   dec = dechuff(dict,enc);
   disp(enc);
   disp(dec);
end