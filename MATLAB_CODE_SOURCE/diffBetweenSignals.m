function [matches] = diffBetweenSignals(word,alphabet)

delimitations = detectVoiced(word, 8000);
lpcDico = cell(1,length(alphabet));

for i=1:length(alphabet)
%     lpcDico{i} = lpc(alphabet{i},100);
% wavToSpectr(alphabet{i},8000)
% alphabet{i}
    lpcDico{i} = wavToSpectr(alphabet{i},8000);
end

temp = 9999;
matches = zeros(1,length(delimitations));
currentLetter = 0;

for i=1:length(delimitations)
%     lpcLetter = lpc(delimitations{i},100);
    specLetter = wavToSpectr(delimitations{i}, 8000);
    for j=1:length(alphabet)
%         tLpcLetter = lpcLetter;
%         tLpcDico = lpcDico{j};
%         if length(tLpcLetter) < length(tLpcDico)
%             tLpcLetter(length(tLpcDico)) = 0;
%         elseif length(tLpcLetter) > length(tLpcDico)
%             tLpcDico(length(tLpcLetter)) = 0;
%         end
%         subplot(length(alphabet),1,j);
%         plot([1:101],tLpcLetter,[1:101],tLpcDico);
%         diff = sqrt(sum((tLpcLetter-tLpcDico).^2));
        diff = checkSpectr(specLetter, lpcDico{j})
%         temp
        if diff < temp
            temp = diff;
            currentLetter = j;
        end
%         k = waitforbuttonpress
    end
    matches(i) = currentLetter;
    currentLetter = 0;
    temp = 9999;
end
end