%Part B

bfield = imread('01.bmp');
oblique_a = imread('02.bmp');
oblique_b = imread('03.bmp');
dfield = imread('04.bmp');

FigureB1 = figure('Name', '10x Brightfield');
imagesc(bfield);
axis image
title('10x Brightfield of Cheek Cells');
xlabel('Pixels');
ylabel('Pixels');

FigureB2 = figure('Name', '10x Oblique Direction A');
imagesc(oblique_a);
axis image
title('10x Oblique Illumination of Cheek Cells Direction A');
xlabel('Pixels');
ylabel('Pixels');

FigureB3 = figure('Name', '10x Oblique Direction B');
imagesc(oblique_b);
axis image
title('10x Oblique Illumination of Cheek Cells Direction B');
xlabel('Pixels');
ylabel('Pixels');

FigureB4 = figure('Name', '10x Darkfield of Cheek Cells');
imagesc(dfield);
axis image
title('10x Darkfield of Cheek Cells');
xlabel('Pixels');
ylabel('Pixels');