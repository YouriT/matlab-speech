function [matches] = diffBetweenSignals_newGen(word,alphabet,Fs)

acronyme = detectVoiced(word, Fs);
[acro_rows,acro_cols] = size(acronyme);
matches = cell(1,acro_cols);
disp(size(acronyme));
disp(size(alphabet));

for i=1:acro_cols
    temp = 0; %valeur de différence entre les signaux
    for j=1:length(alphabet)
        
        result=MFCC_Extraction_2(acronyme{1,i}, alphabet{j,1}, Fs);
        disp('resultat comparaison numero  ');
        disp(j);
        disp('= ');
        disp(result);
        if(temp<result)
            temp=result;
            matches{1,i}=j;
        end
    end
end
end