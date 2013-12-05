function [R] = record2data(duration, n)

acc = zeros(duration*8000,1);
for i=1:n
    recordSignal = record(8000, duration);
    datas = cell2mat(detectVoiced(getaudiodata(recordSignal),8000));
    datas = datas.*hamming(length(datas));
    filterHF = [1 0.9];
    datas = filter(1,filterHF,datas);
    if length(datas) < length(acc)
        datas(length(acc)) = 0;
    end
    acc = acc + datas;
    subplot(n+1,1,i);
    plot(datas);
end

R = acc/n;
subplot(n+1,1,n+1);
plot(acc/n);
end