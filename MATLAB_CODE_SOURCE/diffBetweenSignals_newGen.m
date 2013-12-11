function [matches] = diffBetweenSignals(word,alphabet)

acronyme = detectVoiced(word, 8000); %divise le signal
mfccDico = cell(1,length(alphabet));%Création du tableau de cellule de longueur de l'alphabet

for i=1:length(alphabet)
    mfccDico{i} = melcepst(alphabet{i},8000);%Extraction des coefficients Mfcc de chaque lettre de l'alphabet
end

temp = 0; %valeur de différence entre les signaux
matches = zeros(1,length(acronyme));%Tableau contenant le résultat de la comparaison
currentLetter = 0;%La lettre en cours de comparaison

for i=1:length(acronyme)
    for j=1:length(alphabet)
        result=MFCC_Extraction_2(acronyme{i}, alphabet{j});
        if(temp<result)
            temp=result;
            matches{1,i}=j;
        end
%         k = waitforbuttonpress
    end
    matches(i) = currentLetter;
    currentLetter = 0;
    temp = 9999;
end
end