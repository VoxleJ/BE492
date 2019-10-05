%Part C
close all;

partAwaterBG =  importdata('PartA_darkwater_background.txt');
partAwater = importdata('PartA_water.txt');
%partAfluorescein = importdata('PartA_fluorescein.txt');
partAfluoresceinBG = importdata('PartA_fluorescein_background.txt');
partAfluoresceinSDE = importdata('PartA_fluoroscein_side.txt');
partB3BG = importdata('PartB3_background.txt');
%partB4_1drop = importdata('PartB4_1drop.txt');
%partB4_2drop = importdata('PartB4_2drop.txt');
%partB5_watermilk2drop = importdata('PartB5_watermilk_2drop.txt');
partB_BG = importdata('PartB_background.txt');
%partB_mystery = importdata('PartB_mystery.txt');
partB_Rhod = importdata('PartB_Rhodamine_side.txt');
partC_BG = importdata('PartC_background.txt');
partC_mystery = importdata('PartC_mystery.txt');
partC_blustery = importdata('PartC_mysteryblue.txt');
partC_FC = importdata('food_color_spectrum.txt');

%adjustBG

partCmysteryADJ = partC_mystery(:,2) - partC_BG(:,2);
partCblusteryADJ = partC_blustery(:,2) - partC_BG(:,2);

%Food Color scaling for ease
partCFCscale = partC_FC(:,2) * 1700;

%Figure C1
figureC1 = figure('Name', 'Mystery, Blue + Mystery, FC');
c3 = plot(partC_FC(:,1), partCFCscale);
hold on
c4 = plot(partC_FC(:,1), partCmysteryADJ);
hold on
c5 = plot(partC_FC(:,1), partCblusteryADJ);

xlabel('Wavelength (nm)');
ylabel('Intensity (AU)');
legend('Methylene Blue (Normalized)', 'Mystery Solution', 'Mystery Solution with Methelyne Blue')
%Question Calcs
bluefxn = @(c)norm(abs((exp(-(c(3)*partCFCscale))) .*(c(1)*partAfluoresceinSDE(:,2) + c(2)*partB_Rhod(:,2))) - partCblusteryADJ)^2;
c = fminsearch(bluefxn, [0,0,0]);
smodelblufxn = (exp(-(c(3)*partCFCscale)) .* (c(1) * partAfluoresceinSDE(:,2) + c(2)*partB_Rhod(:,2)));


%Figure C2
figureC2 =  figure('Name', 'Model, Blustery');
c6 = plot(partC_FC(:,1), smodelblufxn);
hold on
c7 = plot(partC_FC(:,1), partCblusteryADJ);

xlabel('Wavelength (nm)');
ylabel('Intensity (AU)');
legend('S_m_o_d_e_l', 'S_d_a_t_a')
title('Mystery Solution with Methylene Blue and Least Squares Regression Model');




