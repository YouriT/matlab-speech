function [signalRecorder] = record(Fs, duration)
%Fs typiquement 11000
    % Record
    signalRecorder = audiorecorder(Fs, 16, 1);
    disp('Start speaking')
    recordblocking(signalRecorder, duration);
end
