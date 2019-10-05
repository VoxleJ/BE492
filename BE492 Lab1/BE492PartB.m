%BE 492 Part B
partBsideskimilk =  importdata('PartB_side_skimilk.txt');
partBskimilk = importdata('PartB_skimilk.txt');
partBwatertabdelim = importdata('PartB_water_tabdelim.txt');

%importing backgrounds, unused due to shiftcorrect error below
%partBsidebackground = importdata('PartB_side_background.txt');
%partBskimilkbackground = importdata('PartB_skimilk_background.txt');
%partBwaterbackground = importdata('PartB_water_background.txt');

%shiftcorrect = partBskimilk(:,2) - partBskimilkbackground(:,2);
%this provides negative numbers, does not make sense to delete background
%as such

a2 = plot(partBskimilk(:,1),partBskimilk(:,2), 'Linewidth', 1, 'Marker', '+', 'MarkerIndices', 1:10:2048);
%alternative plot method dependent on import method (using matlab tool or
%import read)
%a1 = plot(PartBsideskimilk.VarName1, PartBsideskimilk.VarName2, 'Linewidth', 2, 'Marker', '+', 'MarkerIndices', 1:10:2048);
hold on
a1 = plot(partBsideskimilk(:,1),partBsideskimilk(:,2),'Linewidth', 3, 'LineStyle', '-.');
%a2 = plot(PartBskimilk.VarName1, PartBskimilk.VarName2, 'Linewidth', 3, 'LineStyle', '-.');
hold on

%a3 = plot(PartBwatertabdelim.VarName1, PartBwatertabdelim.VarName2,'Linewidth', 2, 'LineStyle', '- -');
a3 = plot(partBwatertabdelim(:,1),partBwatertabdelim(:,2), 'Linewidth', 2, 'LineStyle', '- -');
legend([a1, a2, a3], ["Side Skim Milk", "Skim Milk", "Water"]);
xlabel('Wavelength nm');
ylabel('Intensity');
axis([335 1050 0 3600]);


%To calculate average
%create a weight by multiplying each column then dividing by absorbance
skimilkavg = sum(partBskimilk(:,2).*partBskimilk(:,1))/sum(partBskimilk(:,2));
sideskimilkavg = sum(partBsideskimilk(:,2).*partBsideskimilk(:,1))/sum(partBsideskimilk(:,2));
wateravg = sum(partBwatertabdelim(:,2).*partBwatertabdelim(:,1))/sum(partBwatertabdelim(:,2));