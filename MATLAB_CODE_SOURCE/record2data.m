function [avg] = record2data(duration, n,Fs)

%Fs typiquement 11000

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
        return;
    end
    
    if length(datas) < length(acc)
        datas(length(acc)) = 0;
    end
    acc = acc + datas;
    subplot(n+1,1,i);
    plot(datas);
end

avg = acc/n;
subplot(n+1,1,n+1);
plot(acc/n);
end