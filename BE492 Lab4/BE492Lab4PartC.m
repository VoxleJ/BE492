%Part C
RBConly40x = imread('05.bmp');
Mixed_1 = imread('06_1.bmp');
Mixed_2 = imread('06_2.bmp');
Mixed_3 = imread('06_3.bmp');
Mixed_4 = imread('06_4.bmp');
Mixed_5 = imread('06_5.bmp');
Mixed_6 = imread('06_6.bmp');
Mixed_7 = imread('06_7.bmp');
Mixed_8 = imread('06_8.bmp');
Mixed_9 = imread('06_9.bmp');


FigureC1 = figure('Name', '40x RBC only');
Gray40x = 0.2989*RBConly40x(:,:,1) + 0.5870*RBConly40x(:,:,2) + 0.1140*RBConly40x(:,:,3);
colormap(gray)
imagesc(Gray40x);
axis image
title('40x Image of Red Blood cells split into quadrants');
vline(325, 'k')
vline(650, 'k')
vline(975, 'k')
hline(250, 'k')
hline(500, 'k')
hline(750, 'k')
xlabel('Pixels');
ylabel('Pixels');

red = squeeze(RBConly40x(:,:,1));
green = squeeze(RBConly40x(:,:,2));
blue = squeeze(RBConly40x(:,:,3));
FigureC2 = figure('Name', 'Red Green Blue Comparison');
% subplot(3,1,1)
% colormap(gray)
% imagesc(red)
% axis image
% title('Red')
% subplot(3,1,2)
colormap(gray)   %Green is best
imagesc(green)
axis image
title('Green')
%Green is best
% subplot(3,1,3)
% colormap(gray)
% imagesc(blue)
% axis image
% title('Blue')
xlabel('Pixels');
ylabel('Pixels');

FigureC3 = figure('Name', 'Binarized Green');
binaryg = (green<100);
colormap(gray)
imagesc(binaryg)
axis image
title('Binarized 40x Green Component')
xlabel('Pixels');
ylabel('Pixels');

RBCarea = sum(sum(binaryg));
RBCpixarea = RBCarea/288;

%sequence of 9
Mixed_1gray = 0.2989*Mixed_1(:,:,1) + 0.5870*Mixed_1(:,:,2) + 0.1140*Mixed_1(:,:,3);
FigureC4 = figure('Name', 'Mixed RBC WBC Image 1');
imagesc(Mixed_1gray)
colormap(gray)
axis image
title('Mixed RBC WBC Image 1')
xlabel('Pixels');
ylabel('Pixels');


red_mx1 = squeeze(Mixed_1(:,:,1));
green_mx1 = squeeze(Mixed_1(:,:,2));
blue_mx1 = squeeze(Mixed_1(:,:,3));
% FigureC5 = figure('Name', 'Red Green Blue Comparison WBC/RBC');
% subplot(3,1,1)
% colormap(gray)
% imagesc(red) %Red is best for WBC
% axis image
% title('Red')
% subplot(3,1,2)
% colormap(gray)   %Green is best for RBC
% imagesc(green_mx1)
% axis image
% title('Green')
%Green is best
% subplot(3,1,3)
% colormap(gray)
% imagesc(blue)
% axis image
% title('Blue')
% xlabel('Pixels');
% ylabel('Pixels');

FigureC6 = figure('Name', 'Binarized White Blood Cells');
binaryr_mx1 = (red_mx1<104);
colormap(gray)
imagesc(binaryr_mx1)
axis image
title('Binarized White Blood Cells')
xlabel('Pixels');
ylabel('Pixels');

arear_mx1 = sum(sum(binaryr_mx1));
wbcparea = arear_mx1/8

FigureC7 = figure('Name', 'Binarized Red Blood Cells');
binaryg_mx1 = (green_mx1<102);
colormap(gray)
imagesc(binaryg_mx1)
axis image
title('Binarized Red Blood Cells')
xlabel('Pixels');
ylabel('Pixels');

areag_mx1 = sum(sum(binaryg_mx1));
rbc_num = areag_mx1/(RBCpixarea/4)

%repeat img 2-9
for ii = 1:9
    imgname = ['06_' num2str(ii) '.bmp'];
    img_ii = imread(imgname);
    red_ii = squeeze(img_ii(:,:,1));
    green_ii = squeeze(img_ii(:,:,2));
    blue_ii = squeeze(img_ii(:,:,3));
    binaryr_ii = (red_ii<104);
    binaryg_ii = (green_ii<100);
    WBCtotarea(ii) = sum(sum(binaryr_ii));
    WBCcount(ii) = WBCtotarea(ii)/wbcparea;
    RBCtotarea(ii) = sum(sum(binaryg_ii));
    RBCcount(ii) = RBCtotarea(ii)/(RBCpixarea/4);
end

avgWBCcount = sum(WBCcount)/9
stdevWBCcount = std(WBCcount)
avgRBCcount = sum(RBCcount)/9
stdevRBCcount = std(RBCcount)

%per square mm (0.5 demagnifier) pixel size 3.6
pareamicron_RBC = (RBCpixarea/4)*3.6/5
pareamm_RBC = pareamicron_RBC * 10^(-6);
persqmm_RBC = avgRBCcount/pareamm_RBC
persqmm_RBC_std = stdevRBCcount/pareamm_RBC

pareamicron_WBC = (wbcparea)*3.6/5
pareamm_WBC = pareamicron_WBC * 10^(-6);
persqmm_WBC = avgWBCcount/pareamm_WBC
persqmm_WBC_std = stdevWBCcount/pareamm_WBC

