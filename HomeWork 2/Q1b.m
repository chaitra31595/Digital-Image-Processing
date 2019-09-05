f = fopen('Pig.raw','r');
Data=fread(f,[481*3 321],'*uint8');
fclose(f);
Red=double(Data(1:3:1441,:)');
Green=double(Data(2:3:1442,:)');
Blue=double(Data(3:3:1443,:)');
RGB_ori(:,:,1)=Red;
RGB_ori(:,:,2)=Green;
RGB_ori(:,:,3)=Blue;
[height,width]=size(Red);
for i=1:height
    for j=1:width
        image(i,j)=0.299*Red(i,j)+0.5870*Green(i,j)+0.1140*Blue(i,j);
    end
end
I=uint8(image)>127;
BW = edge(I,'canny',[0.45 0.5]);    %Change different thresholds
figure(1)
imshow((~BW)*255);
title(' Canny Edge Detector');

        