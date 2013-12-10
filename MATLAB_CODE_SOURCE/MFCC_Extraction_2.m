function [moyenne] = MFCC_Extraction_2(file1, file2)

fs= 11000; %echantillonage

 
A=audioread(file1);
A_Mfcc= melcepst(A,fs);
subplot(221)
plot(A_Mfcc);
[ARows,ACols] = size(A_Mfcc);

disp(ARows);

B=audioread(file2);
B_Mfcc= melcepst(B,fs);
subplot(222);
plot(B_Mfcc);
[BRows,BCols] = size(B_Mfcc);

disp(BRows);
cmp = ARows - BRows;
disp(cmp);
    if (cmp > 0)
        % A est plus grand et B prends la taille de A, on remplit de 0s
        temp = zeros(ARows,12);
        disp(size(B_Mfcc(:,12)));
        for i=1:12
           for j=1:BRows
               temp(j,i)=B_Mfcc(j,i);
           end
        end
        B_Mfcc=temp;
        disp(size(B_Mfcc(:,12)));

        

    else
        % B est plus grand et A doit prendre la taille de B 
        temp = zeros(BRows,12);
        for i=1:12
            for j=1:ARows
                temp(j,i)=A_Mfcc(j,i);
            end
        end
        A_Mfcc=temp;
          
    end
    


sum=0;
for i=1:12
    
    temp1=A_Mfcc(:,i);
    temp2=B_Mfcc(:,i);
    
    temp3 = simmx(temp1, temp2);
    
    sum = sum + temp3;
end
moyenne = sum / 12;

disp('distance a et b = ');

