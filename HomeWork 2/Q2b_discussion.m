Image=readraw('bridge.raw');
imshow(uint8(Image));
[height, width]=size(Image);
F=Image;
F_cap=zeros(height+2,width+2);
F_cap(2:height+1,2:width+1)=F;
MSE=zeros(1,3);
T=127;
Floyd=(1/16)*[0 0 0;0 0 7;3 5 1];
for i=2:height+1 
   for j=2:width+1;
           if(F_cap(i,j)>T)
               b(i-1,j-1)=255;
           else
               b(i-1,j-1)=0;
           end
           e=F_cap(i,j)-b(i-1,j-1);
           for k=-1:1
               for l=-1:1
                   F_cap(i+k,j+l)=F_cap(i+k,j+l)+Floyd(2+k,2+l)*e;
               end
           end
     MSE(1,1)=MSE(1,1)+(1/(height*width))*((F(i-1,j-1)-b(i-1,j-1)).^2);
   end
end
PSNR(1,1)=10*log10(255.^2/MSE(1,1));
figure(2)
imshow(uint8(b));
title('Floyd-Steinberg - Raster Scanning');

F_cap=zeros(height+4,width+4);
F_cap(3:height+2,3:width+2)=F;
JJN=(1/48)*[0 0 0 0 0;0 0 0 0 0;0 0 0 7 5;3 5 7 5 3; 1 3 5 3 1];
for i=3:height+2 
   for j=3:width+2;
           if(F_cap(i,j)>T)
               b(i-2,j-2)=255;
           else
               b(i-2,j-2)=0;
           end
           e=F_cap(i,j)-b(i-2,j-2);
           for k=-2:2
               for l=-2:2
                   F_cap(i+k,j+l)=F_cap(i+k,j+l)+JJN(3+k,3+l)*e;
               end
           end
     MSE(1,2)=MSE(1,2)+(1/(height*width))*((F(i-2,j-2)-b(i-2,j-2)).^2);
   end
end
figure(3);
PSNR(1,2)=10*log10(255.^2/MSE(1,2));
imshow(uint8(b));
title('JJN - Raster Scanning');


F_cap=zeros(height+4,width+4);
F_cap(3:height+2,3:width+2)=F;
Stucki=(1/42)*[0 0 0 0 0;0 0 0 0 0;0 0 0 8 4;2 4 8 4 2; 1 2 4 2 1];
for i=3:height+2 
   for j=3:width+2;
           if(F_cap(i,j)>T)
               b(i-2,j-2)=255;
           else
               b(i-2,j-2)=0;
           end
           e=F_cap(i,j)-b(i-2,j-2);
           for k=-2:2
               for l=-2:2
                   F_cap(i+k,j+l)=F_cap(i+k,j+l)+Stucki(3+k,3+l)*e;
               end
           end
     MSE(1,3)=MSE(1,3)+(1/(height*width))*((F(i-2,j-2)-b(i-2,j-2)).^2);
   end
end
figure(4);
PSNR(1,3)=10*log10(255.^2/MSE(1,3));
imshow(uint8(b));
title('Stucki - Raster Scanning');