Imagedata=readraw("cat.raw");

%Extending the image boundary for the interpolating pixel values at the boundary for Bilinear and MHC
Boundary_extended_image(3:302,3:392)=Imagedata(1:300,1:390);
Boundary_extended_image(1,3:392)=Imagedata(1,1:390);
Boundary_extended_image(2,3:392)=Imagedata(2,1:390);
Boundary_extended_image(303,3:392)=Imagedata(299,1:390);
Boundary_extended_image(304,3:392)=Imagedata(300,1:390);
Boundary_extended_image(:,1)=Boundary_extended_image(:,3);
Boundary_extended_image(:,2)=Boundary_extended_image(:,4);
Boundary_extended_image(:,393)=Boundary_extended_image(:,391);
Boundary_extended_image(:,394)=Boundary_extended_image(:,392);

% Bilinear Demosaicing
%Computation of bilinear interpolation of all pixels in the image except at the boundary pixel 

for i=3:302
    for j=3:392
        if(mod((i-1),2)==0)
            if(mod((j-1),2)==0)
                 Green_bl(i-2,j-2)=Boundary_extended_image(i,j); 
                 Red_bl(i-2,j-2)=0.5*(Boundary_extended_image(i,j+1)+Boundary_extended_image(i,j-1));
                 Blue_bl(i-2,j-2)=0.5*(Boundary_extended_image(i+1,j)+Boundary_extended_image(i-1,j));
             else
                 Red_bl(i-2,j-2)=Boundary_extended_image(i,j); 
                 Blue_bl(i-2,j-2)=0.25*(Boundary_extended_image(i-1,j-1)+Boundary_extended_image(i-1,j+1)+Boundary_extended_image(i+1,j-1)+Boundary_extended_image(i+1,j+1));
                 Green_bl(i-2,j-2)=0.25*(Boundary_extended_image(i,j-1)+Boundary_extended_image(i,j+1)+Boundary_extended_image(i-1,j)+Boundary_extended_image(i+1,j));
            end
        else
               if(mod((j-1),2)==0)
                 Blue_bl(i-2,j-2)=Boundary_extended_image(i,j); 
                 Green_bl(i-2,j-2)=0.25*(Boundary_extended_image(i,j-1)+Boundary_extended_image(i,j+1)+Boundary_extended_image(i-1,j)+Boundary_extended_image(i+1,j));
                 Red_bl(i-2,j-2)=0.25*(Boundary_extended_image(i-1,j-1)+Boundary_extended_image(i-1,j+1)+Boundary_extended_image(i+1,j-1)+Boundary_extended_image(i+1,j+1));
               else
                 Green_bl(i-2,j-2)=Boundary_extended_image(i,j); 
                 Red_bl(i-2,j-2)=0.5*(Boundary_extended_image(i+1,j)+Boundary_extended_image(i-1,j));
                 Blue_bl(i-2,j-2)=0.5*(Boundary_extended_image(i,j+1)+Boundary_extended_image(i,j-1));
             end
        end
    end
end
    
% Stacking Red,Green and Blue plane to form RGB image from bilinear demosaicing
RGB_bl(1:300,1:390,1)=Red_bl(1:300,1:390);
RGB_bl(1:300,1:390,2)=Green_bl(1:300,1:390);
RGB_bl(1:300,1:390,3)=Blue_bl(1:300,1:390);

%Displaying the image obtained from Bilinear Demosaicing method
figure(1);
imshow(uint8(RGB_bl));   %Since the RGB matrix is of type "double", the matrix is first casted to type "uint8) before displaying
title("Bilinear Demosaicing");

%MHC Linear Demosaicing Algorithm
% Initalizing the Parameters that control the 2nd order correction factor applied to red, green and blue channel 
alpha=0.5;
beta=0.625;
gamma=0.75;

%Computation of MHC demosaicing of all pixels in the image except at the boundary pixel 

