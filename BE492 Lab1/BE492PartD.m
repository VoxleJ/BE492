%BE 492 Part D
partDnormal =  importdata('PartD_normal.txt');
partDtight450ms = importdata('PartD_tight_450ms.txt');
partDtight900ms = importdata('PartD_tight_900ms.txt');

a2 = plot(partDtight450ms(:,1),partDtight450ms(:,2), 'Linewidth', 1, 'Marker', '+', 'MarkerIndices', 1:10:2048);

hold on
a1 = plot(partDnormal(:,1),partDnormal(:,2),'Linewidth', 3, 'LineStyle', '-.');

hold on
a3 = plot(partBwatertabdelim(:,1),partBwatertabdelim(:,2), 'Linewidth', 2, 'LineStyle', '- -');

legend([a1, a2, a3], ["Normal", "Rubber Band 450 ms", "Rubber Band 900ms"]);
xlabel('Wavelength nm');
ylabel('Intensity');
axis([335 1050 0 3600]);