function [freq,sym] = findtheff(x,fs)

y=fft(x,fs*4); % perform FFT with the frequency resolution of 0.25 
S=abs(y); 
[a,b]=max(S(1:fs*2)); %find the index of the highest amplitude
ff=linspace(0,fs/2,fs*2); %freq band 
freq=ff(b) %estimate the fundamental frequency
n = round(12*log2(freq/440)); % calc the note number
sym = number2note(n) %generate the symbol by the estimate the freq

plot(ff,S(1:2*fs)); xlabel('Frequency band in Hz'); grid on;
axis([0 2.5*freq 0 max(S(1:fs*2))]); % set the ff in the middle for clear view
end
