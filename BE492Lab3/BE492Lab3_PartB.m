%BE492 Lab3 Part B
close all;

pb4xp = imread('01_B1.bmp');
pb10xp = imread('02_B2.bmp');
pb40xp = imread('03_B2.bmp');

%Grayscale Conversion using NTSC standards
pb4xpgray = 0.2989*pb4xp(:,:,1) + 0.5870*pb4xp(:,:,2) + 0.1140*pb4xp(:,:,3);
pb10xpgray = 0.2989*pb10xp(:,:,1) + 0.5870*pb10xp(:,:,2) + 0.1140*pb10xp(:,:,3);
pb40xpgray = 0.2989*pb40xp(:,:,1) + 0.5870*pb40xp(:,:,2) + 0.1140*pb40xp(:,:,3);

%Camera Size
pb4xp_size = size(pb4xpgray);
pb10xp_size = size(pb10xpgray);
pb40xp_size = size(pb40xpgray);

%Pixel Size Scale
%num of pixels * pixel size / magnification effective

pb4xpmicrons_x = [0 ((1280 * 3.6)/(0.5*4))];
pb4xpmicrons_y = [0 ((1024 * 3.6)/(0.5*4))];

pb10xpmicrons_x = [0 ((1280 * 3.6)/(0.5*10))];
pb10xpmicrons_y = [0 ((1024 * 3.6)/(0.5*10))];

pb40xpmicrons_x = [0 ((1280 * 3.6)/(0.5*40))];
pb40xpmicrons_y = [0 ((1024 * 3.6)/(0.5*40))];

xsize = 1280;
ysize = 1024;

FigureB1 = figure('Name', '4x Image NTSC Standard');
colormap(gray(256));
imagesc(pb4xpmicrons_x,pb4xpmicrons_y, pb4xpgray);
title('NTSC Standard Grayscaled 4x Magnification');
xlabel('Width of sample (microns)');
ylabel('Length of sample (microns)');

FigureB2 = figure('Name', '10x Image NTSC Standard');
colormap(gray(256));
imagesc(pb10xpmicrons_x,pb10xpmicrons_y, pb10xpgray);
title('NTSC Standard Grayscaled 10x Magnification');
xlabel('Width of sample (microns)');
ylabel('Length of sample (microns)');

FigureB3 = figure('Name', '40x Image NTSC Standard');
colormap(gray(256));
imagesc(pb40xpmicrons_x,pb40xpmicrons_y, pb40xpgray);
title('NTSC Standard Grayscaled 40x Magnification');
xlabel('Width of sample (microns)');
ylabel('Length of sample (microns)');

%Calculating Resolutions using lambda/2NA
pb4xp_res = (0.5E-6)/(2 * 0.1);
pb10xp_res = (0.5E-6)/(2 * 0.25);
pb40xp_res = (0.5E-6)/(2 * 0.65);

%Calculating Max light ray angle using NA=nsin(angle) n=1
pb4xp_angle =  asind(0.1);
pb10xp_angle = asind(0.25);
pb40xp_angle = asind(0.65);

FigureB4 = figure('Name' , 'ftpic abs');
ftpic = fftshift(fft2(pb4xpgray));
pb4xp_fftabs = abs(ftpic);
colormap(gray);
imagesc(pb4xp_fftabs);
zoom(FigureB4, 150);
title('150x Zoom of Absolute Value of FFT of 4x Image');
xlabel('K_x');
ylabel('K_y')

%Central Pixel
ftpic_size =  size(ftpic);
csize = ftpic_size(2)/2+1;
rsize = ftpic_size(1)/2+1;
pb4xp_sum = sum(sum(pb4xpgray));
central_pixel = ftpic(rsize,csize);
isequal(pb4xp_sum, central_pixel);

%45 Hz frequency filter
cutoff_freq4x = 45;
[x, y] = meshgrid(1:xsize, 1:ysize);
rr_pb4x = (x-xsize/2-1).^2+(y-ysize/2-1).^2 <= cutoff_freq4x^2;
filtered = ftpic.*rr_pb4x;
new_pb4xp = ifft2(ifftshift(filtered));
new_pb4xp_real = real(new_pb4xp);

FigureB5 = figure('Name', 'Circular Disk Filtered 45Hz');
colormap(gray(256));
imagesc(pb4xpmicrons_x, pb4xpmicrons_y, new_pb4xp_real);
title('Circular Disk Filtered Picture with Cutoff Frequency 45Hz');
xlabel('Microns');
ylabel('Microns');

%LineProfile
ftpic_ln = ftpic(ysize/2+1,:);
ftpic_ln_prof = abs(ftpic_ln)/max(abs(ftpic_ln));
rr_prof = rr_pb4x(ysize/2+1,:);
filt_cent = abs(filtered(ysize/2+1,:));
filt_cent_prof = abs(filt_cent)/max(abs(filt_cent));

FigureB6 = figure('Name', 'Line Profile B5');
plot(ftpic_ln_prof, 'LineWidth', 5);
hold on
plot(rr_prof, 'LineWidth', 3);
hold on
plot(filt_cent_prof, 'LineWidth', 4);
title('Normalized Line Profile with Cutoff Frequency 45Hz');
legend({'Filtered','Transform','Filtered Transform'});
xlabel('Pixel Number');
ylabel('Pixel Number');

