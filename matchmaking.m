function [matchedImage] = matchmaking(imResized,palette)
% matchmaking, Funktion för att matcha bildens verkliga färger mot färgpaletten.
%   Denna funktion matchar färgen från bilden med färgen från paletten och sparar den färg
%   från paletten som är mest lik den verkliga bildens färg för varje pixel
%   i en ny bild/matris.

% Konvertera bilden och paletten till LAB rymden
imLAB = rgb2lab(imResized);
paletteLAB = rgb2lab(palette);

imL = imLAB(:,:,1);
imA = imLAB(:,:,2);
imB = imLAB(:,:,3);

pL = paletteLAB(:,:,1);
pA = paletteLAB(:,:,2);
pB = paletteLAB(:,:,3);

% Preallokerar matchedImage för att spara färgerna
matchedImage = zeros(size(imResized));

% Preallokera deltaE array för att spara deltaE värdena.
deltaE = zeros(1,length(palette));


for i = 1:1:size(imResized,1)
    for j = 1:1:size(imResized,2)

        % Beräkna deltaE för pixeln mot alla färger i paletten
        for k = 1:1:length(palette)
            deltaE(1,k) = sqrt((imL(i,j) - pL(1,k)).^2 + (imA(i,j) - pA(1,k)).^2 + (imB(i,j) - pB(1,k)).^2);
        end
        
        % Hitta index för minsta värde i deltaE array
        idx = find(deltaE == min(deltaE));
        
        % Lägg till färgen för minsta deltaE från arrayen i matchedImage
        matchedImage(i,j,1) = pL(1, idx);
        matchedImage(i,j,2) = pA(1, idx);
        matchedImage(i,j,3) = pB(1, idx);
        
    end
end

matchedImage = lab2rgb(matchedImage);

end

