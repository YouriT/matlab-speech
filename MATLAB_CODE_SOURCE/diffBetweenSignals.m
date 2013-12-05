function [matches] = diffBetweenSignals(word,alphabet)

delimitations = detectVoiced(word, 8000);
lpcDico = cell(1,length(alphabet));

for i=1:length(alphabet)
    lpcDico{i} = lpc(cell2mat(detectVoiced(alphabet{i},8000)),50);
end

temp = 9999;
matches = zeros(1,length(delimitations));
currentLetter = 0;

for i=1:length(delimitations)
    lpcLetter = lpc(delimitations{i},50);
    for j=1:length(alphabet)
        tLpcLetter = lpcLetter;
        tLpcDico = lpcDico{j};
        if length(tLpcLetter) < length(tLpcDico)
            tLpcLetter(length(tLpcDico)) = 0;
        elseif length(tLpcLetter) > length(tLpcDico)
            tLpcDico(length(tLpcLetter)) = 0;
        end
        subplot(length(alphabet),1,j);
        plot([1:51],tLpcLetter,[1:51],tLpcDico);
        diff = sqrt(sum((tLpcLetter-tLpcDico).^2));
        diff
%         temp
        if diff < temp
            temp = diff;
            currentLetter = j;
        end
    end
    matches(i) = currentLetter;
    currentLetter = 0;
    temp = 9999;
end
end