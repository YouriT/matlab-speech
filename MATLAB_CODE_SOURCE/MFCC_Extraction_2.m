function [moyenne] = MFCC_Extraction_2(A, B, Fs)
A_Mfcc= melcepst(A,Fs);
B_Mfcc= melcepst(B,Fs);
[ARows,ACols] = size(A_Mfcc);
[BRows,BCols] = size(B_Mfcc);


%comparer le nombre de lignes de chaque matrice 
cmp = ARows - BRows;
    if (cmp > 0)
        % A est plus grand et B prends la taille de A
        temp = zeros(ARows,BCols);
    
        for i=1:BCols
           for j=1:BRows
               temp(j,i)=B_Mfcc(j,i);
           end
        end
        B_Mfcc=temp;

    else
        % B est plus grand et A doit prendre la taille de B 
        temp = zeros(BRows,ACols);
        for i=1:ACols
            for j=1:ARows
                temp(j,i)=A_Mfcc(j,i);
            end
        end
        A_Mfcc=temp;
          
    end
    


sum=0;
for i=1:BCols
    
    temp1=A_Mfcc(:,i);
    temp2=B_Mfcc(:,i);
    %calcule la distance entre chaque point du vecteur temporaire avec DTW
    temp3 = simmx(temp1, temp2);
    
    sum = sum + temp3;
end
moyenne = sum / ACols;



