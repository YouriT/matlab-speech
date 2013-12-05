function [R] = record2data(duration)
recordSignal = record(8000, duration);
signal = getaudiodata(recordSignal);
R = cell2mat(detectVoiced(signal, 8000));
end