for i=3:302
    for j=3:392
        if(mod((i-1),2)==0)
            if(mod((j-1),2)==0)
                Green(i-2,j-2)=Green_bl(i-2,j-2);
                Red(i-2,j-2)=Red_bl(i-2,j-2)+beta*(Boundary_extended_image(i,j)+0.1*Boundary_extended_image(i-2,j)+0.1*Boundary_extended_image(i+2,j)-0.2*Boundary_extended_image(i-1,j-1)-0.2*Boundary_extended_image(i-1,j+1)-0.2*Boundary_extended_image(i+1,j-1)-0.2*Boundary_extended_image(i+1,j+1)-0.2*Boundary_extended_image(i,j-2)-0.2*Boundary_extended_image(i,j+2));
                Blue(i-2,j-2)=Blue_bl(i-2,j-2)+beta*(Boundary_extended_image(i,j)-0.2*Boundary_extended_image(i-2,j)-0.2*Boundary_extended_image(i+2,j)-0.2*Boundary_extended_image(i-1,j-1)-0.2*Boundary_extended_image(i-1,j+1)-0.2*Boundary_extended_image(i+1,j-1)-0.2*Boundary_extended_image(i+1,j+1)+0.1*Boundary_extended_image(i,j-2)+0.1*Boundary_extended_image(i,j+2));
            else
                Red(i-2,j-2)=Red_bl(i-2,j-2);
                Green(i-2,j-2)=Green_bl(i-2,j-2)+alpha*(Boundary_extended_image(i,j)-0.25*Boundary_extended_image(i,j-2)-0.25*Boundary_extended_image(i,j+2)-0.25*Boundary_extended_image(i-2,j)-0.25*Boundary_extended_image(i+2,j));
                Blue(i-2,j-2)=Blue_bl(i-2,j-2)+alpha*(Boundary_extended_image(i,j)-0.25*Boundary_extended_image(i-2,j)-0.25*Boundary_extended_image(i+2,j)-0.25*Boundary_extended_image(i,j-2)-0.25*Boundary_extended_image(i,j+2));
            end
            
        else
            if(mod((j-1),2)==0)
                Blue(i-2,j-2)=Blue_bl(i-2,j-2);
                Green(i-2,j-2)=Green_bl(i-2,j-2)+gamma*(Boundary_extended_image(i,j)-0.25*Boundary_extended_image(i,j-2)-0.25*Boundary_extended_image(i,j+2)-0.25*Boundary_extended_image(i-2,j)-0.25*Boundary_extended_image(i+2,j));
                Red(i-2,j-2)=Red_bl(i-2,j-2)+gamma*(Boundary_extended_image(i,j)-0.25*Boundary_extended_image(i-2,j)-0.25*Boundary_extended_image(i+2,j)-0.25*Boundary_extended_image(i,j-2)-0.25*Boundary_extended_image(i,j+2));
            else
                Green(i-2,j-2)=Green_bl(i-2,j-2);
                Red(i-2,j-2)=Red_bl(i-2,j-2)+beta*(Boundary_extended_image(i,j)-0.2*Boundary_extended_image(i-2,j)-0.2*Boundary_extended_image(i+2,j)-0.2*Boundary_extended_image(i-1,j-1)-0.2*Boundary_extended_image(i-1,j+1)-0.2*Boundary_extended_image(i+1,j-1)-0.2*Boundary_extended_image(i+1,j+1)+0.1*Boundary_extended_image(i,j-2)+0.1*Boundary_extended_image(i,j+2));
                Blue(i-2,j-2)=Blue_bl(i-2,j-2)+beta*(Boundary_extended_image(i,j)+0.1*Boundary_extended_image(i-2,j)+0.1*Boundary_extended_image(i+2,j)-0.2*Boundary_extended_image(i-1,j-1)-0.2*Boundary_extended_image(i-1,j+1)-0.2*Boundary_extended_image(i+1,j-1)-0.2*Boundary_extended_image(i+1,j+1)-0.2*Boundary_extended_image(i,j-2)-0.2*Boundary_extended_image(i,j+2));
            end
        end
    end
end

% Stacking Red,Green and Blue plane to form RGB image from bilinear demosaicing

RGB_mhc(1:300,1:390,1)=Red(1:300,1:390);
RGB_mhc(1:300,1:390,2)=Green(1:300,1:390);
RGB_mhc(1:300,1:390,3)=Blue(1:300,1:390);

%Displaying the image obtained from MHC Demosaicing method
figure(2);
imshow(uint8(RGB_bl));   %Since the RGB matrix is of type "double", the matrix is first casted to type "uint8) before displaying
title("Malvar-He-Cutler (MHC) Demosaicing");

%Distribution of luminosity

figure(3);
subplot 311
plot(1:300,Red_bl(1:300,256),'-*r');
title("Distribution of Red channel luminosity in Bilinear interpolation");
ylabel("Luminosity");
xlabel("Across Height of image");
subplot 312
plot(1:300,Red(1:300,256),'-*b');
title("Distribution of Red channel luminosity in MHC Demosaicing");
ylabel("Luminosity");
xlabel("Across Height of image");
subplot 313
plot(1:300,Red_bl(1:300,256),'-*r',1:300,Red(1:300,256),'-*b');
legend('Bilinear interpolation','MHC');
title("Zoomed version of Distribution of Red channel luminosity");
ylabel("Luminosity");
xlabel("Across Height of image");

figure(4);
subplot 311
plot(1:300,Green_bl(1:300,256),'-*r');
title("Distribution of Green channel luminosity in Bilinear interpolation");
ylabel("Luminosity");
xlabel("Across Height of image");
subplot 312
plot(1:300,Green(1:300,256),'-*b');
title("Distribution of Green channel luminosity in MHC Demosaicing");
ylabel("Luminosity");
xlabel("Across Height of image");
subplot 313
plot(1:300,Green_bl(1:300,256),'-*r',1:300,Green(1:300,256),'-*b');
legend('Bilinear interpolation','MHC');
title("Zoomed version of Distribution of Green channel luminosity");
ylabel("Luminosity");
xlabel("Across Height of image");

figure(5);
subplot 311
plot(1:300,Blue_bl(1:300,256),'-*r');
title("Distribution of Blue channel luminosity in Bilinear interpolation");
ylabel("Luminosity");
xlabel("Across Height of image");
subplot 312
plot(1:300,Blue(1:300,256),'-*b');
title("Distribution of Blue channel luminosity in MHC Demosaicing");
ylabel("Luminosity");
xlabel("Across Height of image");
subplot 313
plot(1:300,Blue_bl(1:300,256),'-*r',1:300,Blue(1:300,256),'-*b');
legend('Bilinear interpolation','MHC');
title("Zoomed version of Distribution of Blue channel luminosity");
ylabel("Luminosity");
xlabel("Across Height of image");


%PSNR

% for i=1:300
%     for j=1:390
%         a=a+(1/(N.^2))*(Denoised_gaussian(i,j)-pepper(i,j)).^2;
%         b=b+(1/(N.^2))*(Denoised_gaussian1(i,j)-pepper(i,j)).^2;
%     end
% end
% PSNR1=10*log10(255.^2/a);
% PSNR2=10*log10(255.^2/b);
% figure(2);
% plot(1:2,[PSNR1 PSNR2],'*-r');
