pepper=readraw1("pepper.raw");
pepper_noise=readraw1("pepper_uni.raw");
N=256;
width=N;
height=N;
Image=pepper_noise;

%Uniform filter : filter_size = 3
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
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_uniform1(i-n,j-n)=0;
         for k=-((filter_size-1)/2):((filter_size+1)/2)-1
             for l=-((filter_size-1)/2):((filter_size+1)/2)-1
                 Denoised_uniform1(i-n,j-n)=Denoised_uniform1(i-n,j-n)+(1/(filter_size*filter_size))*(Boundary_extended_image(i-k,j-l));
             end
         end
     end
end

%Gaussian filter : filter_size = 3 sigma=1

sigma=1;
 for i=n+1:height+n
     for j=n+1:width+n
         Denoised_gaussian1(i-n,j-n)=0;
         m=1;
         acc=0;
         for k=(-1*(filter_size-1)/2):((filter_size-1)/2)
             t=1;
             for l=(-1*(filter_size-1)/2):((filter_size-1)/2)
                 weight(m,t)=(1/sqrt(2*pi*(sigma.^2)))*exp(-((k).^2+(l).^2)/(2*(sigma.^2)));
                 acc=acc+weight(m,t);
                 Denoised_gaussian1(i-n,j-n)=Denoised_gaussian1(i-n,j-n)+weight(m,t)*(Boundary_extended_image(i+k,j+l));
                 t=t+1;
             end
             m=m+1;
         end
         Denoised_gaussian1(i-n,j-n)=(1/acc)*Denoised_gaussian1(i-n,j-n);
     end
 end
% a=0;h=1;
%  for i=1:N
%     for j=1:N
%         a=a+(1/(N.^2))*(Denoised_gaussian1(i,j)-pepper(i,j)).^2;
%     end
%  end
% PSNR(1,h)=10*log10((255.^2)./a);
% h=h+1;

%Bilateral filter size =3
sigmac=100;
sigmas=100;
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_bilateral1(i-n,j-n)=0;
         m=1;
         acc=0;
         for k=(-1*(filter_size-1)/2):((filter_size-1)/2)
             t=1;
             for l=(-1*(filter_size-1)/2):((filter_size-1)/2)
                 weight(m,t)=exp(-1*(((k.^2)+(l.^2))/(2*(sigmac.^2))))*exp(-1*(((abs(Boundary_extended_image(i,j)-Boundary_extended_image(i+k,j+l))).^2)/(2*(sigmas.^2))));
                 acc=acc+weight(m,t);
                 Denoised_bilateral1(i-n,j-n)=Denoised_bilateral1(i-n,j-n)+weight(m,t)*(Boundary_extended_image(i+k,j+l));
                 t=t+1;
             end
             m=m+1;
         end
         Denoised_bilateral1(i-n,j-n)=(1/acc)*Denoised_bilateral1(i-n,j-n);
     end
end



%Uniform filter : filter_size = 5
filter_size = 5;
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
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_uniform2(i-n,j-n)=0;
         for k=-((filter_size-1)/2):((filter_size+1)/2)-1
             for l=-((filter_size-1)/2):((filter_size+1)/2)-1
                 Denoised_uniform2(i-n,j-n)=Denoised_uniform2(i-n,j-n)+(1/(filter_size*filter_size))*(Boundary_extended_image(i-k,j-l));
             end
         end
     end
end

%Gaussian filter : filter_size = 5 sigma=1

sigma=1;
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_gaussian2(i-n,j-n)=0;
         m=1;
         acc=0;
         for k=(-1*(filter_size-1)/2):((filter_size-1)/2)
             t=1;
             for l=(-1*(filter_size-1)/2):((filter_size-1)/2)
                 weight(m,t)=(1/sqrt(2*pi*(sigma.^2)))*exp(-((k).^2+(l).^2)/(2*(sigma.^2)));
                 acc=acc+weight(m,t);
                 Denoised_gaussian2(i-n,j-n)=Denoised_gaussian2(i-n,j-n)+weight(m,t)*(Boundary_extended_image(i+k,j+l));
                 t=t+1;
             end
             m=m+1;
         end
         Denoised_gaussian2(i-n,j-n)=(1/acc)*Denoised_gaussian2(i-n,j-n);
     end
end
% a=0; h=1;
%  for i=1:N
%     for j=1:N
%         a=a+(1/(N.^2))*(Denoised_gaussian2(i,j)-pepper(i,j)).^2;
%     end
%  end
% PSNR(2,h)=10*log10((255.^2)./a);
% h=h+1;


%Bilateral filter : filter_size = 5 sigmac=100 sigmas=100
% sigmac=40;sigmas=40;
% sc=1;ss=1;
sigmac=100;
sigmas=100;
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_bilateral2(i-n,j-n)=0;
         m=1;
         acc=0;
         for k=(-1*(filter_size-1)/2):((filter_size-1)/2)
             t=1;
             for l=(-1*(filter_size-1)/2):((filter_size-1)/2)
                 weight(m,t)=exp(-1*(((k.^2)+(l.^2))/(2*(sigmac.^2))))*exp(-1*(((abs(Boundary_extended_image(i,j)-Boundary_extended_image(i+k,j+l))).^2)/(2*(sigmas.^2))));
                 acc=acc+weight(m,t);
                 Denoised_bilateral2(i-n,j-n)=Denoised_bilateral2(i-n,j-n)+weight(m,t)*(Boundary_extended_image(i+k,j+l));
                 t=t+1;
             end
             m=m+1;
         end
         Denoised_bilateral2(i-n,j-n)=(1/acc)*Denoised_bilateral2(i-n,j-n);
     end
