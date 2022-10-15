function generatedImage = generateImage(matchedImage,binaryPearl)
%generateImage, Funktion för att generera en reproduktion av orginalbilden.
%   Denna funktion tar in matchmaking bilden och en pärla och återskapar
%   orgialbilden med hjälp av pärlorna genom att färga och lägga till
%   pärlorna på rätt plats utifrån matchmaking bilden.

% Hämta width och height för bilden och pärlan
[widthIm, heightIm] = size(matchedImage(:,:,1));
[widthPearl, heightPearl] = size(binaryPearl);

% Skapa tre olika variabler för det olika RGB kanalerna
pearlR = binaryPearl;
pearlG = binaryPearl;
pearlB = binaryPearl;


% Skapa en ny bild som är stor nog att diametern av pärlan representeras av
% en pixel i gamla bilden.
generatedImage = zeros(widthIm*widthPearl, heightIm*heightPearl, 3);

% Gå igenom bilden med steg lika stora som pärlorna
for i = 1:widthPearl:size(generatedImage,1)
    for j = 1:heightPearl:size(generatedImage,2)

        % Hämta rätt färg för pärlan utifrån matchedImage
        pearlR(pearlR~=1) = matchedImage(ceil(i/widthPearl),ceil(j/heightPearl),1);
        pearlG(pearlG~=1) = matchedImage(ceil(i/widthPearl),ceil(j/heightPearl),2);
        pearlB(pearlB~=1) = matchedImage(ceil(i/widthPearl),ceil(j/heightPearl),3);

        % Lägg till den färgade pärlan i bilden på rätt plats
        generatedImage(i:i+widthPearl-1,j:j+heightPearl-1,1) = pearlR;
        generatedImage(i:i+widthPearl-1,j:j+heightPearl-1,2) = pearlG;
        generatedImage(i:i+widthPearl-1,j:j+heightPearl-1,3) = pearlB;

    end
end


end

