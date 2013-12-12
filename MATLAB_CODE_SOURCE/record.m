function [signalRecorder] = record(Fs, duration)
    % Record
    signalRecorder = audiorecorder(Fs, 16, 1);
    disp('Start speaking')
    if duration > -1
        recordblocking(signalRecorder, duration);
    else
        disp('Press button to stop')
        record(signalRecorder)
        waitforbuttonpress;
        stop(signalRecorder)
    end
end
