function dict = hffmndict(alph)
   dict = zeros(2,length(alph{:,1}));
   tdict = zeros(2,length(alph{:,1}));%temporary
   dict = string(dict);
   tdict = string(tdict);
   %proetoimasia
   for i = 1:length(alph{:,1})%vazw katallhles times
       a = alph{i,1};%to gramma
       dict(1,i) = a{1};
       tdict(1,i) = a{1};
       a = alph{i,2};%h pi8anothta
       tdict(2,i) = a;
       dict(2,i) = "";%to code
   end
   %proetoimasia
   while numel(tdict(1,:)) > 1
       tdict = takeit_sorted(tdict);
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
   dict(2,:) = reverse(dict(2,:));%vazw tous kwdikous me thn swsth morfh
   disp(dict);%apla ena display
end