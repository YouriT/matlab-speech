=== README

cd path/to/working/directory
addpath('silence-remover')

```
% arguments Fs and duration of the record
recordSignal = record(8000, 5)

% get datas from the record
signal = getaudiodata(recordSignal)

% signalDatas & Fs
onlyVoiceSignal = detectVoiced(signal, 8000)

% echo voice signal only
audioOut = audioplayer(cell2mat(onlyVoiceSignal), 8000)
play(audioOut)
```