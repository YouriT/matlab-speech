function [moyenne] = MFCC_Extraction_2(A, B, Fs)

%Fs typiquement 11000

%lire le fichier .wav
%A=audioread(file1);
%B=audioread(file2);
%renvoi 12 coefficients MFC -> caractéristiques du signal
A_Mfcc= melcepst(A,Fs);
B_Mfcc= melcepst(B,Fs);
%afficher sur graphique
%subplot(221)
%plot(A_Mfcc);
%subplot(222);
%plot(B_Mfcc);
%trouver le nombre de lignes pour redimensionnement, colonnes = toujours 12
[ARows,ACols] = size(A_Mfcc);
[BRows,BCols] = size(B_Mfcc);


%comparer le nombre de lignes de chaque matrice 
cmp = ARows - BRows;
    if (cmp > 0)
        % A est plus grand et B prends la taille de A, on remplit de 0s
        temp = zeros(ARows,12);
    
        for i=1:12
           for j=1:BRows
               temp(j,i)=B_Mfcc(j,i);
           end
        end
        B_Mfcc=temp;

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
    %calcule la distance entre chaque point du vecteur temporaire avec DTW
    temp3 = simmx(temp1, temp2);
    
    sum = sum + temp3;
end
moyenne = sum / 12;
   
   % disp('ce sont les mêmes lettres,  distance moyenne ='); 
    
 %disp('ce sont des lettres différentes,  distance moyenne ='); 








