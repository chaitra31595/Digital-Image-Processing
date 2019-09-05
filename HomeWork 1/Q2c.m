pepper_ori=readraw1("pepper_dark.raw");
pepper_shot_noise=readraw1("pepper_dark_noise.raw");
pepper_ori=pepper_ori';
pepper_shot_noise=pepper_shot_noise';
N=256;
for i=1:N
    for j=1:N
      additive_gaussian_noise_image(i,j)=2*sqrt(pepper_shot_noise(i,j)+(3/8));
    end
end
width=N;
height=N;
Image=additive_gaussian_noise_image;
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
sigma=1;
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_gaussian(i-n,j-n)=0;
         m=1;
         acc=0;
         for k=(-1*(filter_size-1)/2):((filter_size-1)/2)
             t=1;
             for l=(-1*(filter_size-1)/2):((filter_size-1)/2)
                 weight(m,t)=(1/(2*pi*(sigma.^2)))*exp(-((k).^2+(l).^2)/(2*(sigma.^2)));
                 acc=acc+weight(m,t);
                 Denoised_gaussian(i-n,j-n)=Denoised_gaussian(i-n,j-n)+weight(m,t)*(Boundary_extended_image(i+k,j+l));
                 t=t+1;
             end
             m=m+1;
         end
         Denoised_gaussian(i-n,j-n)=(1/acc)*Denoised_gaussian(i-n,j-n);
     end
end

for i=1:N
    for j=1:N
      unbiased_inverse_transform_gaussian(i,j)=(Denoised_gaussian(i,j)/2).^2-(1/8);
      biased_inverse_transform_gaussian(i,j)=(Denoised_gaussian(i,j)/2).^2-(3/8);
      unbiased_inverse_transform_bm3d(i,j)=(y_est(i,j)*256/2).^2-(1/8);  % BMD outputs y_est as normalized value 
      biased_inverse_transform_bm3d(i,j)=(y_est(i,j)*256/2).^2-(3/8);  % BMD outputs y_est as normalized value
    end
end

a=0;b=0;c=0;d=0;
for i=1:N
    for j=1:N
        a=a+(1/(N.^2))*(unbiased_inverse_transform_gaussian(i,j)-pepper_ori(i,j)).^2;
        b=b+(1/(N.^2))*(biased_inverse_transform_gaussian(i,j)-pepper_ori(i,j)).^2;
        c=c+(1/(N.^2))*(unbiased_inverse_transform_bm3d(i,j)-pepper_ori(i,j)).^2;
        d=d+(1/(N.^2))*(biased_inverse_transform_bm3d(i,j)-pepper_ori(i,j)).^2;
    end
end
PSNR=[10*log10(255.^2/a) 10*log10(255.^2/b) 10*log10(255.^2/c) 10*log10(255.^2/d)];

figure(1)
imshow(uint8(pepper_shot_noise));
title("Pepper shot noise");
figure(2)
imshow(uint8(pepper_ori));
title("Original Pepper image");
figure(3)
imshow(uint8(biased_inverse_transform_gaussian));
title("Biased gaussian inverse tranform");
figure(4)
imshow(uint8(unbiased_inverse_transform_gaussian));
title("Unbiased gaussian inverse tranform");
figure(5)
imshow(uint8(biased_inverse_transform_bm3d));
title("Biased BM3D inverse tranform");
figure(6)
imshow(uint8(unbiased_inverse_transform_bm3d));
title("Unbiased BM3D inverse tranform");

