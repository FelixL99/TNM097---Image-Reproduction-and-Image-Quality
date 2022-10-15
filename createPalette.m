function [fullColorPalette, optimizedColorPalette, aA, aB, bA, bB] = createPalette(colorAmount)
% createPalette, Funktion för att skapa en färgpalett.
%   Denna funktion stegar upp i RGB rymden och skapar en färgpalett sedan
%   går igenom paletten och optimiserar färgerna så färger liknande
%   varandra plockas bort.

% Högre threshold = färre färger efter optimering
% Lägre threshold = fler färger efter optimering
THRESHOLD = 40;

% Skapa en random genererad färgpalett med ett valt antal genererade färger
paletteRGB = rand(1, colorAmount, 3);

% B(1,1,:) = 0.1;
% W(1,1,:) = 0.9;
% 
% paletteRGB(1, size(paletteRGB,2) + 1, :) = B;
% paletteRGB(1, size(paletteRGB,2) + 1, :) = W;


% Byt paletten till Lab rymden
paletteLAB = rgb2lab(paletteRGB);

% Dela upp paletten, en variabel per kanal
L = paletteLAB(:,:,1);
A = paletteLAB(:,:,2);
B = paletteLAB(:,:,3);

aA = A;
aB = B;

% Optimera färgpaletten, beräkna deltaE mellan det olika pixlarna
for i = 1:1:colorAmount
    for j = i+1:1:colorAmount
        
        % Beräkna deltaE mellan valda pixeln och alla efterkommande pixlar
        deltaE = sqrt((L(:,i) - L(:,j)).^2 + (A(:,i) - A(:,j)).^2 + (B(:,i) - B(:,j)).^2);
        
        if deltaE < THRESHOLD
            % Sätt färgen som liknar till 0 värde för LAB
            L(1,i) = -1;
            A(1,i) = -1;
            B(1,i) = -1;
            
            break;
        end
    end
end

% Ta bort alla värden i varera kanal som satts till 0 i tidigare skede
L(L == -1) = [];
A(A == -1) = [];
B(B == -1) = [];

bA = A;
bB = B;

% Sätt ihop det 3 variablerna igen till en 3 dimensionel palett
LAB = cat(3, L, A, B);

% Konvertera tillbaka paletten från Lab rymden till RGB
optPalette = lab2rgb(LAB);

% Returna paletten innan-och efter optimisering
fullColorPalette = paletteRGB;
optimizedColorPalette = optPalette;

end

