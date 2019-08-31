f = fopen('rose_color.raw','r');
Data=fread(f,[256*3 256],'*uint8');
fclose(f);
Red=Data(1:3:766,:)';
Green=Data(2:3:767,:)';
Blue=Data(3:3:768,:)';
RGB_ori(:,:,1)=Red;
RGB_ori(:,:,2)=Green;
RGB_ori(:,:,3)=Blue;
figure(1)
imshow(uint8(RGB_ori));


f = fopen('rose_color_noise.raw','r');
Data=fread(f,[256*3 256],'*uint8');
fclose(f);
Red=Data(1:3:766,:)';
Green=Data(2:3:767,:)';
Blue=Data(3:3:768,:)';
RGB_noise(:,:,1)=Red;
RGB_noise(:,:,2)=Green;
RGB_noise(:,:,3)=Blue;
figure(2)
imshow(uint8(RGB_noise));

Image=Red;
filter_size = 3;
N=256;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
width=N;
height=N;
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Red_plane=Boundary_extended_image;
Image=Green;
filter_size = 3;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Green_plane=Boundary_extended_image;
Image=Blue;
filter_size = 3;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Blue_plane=Boundary_extended_image;
for i=n+1:height+n
     for j=n+1:width+n
         a=1;
         for k=-((filter_size-1)/2):((filter_size+1)/2)-1
             for l=-((filter_size-1)/2):((filter_size+1)/2)-1
                 for m=1:(filter_size)^2
                     temp1(1,a)=Red_plane(i+k,j+l);
                     temp2(1,a)=Green_plane(i+k,j+l);
                     temp3(1,a)=Blue_plane(i+k,j+l);

                     a=a+1;
                 end
             end
         end
                     sorted1=sort(temp1);
                     sorted2=sort(temp2);
                     sorted3=sort(temp3);        
                     Denoised_impulse_Red(i-n,j-n)=sorted1(1,(filter_size.^2 - 1)/2);
                     Denoised_impulse_Green(i-n,j-n)=sorted2(1,(filter_size.^2 - 1)/2);
                     Denoised_impulse_Blue(i-n,j-n)=sorted3(1,(filter_size.^2 - 1)/2);

     end
end

RGB_impulse(:,:,1)=Denoised_impulse_Red;
RGB_impulse(:,:,2)=Denoised_impulse_Green;
RGB_impulse(:,:,3)=Denoised_impulse_Blue;
figure(3);
imshow(uint8(RGB_impulse));

Image=Denoised_impulse_Red;
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Denoised_impulse_Red_extended=Boundary_extended_image;
Image=Denoised_impulse_Green;
filter_size = 3;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Denoised_impulse_Green_extended=Boundary_extended_image;
Image=Denoised_impulse_Blue;
filter_size = 3;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Denoised_impulse_Blue_extended=Boundary_extended_image;





for i=n+1:height+n
     for j=n+1:width+n
         Denoised_uniform_Red(i-n,j-n)=0;
         Denoised_uniform_Green(i-n,j-n)=0;
         Denoised_uniform_Blue(i-n,j-n)=0;
         for k=-((filter_size-1)/2):((filter_size+1)/2)-1
             for l=-((filter_size-1)/2):((filter_size+1)/2)-1
                Denoised_uniform_Red(i-n,j-n)=Denoised_uniform_Red(i-n,j-n)+(1/(filter_size*filter_size))*(Denoised_impulse_Red_extended(i+k,j+l));
                Denoised_uniform_Green(i-n,j-n)=Denoised_uniform_Green(i-n,j-n)+(1/(filter_size*filter_size))*(Denoised_impulse_Green_extended(i+k,j+l));
                Denoised_uniform_Blue(i-n,j-n)=Denoised_uniform_Blue(i-n,j-n)+(1/(filter_size*filter_size))*(Denoised_impulse_Blue_extended(i+k,j+l));
             end
         end

     end
end

RGB_impulse_uniform(:,:,1)=Denoised_uniform_Red;
RGB_impulse_uniform(:,:,2)=Denoised_uniform_Green;
RGB_impulse_uniform(:,:,3)=Denoised_uniform_Blue;
figure(4);
imshow(uint8(RGB_impulse_uniform));

