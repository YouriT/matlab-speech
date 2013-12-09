function [points] = endpointdetection(inputSignal)
    P = inputSignal .^ 2;
    size(P)
    noiseValue = sum(P)/length(P);
    plot(P)
    line([0,length(inputSignal)],[noiseValue,noiseValue]);
    
    points = {};
    increment = 1;
    
    startDetected = 0;
    startP = 0;
    endP = 0;
    remember = 0;
    endCounter = 0;
    for i=1:length(P)
        i
        P(i)
        noiseValue
        
        startDetected
        if P(i) > noiseValue && startDetected == 0
            startP = i;
            startDetected = 1;
        elseif P(i) < noiseValue && startDetected == 1
            if endP == 0
                endP = i;
                remember = i;
            elseif endCounter < 800
                endCounter = endCounter+1;
            elseif endCounter >= 800
                points{increment} = [startP, endP];
                startP = 0;
                endP = 0;
                remember = 0;
                endCounter = 0;
                increment = increment + 1;
                startDetected = 0;
            end
        elseif P(i) > noiseValue && startDetected == 1
            endP = 0;
            remember = 0;
            i = remember;
            endCounter = 0;
        end
    end
end