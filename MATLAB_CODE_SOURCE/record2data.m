function [avg] = record2data(duration, n,Fs)

acc = zeros(duration*Fs,1);
for i=1:n
    recordSignal = record(Fs, duration);
    voice = getaudiodata(recordSignal);
    datas = detectVoiced(voice,Fs);
    
    if length(datas) == 1
        datas = cell2mat(datas);
        datas = cleanSignal(datas);
    else
        avg = voice;
        subplot(2,2,4);
        plot(voice);
        return;
    end
    
    if length(datas) < length(acc)
        datas(length(acc)) = 0;
    end
    acc = acc + datas;
%     subplot(n+1,1,i);
%     plot(datas);
end

avg = acc/n;
subplot(2,2,4);
plot(acc);
end