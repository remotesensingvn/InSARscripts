%plot ifg network for SBAS ISCE
%28 April 2021 - Minh
bperp = importdata('tab_bperp_32all');
igram_pair = importdata('tab_pair');

date2 = datetime(igram_pair.textdata(2:end,3),'InputFormat','yyyyMMdd'); 
date1 = datetime(igram_pair.textdata(2:end,4),'InputFormat','yyyyMMdd');

epoch = datetime(bperp(:,1),'ConvertFrom','yyyymmdd');
spatio_bsline = bperp(:,2);

for i = 1 : length(date2)
   ind = find(date2(i) == epoch(:));
   date2_bperp(i) = spatio_bsline(ind);
end
for i = 1 : length(date1)
   ind = find(date1(i) == epoch(:));
   date1_bperp(i) = spatio_bsline(ind);
end

figure
    hold on
    scatter(epoch,spatio_bsline,'Marker','o','MarkerFaceColor','k');
    for i = 1 : 550
       plot([date2(i) date1(i)],[date2_bperp(i) date1_bperp(i)],'k'); 
    end
    scatter(epoch,spatio_bsline,'Marker','o','MarkerFaceColor','k');
    ylabel('Spatial Baseline (m)');
    xlabel('Temporal Baseline');
    box on
    
%calculate average spatial & temporal baseline
avg_spat = mean(abs(date2_bperp - date1_bperp));
avg_temp = mean(datenum(date2)-datenum(date1));