%

Image=Red;
filter_size = 3;
N=256;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
width=N;
height=N;
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Red_plane=Boundary_extended_image;
Image=Green;
filter_size = 3;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Green_plane=Boundary_extended_image;
Image=Blue;
filter_size = 3;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Blue_plane=Boundary_extended_image;


for i=n+1:height+n
     for j=n+1:width+n
         Denoised_uniform_Red(i-n,j-n)=0;
         Denoised_uniform_Green(i-n,j-n)=0;
         Denoised_uniform_Blue(i-n,j-n)=0;
         for k=-((filter_size-1)/2):((filter_size+1)/2)-1
             for l=-((filter_size-1)/2):((filter_size+1)/2)-1
                Denoised_uniform_Red(i-n,j-n)=Denoised_uniform_Red(i-n,j-n)+(1/(filter_size*filter_size))*(Red_plane(i+k,j+l));
                Denoised_uniform_Green(i-n,j-n)=Denoised_uniform_Green(i-n,j-n)+(1/(filter_size*filter_size))*(Green_plane(i+k,j+l));
                Denoised_uniform_Blue(i-n,j-n)=Denoised_uniform_Blue(i-n,j-n)+(1/(filter_size*filter_size))*(Blue_plane(i+k,j+l));
             end
         end

     end
end

RGB_uniform(:,:,1)=Denoised_uniform_Red;
RGB_uniform(:,:,2)=Denoised_uniform_Green;
RGB_uniform(:,:,3)=Denoised_uniform_Blue;
figure(5)
imshow(uint8(RGB_uniform));


Image=Denoised_uniform_Red;
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Denoised_uniform_Red_extended=Boundary_extended_image;
Image=Denoised_uniform_Green;
filter_size = 3;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Denoised_uniform_Green_extended=Boundary_extended_image;
Image=Denoised_uniform_Blue;
filter_size = 3;
n=(filter_size-1)/2;%number of extended rows/columns in contrast to original image
Boundary_extended_image(n+1:height+n,n+1:width+n)=Image(1:width,1:height);
for i=1:n
   Boundary_extended_image(i,n+1:width+n)=Image(n-i+2,1:width);
   Boundary_extended_image(n+height+i,n+1:width+n)=Image(height-i,1:width);
end
for j=1:n
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*n-j+2);
   Boundary_extended_image(:,width+n+j)=Boundary_extended_image(:,(n+width)-j);
end
Denoised_uniform_Blue_extended=Boundary_extended_image;

for i=n+1:height+n
     for j=n+1:width+n
         a=1;
         for k=-((filter_size-1)/2):((filter_size+1)/2)-1
             for l=-((filter_size-1)/2):((filter_size+1)/2)-1
                 for m=1:(filter_size)^2
                     temp1(1,a)=Denoised_uniform_Red_extended(i+k,j+l);
                     temp2(1,a)=Denoised_uniform_Green_extended(i+k,j+l);
                     temp3(1,a)=Denoised_uniform_Blue_extended(i+k,j+l);
                     a=a+1;
                 end
             end
         end
         sorted1=sort(temp1);
         sorted2=sort(temp2);
         sorted3=sort(temp3);        
         Denoised_uniform_impulse_Red(i-n,j-n)=sorted1(1,(filter_size.^2 - 1)/2);
         Denoised_uniform_impulse_Green(i-n,j-n)=sorted2(1,(filter_size.^2 - 1)/2);
         Denoised_uniform_impulse_Blue(i-n,j-n)=sorted3(1,(filter_size.^2 - 1)/2);
     end
end

RGB_uniofrm_impulse(:,:,1)=Denoised_uniform_impulse_Red;
RGB_uniform_impulse(:,:,2)=Denoised_uniform_impulse_Green;
RGB_uniform_impulse(:,:,3)=Denoised_uniform_impulse_Blue;
figure(6);
imshow(uint8(RGB_uniform_impulse));







