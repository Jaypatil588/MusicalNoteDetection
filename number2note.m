function sm=number2note(n)
% convert note number n to note symbol sm
% n is the number in the formular 
% f=440*2^(n/12)

no1=floor((n-3)/12); % octave number no1=0 for octave 4
nn=n-no1*12; % specified note number
no=no1+5; % octave number
os=num2str(no); % octave symbol, if octave is 4 than it not displayed

switch nn 
    case 3
        sm=['C' os];
    case 4
        sm=['C' os '#' ];
    case 5
        sm=['D' os];
    case 6
        sm=['D' os  '#'];
    case 7
        sm=['E' os];
    case 8
        sm=['F' os];
    case 9
        sm=['F' os '#'];
    case 10
        sm=['G' os];
    case 11
        sm=['G' os '#'];
    case 12
        sm=['A' os ];
    case 13
        sm=['A' os  '#'];
    case 14
        sm=['B' os];
        
end