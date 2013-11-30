function [signalRecorder] = record(Fs, duration)
    % Record
    signalRecorder = audiorecorder(Fs, 16, 1);
    disp('Start speaking')
    recordblocking(signalRecorder, duration);
end
