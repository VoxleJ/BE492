%Part B
close all;

partAwaterBG =  importdata('PartA_darkwater_background.txt');
partAwater = importdata('PartA_water.txt');
%partAfluorescein = importdata('PartA_fluorescein.txt');
partAfluoresceinBG = importdata('PartA_fluorescein_background.txt');
partAfluoresceinSDE = importdata('PartA_fluoroscein_side.txt');
partB3BG = importdata('PartB3_background.txt');
partB4_1drop = importdata('PartB4_1drop.txt');
partB4_2drop = importdata('PartB4_2drop.txt');
partB5_watermilk2drop = importdata('PartB5_watermilk_2drop.txt');
partB_BG = importdata('PartB_background.txt');
partB_mystery = importdata('PartB_mystery.txt');
partB_Rhod = importdata('PartB_Rhodamine_side.txt');

%First Model
purefluorSDE = partAfluoresceinSDE(:,2) - partB_BG(:,2);
pureRhod = partB_Rhod(:,2) - partB3BG(:,2);
model1 = @(a)norm(abs(a(1)*purefluorSDE + a(2)*pureRhod - partB_mystery(:,2)))^2;
a = fminsearch(model1, [0,0]);
smodel =  a(1)* purefluorSDE + a(2)* pureRhod;


%Figure B1
figureB1 = figure('Name', 'Model Plots Smodel Sdata');
b1 = plot(partB_BG(:,1), smodel);
hold on
b2 = plot(partB_BG(:,1), partB_mystery(:,2));
hold on
b3 = plot(partB_BG(:,1), a(1)* purefluorSDE);
hold on
b4 = plot(partB_BG(:,1), a(2)* pureRhod);

xlabel('Wavelength (nm)');
ylabel('Intensity (AU)');


%Calculate a1, a2, a3 with milk
model2 = @(b)norm(abs(b(1)*purefluorSDE + b(2)*pureRhod + b(3)*partB5_watermilk2drop(:,2)-partB_mystery(:,2)))^2;
b = fminsearch(model2, [0,0,0]);
smodel2 = b(1).* purefluorSDE + b(2) .*pureRhod +b(3) .* partB5_watermilk2drop(:,2);

%figure B2
figureB2 = figure('Name', 'Model w/ Milk and weighted Fluoroscein, Rhod B');
b5 = plot(partB_BG(:,1), smodel);
hold on
b6 = plot(partB_BG(:,1), b(1)*purefluorSDE);
hold on
b7 = plot(partB_BG(:,1), b(2)*pureRhod);
hold on
b8 = plot(partB_BG(:,1), b(3)*partB5_watermilk2drop(:,2));


xlabel('Wavelength (nm)');
ylabel('Intensity (AU)');

%Figure B3
figureB3 = figure('Name', 'Mystery, Milk, Model');
b9 = plot(partB_BG(:,1), smodel2);
hold on
b10 = plot(partB_BG(:,1), partB_mystery(:,2));

xlabel('Wavelength (nm)');
ylabel('Intensity (AU)');
legend('S_m_o_d_e_l', 'S_d_a_t_a')

%ReDerivingParameterVector or Matrix calcs
M = [purefluorSDE pureRhod, partB5_watermilk2drop(:,2)];
A = [b]
B = partB_mystery(:,2);

lsqrcheck = lsqr(M,B)
pinvcheck = pinv(M)*B