%Frequency Filter 120Hz
cutoff_freq120x = 120;
[x, y] = meshgrid(1:xsize, 1:ysize);
rr_pb120x = (x-xsize/2-1).^2+(y-ysize/2-1).^2 <= cutoff_freq120x^2;
filtered120 = ftpic.*rr_pb120x;
new_pb120xp = ifft2(ifftshift(filtered120));
new_pb120xp_real = real(new_pb120xp);

FigureB7 = figure('Name', 'Filtered Picture with Cutoff Frequency 120Hz');
colormap(gray(256));
imagesc(pb4xpmicrons_x, pb4xpmicrons_y, new_pb120xp_real);
title('Circular Disk Filtered Picture with Cutoff Frequency 120Hz');
xlabel('Microns');
ylabel('Microns');

%Line Profile
ftpic_ln120 = ftpic(ysize/2+1,:);
ftpic_ln_prof120 = abs(ftpic_ln120)/max(abs(ftpic_ln120));
rr_prof120 = rr_pb120x(ysize/2+1,:);
filt_cent120 = abs(filtered120(ysize/2+1,:));
filt_cent_prof120 = abs(filt_cent120)/max(abs(filt_cent120));

FigureB8 = figure('Name', 'Normalized Line Profile 120Hz');
plot(ftpic_ln_prof120, 'LineWidth', 5);
hold on
plot(rr_prof120, 'LineWidth', 3);
hold on
plot(filt_cent_prof120, 'LineWidth', 4);
title('Normalized Line Profile with Cutoff Frequency 120Hz');
legend({'Filtered','Transform','Filtered Transform'});
xlabel('Pixel Number');
ylabel('Pixel Number');

%Gaussian Filter 45Hz
cutoff_freq4x = 45;
[x, y] = meshgrid(1:xsize, 1:ysize);
gg45 = exp(-((x-xsize/2-1).^2 + (y-ysize/2-1).^2/cutoff_freq4x^2));
filtered_45x = ftpic.* gg45;

new_pb45x_g = ifft2(ifftshift(filtered_45x));
new_pb45x_gr = real(new_pb45x_g);

FigureB9 = figure('Name', 'Gaussian Filtered 45Hz');
colormap(gray(256));
imagesc(pb4xpmicrons_x, pb4xpmicrons_y, new_pb45x_gr);
title('Gaussian Filtered Picture with Cutoff Frequency 45Hz');
xlabel('Microns');
ylabel('Microns');

%Lineprofile
ftpic_ln45g = ftpic(ysize/2+1,:);
ftpic_ln_prof45g = abs(ftpic_ln45g)/max(abs(ftpic_ln45g));
gg_prof45 = gg45(ysize/2+1,:);
filt_cent45g = abs(filtered_45x(ysize/2+1,:));
filt_cent_prof45g = abs(filt_cent45g)/max(abs(filt_cent45g));

FigureB10 = figure('Name', 'Normalized Gaussain Plot Profile 45Hz');
plot(ftpic_ln_prof45g, 'LineWidth', 5);
hold on
plot(gg_prof45, 'LineWidth', 3);
hold on
plot(filt_cent_prof45g, 'LineWidth', 4);
title('Normalized Gaussian Line Profile with Cutoff Frequency 45Hz');
legend({'Filtered','Transform','Filtered Transform'});
xlabel('Pixel Number');
ylabel('Pixel Number');


cutoff_freq120x = 120;
[x, y] = meshgrid(1:xsize, 1:ysize);
gg120 = exp(-((x-xsize/2-1).^2 + (y-ysize/2-1).^2/cutoff_freq120x^2));
filtered_120x = ftpic.* gg120;

new_pb120x_g = ifft2(ifftshift(filtered_120x));
new_pb120x_gr = real(new_pb120x_g);

FigureB11 = figure('Name', 'Gaussian Filtered 120Hz');
colormap(gray(256));
imagesc(pb4xpmicrons_x, pb4xpmicrons_y, new_pb120x_gr);
title('Gaussian Filtered Picture with Cutoff Frequency 120Hz');
xlabel('Microns');
ylabel('Microns');

%LineProfile
ftpic_ln120g = ftpic(ysize/2+1,:);
ftpic_ln_prof120g = abs(ftpic_ln120g)/max(abs(ftpic_ln120g));
gg_prof120 = gg120(ysize/2+1,:);
filt_cent120g = abs(filtered_120x(ysize/2+1,:));
filt_cent_prof120g = abs(filt_cent120g)/max(abs(filt_cent120g));

FigureB12 = figure('Name', 'Normalized Gaussain Plot Profile 120Hz');
plot(ftpic_ln_prof120g);
hold on
plot(gg_prof120);
hold on
plot(filt_cent_prof120g);
title('Normalized Gaussian Line Profile with Cutoff Frequency 120Hz');
legend({'Filtered','Transform','Filtered Transform'});
xlabel('Pixel Number');
ylabel('Pixel Number');


FileName=mfilename;
newbackup=sprintf('%s%s_backup.m',dataLoc,mfilename);
currentfile=strcat(FileName, '.m');
copyfile currentfile newbackup

