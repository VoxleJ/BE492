%BE 492 Part C
partCphenolred =  importdata('PartC_phenolRed.txt');
partCphenolredrotated = importdata('PartC_phenolRed_rotated.txt');
partCphenolred1ul = importdata('PartC_phenolRed_1ulVinegar.txt');
partCphenolred2ul = importdata('PartC_phenolRed_2ulVinegar.txt');
partCphenolred3ul = importdata('PartC_phenolRed_3ulVinegar.txt');
partCwater = importdata('PartC_water.txt');


a2 = plot(partCphenolredrotated(:,1),partCphenolredrotated(:,2), 'Linewidth', 1, 'Marker', '+', 'MarkerIndices', 1:10:2048);
%alternative plot method dependent on import method (using matlab tool or
%import read)
%a1 = plot(PartBsideskimilk.VarName1, PartBsideskimilk.VarName2, 'Linewidth', 2, 'Marker', '+', 'MarkerIndices', 1:10:2048);
hold on
a1 = plot(partCphenolred(:,1),partCphenolred(:,2),'Linewidth', 3, 'LineStyle', '-.');
%a2 = plot(PartBskimilk.VarName1, PartBskimilk.VarName2, 'Linewidth', 3, 'LineStyle', '-.');
hold on

%a3 = plot(PartBwatertabdelim.VarName1, PartBwatertabdelim.VarName2,'Linewidth', 2, 'LineStyle', '- -');
a3 = plot(partCwater(:,1),partCwater(:,2), 'Linewidth', 2, 'LineStyle', '- -');
hold on

legend([a1, a2, a3], ["Long", "Short", "Water"]);
xlabel('Wavelength nm');
ylabel('Intensity');
axis([335 1050 0 3600]);

hold off



%for mu_a(L) graphs
%add small offset to water spectra
%divide phenol red spectra by offset water spectra
%take natural log

wateroffset = partCwater(:,2) + 0.01;

figure2 = figure('Name', 'Phenol Red Short and Long');
phenolredplot=-log(partCphenolred(:,2)./wateroffset);
phenolredrotatedplot=-log(partCphenolredrotated(:,2)./wateroffset);
b1 = plot(partCphenolred(:,1), phenolredplot);
hold on
b2 = plot(partCphenolred(:,1), phenolredrotatedplot);
hold off
xlabel('Wavelength nm');
legend([b1 b2], ["Long Path", "Short Path"]);

figure3=figure('Name', 'Phenol Red and Vinegar');
phenolred1ulplot = -log(partCphenolred1ul(:,2)./wateroffset);
c1 = plot(partCphenolred(:,1), phenolred1ulplot);
hold on
phenolred1u2plot = -log(partCphenolred2ul(:,2)./wateroffset);
c2 = plot(partCphenolred(:,1), phenolred1u2plot);
hold on
phenolred1u3plot = -log(partCphenolred3ul(:,2)./wateroffset);
c3 = plot(partCphenolred(:,1), phenolred1u3plot);
hold on
xlabel('Wavelength nm');
legend([c1 c2 c3], ["1uL", "2uL", "3uL"]);