end
% a=0;
% for i=1:N
%     for j=1:N
%         a=a+(1/(N.^2))*(Denoised_bilateral2(i,j)-pepper(i,j)).^2;
%     end
% end
% PSNR(sc,ss)=10*log10((255.^2)./a);
% ss=ss+1;
%   end
% sc=sc+1;
% end
% 
% 
% 
%Uniform filter : filter_size = 7
filter_size = 7;
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
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_uniform3(i-n,j-n)=0;
         for k=-((filter_size-1)/2):((filter_size+1)/2)-1
             for l=-((filter_size-1)/2):((filter_size+1)/2)-1
                 Denoised_uniform3(i-n,j-n)=Denoised_uniform3(i-n,j-n)+(1/(filter_size*filter_size))*(Boundary_extended_image(i-k,j-l));
             end
         end
     end
end

%Gaussian filter : filter_size = 7 sigma=1

sigma=1;
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_gaussian3(i-n,j-n)=0;
         m=1;
         acc=0;
         for k=(-1*(filter_size-1)/2):((filter_size-1)/2)
             t=1;
             for l=(-1*(filter_size-1)/2):((filter_size-1)/2)
                 weight(m,t)=(1/sqrt(2*pi*(sigma.^2)))*exp(-((k).^2+(l).^2)/(2*(sigma.^2)));
                 acc=acc+weight(m,t);
                 Denoised_gaussian3(i-n,j-n)=Denoised_gaussian3(i-n,j-n)+weight(m,t)*(Boundary_extended_image(i+k,j+l));
                 t=t+1;
             end
             m=m+1;
         end
         Denoised_gaussian3(i-n,j-n)=(1/acc)*Denoised_gaussian3(i-n,j-n);
     end
end
% a=0;% h=1;
%  for i=1:N
%     for j=1:N
%         a=a+(1/(N.^2))*(Denoised_gaussian3(i,j)-pepper(i,j)).^2;
%     end
%  end
% PSNR(3,h)=10*log10((255.^2)./a);
% h=h+1;

sigmac=100;
sigmas=100;
for i=n+1:height+n
     for j=n+1:width+n
         Denoised_bilateral3(i-n,j-n)=0;
         m=1;
         acc=0;
         for k=(-1*(filter_size-1)/2):((filter_size-1)/2)
             t=1;
             for l=(-1*(filter_size-1)/2):((filter_size-1)/2)
                 weight(m,t)=exp(-1*(((k.^2)+(l.^2))/(2*(sigmac.^2))))*exp(-1*(((abs(Boundary_extended_image(i,j)-Boundary_extended_image(i+k,j+l))).^2)/(2*(sigmas.^2))));
                 acc=acc+weight(m,t);
                 Denoised_bilateral3(i-n,j-n)=Denoised_bilateral3(i-n,j-n)+weight(m,t)*(Boundary_extended_image(i+k,j+l));
                 t=t+1;
             end
             m=m+1;
         end
         Denoised_bilateral3(i-n,j-n)=(1/acc)*Denoised_bilateral3(i-n,j-n);
     end
end




%Output image
figure(1)
imshow(uint8(pepper_noise));
figure(2)
imshow(uint8(Denoised_bilateral1));
figure(3)
imshow(uint8(Denoised_bilateral2));
figure(4)
imshow(uint8(Denoised_bilateral3));
 

%Calculation of PSNR
a=0;b=0;c=0;d=0;e=0;f=0;g=0;h=0;q=0;r=0;
for i=1:N
    for j=1:N
        a=a+(1/(N.^2))*(pepper_noise(i,j)-pepper(i,j)).^2;
        b=b+(1/(N.^2))*(Denoised_uniform1(i,j)-pepper(i,j)).^2;
        c=c+(1/(N.^2))*(Denoised_gaussian1(i,j)-pepper(i,j)).^2;
        d=d+(1/(N.^2))*(Denoised_bilateral1(i,j)-pepper(i,j)).^2;
        e=e+(1/(N.^2))*(Denoised_uniform2(i,j)-pepper(i,j)).^2;
        f=f+(1/(N.^2))*(Denoised_gaussian2(i,j)-pepper(i,j)).^2;
        g=g+(1/(N.^2))*(Denoised_bilateral2(i,j)-pepper(i,j)).^2;
        h=h+(1/(N.^2))*(Denoised_uniform3(i,j)-pepper(i,j)).^2;
        q=i+(1/(N.^2))*(Denoised_gaussian3(i,j)-pepper(i,j)).^2;
        r=j+(1/(N.^2))*(Denoised_bilateral3(i,j)-pepper(i,j)).^2;
    end
end
x=[a b c d e f g h q r];
PSNR=10*log10((255.^2)./x);
figure(5);
plot(PSNR,'-*r');


