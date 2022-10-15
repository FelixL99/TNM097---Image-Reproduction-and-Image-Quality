clc;

% Ladda in en bild och kör im2double
image = imread('Images/landscapeIMG_2.jpg');
image = im2double(image);

% Hämta bildens width och height
[width, height] = size(image(:,:,1));

% Diameter för kulorna som ska återskapa bilden
diameter = 30;

% Skapa och optimera en färgpalett, funktion returnerar färgpalett och
% optimiserad färgpalett.
% [colorPalette, optPalette, aA, aB, bA, bB] = createPalette(200);

% Plotta paletterna i A & B planet och se skillnad på optimerad palett mot vanliga.
% plot(aA, aB, '.');
% hold on
% plot(bA, bB, '.');

% figure
% imshow(colorPalette);
% figure
% imshow(optPalette);

% Resizea bilden med imresize. imresize beräknar automatiskt ett medel för
% det olika pixlarna när bilden skalas ner. Om vi då skalar bilden till det
% antalet kulor som ska användas för att reproducera bilden får vi en
% medelfärg per kula som vi sedan kan använda för att jämföra med paletten.
imageResized = imresize(image, [ceil(width/diameter), ceil(height/diameter)]);

% figure
% imshow(imageResized)

% Hitta liknande färger mellan den nerskalade bilden och paletten. Spara
% alla färger från paletten som mest liknar för varje pixel i bilden.
matchedImageOpt = matchmaking(imageResized, optPalette);
matchedImageOrg = matchmaking(imageResized, colorPalette);

% figure
% imshow(matchedImageOpt)
% figure
% imshow(matchedImageOrg)

% Skapa en binär pärla som kan användas för att återskapa bilden.
binaryPearl = createPearl(diameter);

% figure
% imshow(binaryPearl);

% Reproducera bilden med hjälp av matchedImage och pärlan. En pixel i
% matchedImage är färgen för en pärla i reproduktionen.
generatedImageOpt = generateImage(matchedImageOpt, binaryPearl);

generatedImageOrg = generateImage(matchedImageOrg, binaryPearl);
% Gör bilderna lika stora
image = imresize(image, [size(generatedImageOpt, 1), size(generatedImageOpt,2)], 'bicubic');

figure
imshow(image);
figure
imshow(generatedImageOpt);
figure
imshow(generatedImageOrg);

% % SCIELAB BERÄKNINGAR FÖR BILDERNA
% 
% Byt båda bilderna till XYZ rymden
imageXYZ = rgb2xyz(image);
optImageXYZ = rgb2xyz(generatedImageOpt);
orgImageXYZ = rgb2xyz(generatedImageOrg);


% Bestäm dpi och distance
dpi = 300;
distance = 20;

% Beräkna sample degree genom visualAngle funktionen
sampDegree = visualAngle(-1,distance,dpi,1);
whitePointD65 = [90.05,100,108.9];

% Beräkna scielab mellan det båda bilderna
scielabResultOpt = scielab(sampDegree, imageXYZ, optImageXYZ, whitePointD65, 'xyz');

scielabResultOrg = scielab(sampDegree, imageXYZ, orgImageXYZ, whitePointD65, 'xyz');

% Ta fram ett medelresultat
meanResultOpt = mean(mean(scielabResultOpt));
meanResultOrg = mean(mean(scielabResultOrg));


