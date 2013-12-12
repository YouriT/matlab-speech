function diff = checkSpectr( spec1 , spec2 )
% abs( spec ) is already done
M = simmx( spec1 , spec2 );
 
[p,q,D] = dp(1-M);
% p &amp; q the best path
% D the cumulate matrix
 
diff = D(size(D,1),size(D,2)) ;
end