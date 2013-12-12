function displaySignals(signals)
    for i=1:length(signals)
        subplot(length(signals),1,i);
        plot(cell2mat(signals(i)));
    end
end