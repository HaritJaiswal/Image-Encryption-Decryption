% clear;
% clc;

%=============================ACQUIRING IMAGE===========================
oImage = imread('/Users/haritjaiswal/Downloads/spiderverse-gang-8i-2880x1800.jpg');
figure('Name','Original Image','NumberTitle','off'), imshow(oImage);

%===============================COMPUTE DTFT============================
oFT = fft2(oImage);

%==============================MAG and PHASE============================
oMAG = abs(oFT);
oPHASE = angle(oFT);
figure('Name','Check Image','NumberTitle','off'), imshow(uint8(real(ifft2(oMAG.*exp(1j*oPHASE)))));
figure('Name','Magnitude Response','NumberTitle','off'), imshow(log(1+oMAG)/12);
figure('Name','Phase Response','NumberTitle','off'), imshow(oPHASE);

%==========================GENERATING RANDOM Nos========================
[row,col,dep] = size(oImage);
rndmFactors = uint8(randi(50,col,1))';

%==============================ALTERING PHASE===========================
a1PHASE = double(rndmFactors).*oPHASE;
figure('Name','New Phase Response','NumberTitle','off'), imshow(a1PHASE);

%==============================NEW TRANSFORM============================
FT1 = oMAG.*exp(1j*a1PHASE);

%--------------------------------
% PROBLEM: FTI != fft2(a1Image) |
%--------------------------------

%=================================NEW IMAGE=============================
a1Image = uint8(real(ifft2(FT1)));
figure('Name','Encrypted Image 1','NumberTitle','off'), imshow(a1Image);

%==========================FINAL IMAGE to be Sent=======================
rndmFactors(:,:,2) = zeros(1,col);
rndmFactors(:,:,3) = zeros(1,col);
finImage = cat(1,a1Image,rndmFactors);
imwrite(finImage,'./ReceivedImage.tif');
figure('Name','Encrypted image to be sent','NumberTitle','off'), imshow(finImage);

%================================DECRYPTING=============================

%==========================Getting random factors=======================
rImg = imread('ReceivedImage.tif');
[r,c,d] = size(rImg);
erndmFactors = squeeze(rImg(r,:,:));
erndmFactors = erndmFactors';
erndmFactors = erndmFactors(1,:);
erndmFactors = double(erndmFactors);

%=======================getting encrypted responses=====================
rImg(r,:,:) = [];
eFT = fft2(rImg);
ePHASE = angle(eFT);
eMAG = abs(eFT);

%==========================required phase response======================
PHASE = ePHASE./erndmFactors;

%==============================required image===========================
dFT = eMAG.*exp(1j*PHASE);
orImg = uint8(real(ifft2(dFT)));
figure('Name','Decrypted Image','NumberTitle','off'), imshow(orImg);

% clear;
% clc;