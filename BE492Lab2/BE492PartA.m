%Part A
close all;

%load Data
partAwaterBG =  importdata('PartA_darkwater_background.txt');
partAwater = importdata('PartA_water.txt');
partAfluorescein = importdata('PartA_fluorescein.txt');
partAfluoresceinBG = importdata('PartA_fluorescein_background.txt');
partAfluoresceinSDE = importdata('PartA_fluoroscein_side.txt');

%Adjust Background
waterADJ = partAwater(:,2) - partAwaterBG(:,2);
fluorFWadj = partAfluorescein(:,2) - partAfluoresceinBG(:,2);
fluorSDadj = partAfluoresceinSDE(:,2) - partAfluoresceinBG(:,2);

%figureA1
figureA1 =  figure('Name', 'Forward Water and Fluorescein');

a1 = plot(partAwater(:,1), waterADJ, 'Marker', '+', 'LineWidth', 3,  'MarkerIndices', 1:10:2048);
hold on
a2 = plot(partAfluorescein(:,1), fluorFWadj);

xlabel('Wavelength (nm)');
ylabel('Intensity (AU)');
legend('Water', 'Fluorescein');
title('Background Corrected Spectra of Water and Fluorescein in the Forward Direction');


%figureA2 normalized excitation and emission
figureA2 = figure('Name', 'Fluorescein Excitation and Emission');
excitation_bl = -(log(abs(partAfluorescein(:,2))./ abs(partAwater(:,2))));
excitation_normal = excitation_bl .* 4500;
a3 = plot(partAfluorescein(:,1), excitation_normal);
hold on
a4 = plot(partAfluoresceinSDE(:,1), fluorSDadj .* 0.5);

xlabel('Wavelength (nm)');
ylabel('Intensity (AU)');
legend('Excitation', 'Emission');
title('Normalized Fluorescein Excitation and Emission');

