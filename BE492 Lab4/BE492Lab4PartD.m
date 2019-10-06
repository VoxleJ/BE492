%Part D
v = VideoReader('07.avi');
vid = read(v);
[y, x, c, f] = size(vid);

frame1 = squeeze(vid(:,:,:,1));
frame1gray = 0.2989*frame1(:,:,1)+0.5870*frame1(:,:,2)+0.1140*frame1(:,:,3);
frameMid = squeeze(vid(:,:,:,round(f/2)));
frameMidgray = 0.2989*frameMid(:,:,1)+0.5870*frameMid(:,:,2)+0.1140*frameMid(:,:,3);

FigureD1 = figure('Name', 'Frame 1');
colormap(gray)
imagesc(frame1gray)
axis image
title('Frame 1')
xlabel('Pixels')
ylabel('Pixels')

FigureD2 = figure('Name', 'Midpoint Frame');
colormap(gray)
imagesc(frameMidgray)
axis image
title('Midpoint Frame (N=52)')
xlabel('Pixels')
ylabel('Pixels')

redf1 = squeeze(frame1(:,:,1));
greenf1 = squeeze(frame1(:,:,2));
bluef1 = squeeze(frame1(:,:,3));
FigureD3 = figure('Name', 'Binarization Color Chooser');
subplot(3,1,1)
colormap(gray)
imagesc(redf1)
axis image
title('Red')
subplot(3,1,2)
colormap(gray)
imagesc(greenf1)
axis image
title('Green')
subplot(3,1,3)
colormap(gray)
imagesc(bluef1)
axis image
title('Blue')
xlabel('Pixels');
ylabel('Pixels');
%Green is still best

FigureD4 = figure ('Name', 'Binarized Frame 1');
colormap(gray)
bframe1 = (greenf1<100);
imagesc(bframe1)
axis image
title('Binarized Frame 1')
xlabel('Pixels');
ylabel('Pixels');

FigureD5 = figure('Name', 'Binarized Midpoint Frame (N=52)');
colormap(gray)
greenmid = frameMid(:,:,2);
bframeMid = (greenmid<100);
imagesc(bframeMid)
axis image
title('Binarized Midpoint Frame (N=52)')
xlabel('Pixels');
ylabel('Pixels');

fftA = fftshift(fft2(bframe1));
fftB = fftshift(fft2(bframeMid));
fftC = conj(fftA).* fftB;
imgcorr = ifftshift(ifft2(fftC));
abscor = abs(imgcorr);

FigureD6 = figure('Name', 'Correlation between Frame 1 and Frame 52');
colormap(flipud(gray)) %flipped for easier distinction
imagesc(abscor)
axis image
title('Correlation Between Frame 1 and Frame 52')
xlabel('Pixels');
ylabel('Pixels');

[max_x, x] = max(max(abscor, [],1));
[max_y, y] = max(max(abscor,[],2));
[y_size, x_size] = size(abscor);
x_pos = x - (x_size/2 + 1)
y_pos = y -(y_size/2 + 1)

delx = zeros(1,f);
dely = zeros(1,f);

for jj = 1:f
    framejj = squeeze(vid(:,:,:,jj));
    greenjj = framejj(:,:,2);
    bframejj = (greenjj<100);
    fftBjj = fftshift(fft2(bframejj));
    fftCjj = conj(fftA).*fftBjj;
    imgcorrjj = ifftshift(ifft2(fftCjj));
    abscorjj = abs(imgcorrjj);
    [max_x, x] = max(max(abscorjj,[],1));
    [max_y, y] = max(max(abscorjj,[],2));
    [y_size, x_size] = size(abscorjj);
    delx(jj) = x - (x_size/2 + 1);
    dely(jj) = y -(y_size/2 + 1);
end

FigureD7 = figure('Name', 'Change in x and y positions');
plot(delx, 'LineWidth',2)
hold on
plot(dely, 'LineWidth',3)
title('Change in X and Y positions')
legend('\Delta x', '\Delta y')
xlabel('Frame Number')
ylabel('Displacement in pixels')

%% Part E
writer = VideoWriter('new07.avi');
open(writer)
for kk = 1:f-1
    framkk = squeeze(vid(:,:,:,kk));
    frame_shift = circshift(framkk, [dely(kk), delx(kk), 0]);
    writeVideo(writer,frame_shift);
end
close(writer)

nv = VideoReader('new07.avi');
nvid = read(nv);
nframe1 = squeeze(nvid(:,:,:,1));
nframe1gray = 0.2989*nframe1(:,:,1)+0.5870*nframe1(:,:,2)+0.1140*nframe1(:,:,3);
nframeMid = squeeze(nvid(:,:,:,round(f/2)));
nframeMidgray = 0.2989*nframeMid(:,:,1)+0.5870*nframeMid(:,:,2)+0.1140*nframeMid(:,:,3);

FigureE1 = figure('Name', 'Stabilized Frame 1');
colormap(gray)
imagesc(nframe1gray)
title('Stabilized Frame 1');
xlabel('Pixels');
ylabel('Pixels');

FigureE2 = figure('Name', 'Stabilized Frame 52');
colormap(gray)
imagesc(nframeMidgray)
title('Stabilized Frame 52');
xlabel('Pixels');
ylabel('Pixels');

greennf1 = squeeze(nframe1(:,:,2));
nbframe1 = (greennf1<100);
greennmid = nframeMid(:,:,2);
nbframeMid = (greennmid<100);
nfftA = fftshift(fft2(nbframe1));
nfftB = fftshift(fft2(nbframeMid));
nfftC = conj(nfftA).* fftB;
nimgcorr = ifftshift(ifft2(nfftC));
nabscor = abs(nimgcorr);

[nmax_x, nx] = max(max(nabscor, [],1));
[nmax_y, ny] = max(max(nabscor,[],2));
[ny_size, nx_size] = size(nabscor);
nx_pos = nx - (x_size/2 + 1)
ny_pos = ny -(y_size/2 + 1)

ndelx = zeros(1,f);
ndely = zeros(1,f);

for zz = 1:f-1
    framezz = squeeze(nvid(:,:,:,zz));
    greenzz = framezz(:,:,2);
    nbframezz = (greenzz<100);
    fftBzz = fftshift(fft2(nbframezz));
    fftCzz = conj(nfftA).*fftBzz;
    imgcorrzz = ifftshift(ifft2(fftCzz));
    abscorzz = abs(imgcorrzz);
    [nmax_x, nx] = max(max(abscorzz,[],1));
    [nmax_y, ny] = max(max(abscorzz,[],2));
    [ny_size, nx_size] = size(abscorzz);
    ndelx(zz) = nx - (nx_size/2 + 1);
    ndely(zz) = ny -(ny_size/2 + 1);
end

FigureE3 = figure('Name', 'Stabilized Change in x and y positions');
plot(ndelx, 'LineWidth',2)
hold on
plot(ndely, 'LineWidth',3)
title('Stabilized Change in X and Y positions')
legend('\Delta x', '\Delta y')
xlabel('Frame Number')
ylabel('Displacement in pixels')