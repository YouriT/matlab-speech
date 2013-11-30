function [startP, endP] = endpointdetection(inputSignal)
    P = inputSignal .^ 2;
    noiseValue = sum(P)/length(P);
    startDetected = 0;
    for i=1:length(P)
        if P(i) > noiseValue && startDetected == 0
            startP = i;
            startDetected = 1;
        elseif P(i) < noiseValue && startDetected == 1
            endP = i;
            return;
        end
    end
end