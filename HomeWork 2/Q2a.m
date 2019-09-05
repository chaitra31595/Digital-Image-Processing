Image=readraw('bridge.raw');
[height width]=size(Image);
figure(1);
imshow(uint8(Image));
title('Original Image');
F=Image;
MSE=zeros(1,4);
for i=1:height
    for j=1:width
        a(i,j)=randi([0 255],1);
        if(0<=F(i,j)&& F(i,j)<a(i,j))
            G(i,j)=0;
        else
            G(i,j)=255;
        end
        MSE(1,1)=MSE(1,1)+(1/(height*width))*((F(i,j)-G(i,j)).^2);
    end   
end
PSNR(1,1)=10*log10(255.^2/MSE(1,1));
figure(2);
imshow(uint8(G));
title('Dithering - Random Thresholding');


I0=0;
n=2;
r=log2((n/2))+1;
for i=1:r
    if i==1
    I=[4*I0+1 4*I0+2 ;4*I0+3 4*I0 ];
    else
    temp=I;
    I=[4*temp+1 4*temp+2 ;4*temp+3 4*temp ];
    end
end
T1=(((I+0.5)*255)/n.^2);
for i=1:height
    for j=1:width
        if(0<=F(i,j) && F(i,j)<=T1(mod(i-1,n)+1,mod(j-1,n)+1))
            G(i,j)=0;
        else
            G(i,j)=255;
        end
        MSE(1,2)=MSE(1,2)+(1/(height*width))*((F(i,j)-G(i,j)).^2);
    end
end
PSNR(1,2)=10*log10(255.^2/MSE(1,2));
figure(3);
imshow(uint8(G));
title('Dithering - Dithering matrix 2x2');

I0=0;
n=8;
r=log2((n/2))+1;
for i=1:r
    if i==1
    I=[4*I0+1 4*I0+2 ;4*I0+3 4*I0 ];
    else
    temp=I;
    I=[4*temp+1 4*temp+2 ;4*temp+3 4*temp ];
    end
end
T2=(((I+0.5)*255)/n.^2);
for i=1:height
    for j=1:width
        if(0<=F(i,j) && F(i,j)<=T2(mod(i-1,n)+1,mod(j-1,n)+1))
            G(i,j)=0;
        else
            G(i,j)=255;
        end
        MSE(1,3)=MSE(1,3)+(1/(height*width))*((F(i,j)-G(i,j)).^2);
    end
end
PSNR(1,3)=10*log10(255.^2/MSE(1,3));
figure(4);
imshow(uint8(G));
title('Dithering - Dithering matrix 8x8');

I0=0;
n=32;
r=log2((n/2))+1;
for i=1:r
    if i==1
    I=[4*I0+1 4*I0+2 ;4*I0+3 4*I0 ];
    else
    temp=I;
    I=[4*temp+1 4*temp+2 ;4*temp+3 4*temp ];
    end
end
T3=(((I+0.5)*255)/n.^2);
for i=1:height
    for j=1:width
        if(0<=F(i,j) && F(i,j)<=T3(mod(i-1,n)+1,mod(j-1,n)+1))
            G(i,j)=0;
        else
            G(i,j)=255;
        end
        MSE(1,4)=MSE(1,4)+(1/(height*width))*((F(i,j)-G(i,j)).^2);
    end
end
PSNR(1,4)=10*log10(255.^2/MSE(1,4));
figure(5);
imshow(uint8(G));
title('Dithering - Dithering matrix 32x32');