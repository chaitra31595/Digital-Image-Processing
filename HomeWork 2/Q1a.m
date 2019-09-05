f = fopen('Tiger.raw','r');
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

grey_image=image;
figure(1);
imshow(uint8(RGB_ori));
title('Original Image');

K=2; % K=1 Prewitt ,K=2 Sobel , K=sqrt(2) Frei-Chen mask
Gx=(1/(K+2))*[-1 0 1;-K 0 K;-1 0 1]; % Normalize it 
Gy=(1/(K+2))*[1 K 1; 0 0 0;-1 -K -1]; %Normalize it 
n=1;
%extend boundary
Image=grey_image;
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:height,1:width);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
extended_grey_image=Boundary_extended_image;
filter_size=3;
Gr=zeros(height,width);
Gc=zeros(height,width);
for i=n+1:height+n
    for j=1+n:width+n
        for k=-1:1
            for l=-1:1
               Gr(i-n,j-n)=Gr(i-n,j-n)+Gx(((filter_size+1)/2)+k,((filter_size+1)/2)+l)*extended_grey_image(i+k,j+l);
               Gc(i-n,j-n)=Gc(i-n,j-n)+Gy(((filter_size+1)/2)+k,((filter_size+1)/2)+l)*extended_grey_image(i+k,j+l);
            end
        end
    end
end

normalized_Gr=((Gr-min(min(Gr)))./(max(max(Gr))-min(min(Gr)))).*255;
normalized_Gc=((Gc-min(min(Gc)))./(max(max(Gc))-min(min(Gc)))).*255;
figure(2);
imshow(uint8(normalized_Gr));
title('Normalized Gr : x gradient');
figure(3);
imshow(uint8(normalized_Gc));
title('Normalized Gc : y gradient');

for i=1:height
    for j=1:width
        Gradient_map(i,j)=sqrt((Gr(i,j)^2)+(Gc(i,j)^2));
    end
end
normalized_Gradient_map=((Gradient_map-min(min(Gradient_map)))./(max(max(Gradient_map))-min(min(Gradient_map)))).*255;
figure(4);
imshow(uint8(normalized_Gradient_map));
title('Normalized Gradient map');

normalized_Gradient_map=double(uint8(normalized_Gradient_map));
Hist=zeros(1,256);
for i=1:height
    for j=1:width
        for k=0:255
            if(normalized_Gradient_map(i,j)==k)
             Hist(1,k+1)=Hist(1,k+1)+1;
            end
        end
    end
end
Probability=Hist/(height*width);
CDF(1,1)=Probability(1,1);
for i=2:256
    CDF(1,i)=CDF(1,i-1)+Probability(1,i);
end
figure(5);
stem(Hist);
title('Histogram of Gradient map');
xlabel('Intensity Scale');
ylabel('Frequency/Count');
figure(6);
stem(CDF);
xlabel('Intensity Scale');
ylabel('CDF');
title('Cumulative Distributive Function of Gradient map');
percentage_edge_required=0.85;

for k=1:256
    if(percentage_edge_required < CDF(1,k))
       threshold=k-1;  
       break;
    end
end

for i=1:height
    for j=1:width
       if(normalized_Gradient_map(i,j) > threshold )
           edge_map(i,j)=0; 
       else
           edge_map(i,j)=255;
       end
    end
end

figure(7);
imshow(uint8(edge_map));
title('Threshold = 85%');
            


