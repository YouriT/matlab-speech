fs= 11000; %echantillonage
t= 40;
overlap= 0.5;
ceps = 12; %nombre de coefficients MFC 
%preEmphasized = filter([1 -.97], 1, A);
%a=buffer(preEmphasized,t,overlap,'nodelay');
%cols=size(a,2);
%ceps = zeros(ceps, cols);
 
 A=audioread('a.wav');
A_Mfcc= melcepst(A,1100);
subplot(221)
plot(A_Mfcc);
[ARows,ACols] = size(A_Mfcc);

disp(ARows);

B=audioread('b.wav');
B_Mfcc= melcepst(B,1100);
subplot(222);
plot(B_Mfcc);
[BRows,BCols] = size(B_Mfcc);

disp(BRows);

cmp = ARows - BRows;
disp(cmp);
    if (cmp > 0)
        % A est plus grand et B prends la taille de A, on remplit de 0s
        
        
        
        B_Mfcc = padarray(B_Mfcc,[cmp 0]);
    
    else
          % B est plus grand et A doit prendre la taille de B 
                    
          
          A_Mfcc = padarray(A_Mfcc,[abs(cmp) 0]);
    end
    

AdistB = (12);
for i=1:13
    
    temp1=A_Mfcc(:,i);
    temp2=B_Mfcc(:,i);
    
    temp3 = simmx(temp1, temp2);
    sum = sum + temp3;
end
moyenne = sum / 12;

disp('distance a et b = ');
disp(moyenne);
