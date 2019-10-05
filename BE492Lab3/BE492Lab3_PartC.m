%Part C
close all;

USAF1951_focused = imread('04_C5.bmp');
USAF1951_defocused = imread('05_C6.bmp');
USAF1951_shifted = imread('06_C7.bmp');

%Grayscale Conversion using NTSC standards
Focusedgray = 0.2989*USAF1951_focused(:,:,1) + 0.5870*USAF1951_focused(:,:,2) + 0.1140*USAF1951_focused(:,:,3);
Defocusedgray = 0.2989*USAF1951_defocused(:,:,1) + 0.5870*USAF1951_defocused(:,:,2) + 0.1140*USAF1951_defocused(:,:,3);
Shiftedgray = 0.2989*USAF1951_shifted(:,:,1) + 0.5870*USAF1951_shifted(:,:,2) + 0.1140*USAF1951_shifted(:,:,3);

FG_size = size(Focusedgray);
DFG_size = size(Defocusedgray);
SG_size = size(Shiftedgray);

microns_x = [0 ((1280 * 3.6)/(0.5*4))];
microns_y = [0 ((1024 * 3.6)/(0.5*4))];

FigureC1 = figure('name', 'Focused');
colormap(gray(256));
imagesc(microns_x,microns_y, Focusedgray);
title('NTSC Standard Grayscaled 4x Magnification in Focus');
xlabel('Microns');
ylabel('Microns');

FigureC2 = figure('name', 'Defocused');
colormap(gray(256));
imagesc(microns_x,microns_y, Defocusedgray);
title('NTSC Standard Grayscaled 4x Magnification Defocused');
xlabel('Microns');
ylabel('Microns');

%in-focus: Group 7 element 6
%out: Group 4 Element 6
infocus_real = 2^(7+((6-1)/6));
outfocus_real = 2^(4+((6-1)/6));
%NA
infoc_m = 1000/(2*infocus_real);
outfoc_m = 1000/(2*outfocus_real);
NA_infoc = 0.5/(2*infoc_m);
NA_outfoc = 0.5/(2*outfoc_m);

%filter function
ftpic_in = fftshift(fft2(Focusedgray));
ftpic_out = fftshift(fft2(Defocusedgray));
filterfxn = ftpic_out./ftpic_in;
filterfxn_abs = abs(filterfxn);
filterfxn_abs(filterfxn_abs>1) = 1;

FigureC3 = figure('Name', 'Filter Function');
colormap(gray(256));
imagesc(microns_x,microns_y, filterfxn_abs);
title('Filter Function');
xlabel('Microns');
ylabel('Microns');

%Deblur
ftpic_shift = fftshift(fft2(Shiftedgray));
fudgefactor = 0.1;
f = filterfxn_abs./((abs(filterfxn).^2) + fudgefactor);
ftpic_fr = ftpic_shift.*f;
iftpic = ifft2(ifftshift(ftpic_fr));
iftpic_real = real(iftpic);
iftpic_rabs = abs(iftpic_real);

FigureC4 = figure('Name', 'Defocused Shifted');
colormap(gray(256));
imagesc(microns_x,microns_y, Shiftedgray);
title('Defocused Shifted Image');
xlabel('Microns');
ylabel('Microns');

FigureC5 = figure('Name', 'Deblurred Defocused Shifted');
colormap(gray(256));
imagesc(microns_x,microns_y, iftpic_rabs);
title('Deblurred Defocused Shifted Image');
xlabel('Microns');
ylabel('Microns');

