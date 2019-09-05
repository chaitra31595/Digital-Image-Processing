pepper=readraw1("pepper.raw");
pepper_noise=readraw1("pepper_uni.raw");
N=256;
width=N;
height=N;
Image=pepper_noise;
filter_size = 21;
N=53;
n=(filter_size-1)/2+(N-1)/2;%number of extended rows/columns in contrast to original image

a=40;
h=sqrt(10*a);
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
         NLM(i-n,j-n)=0;
         m=1;
         acc=0;
         for k=(-1*(filter_size-1)/2):((filter_size-1)/2)
             t=1;
             for l=(-1*(filter_size-1)/2):((filter_size-1)/2)
                 gaussian_weight_euclidian_distance=0;
                 for n1=(-1*(N-1)/2):((N-1)/2)
                     for n2=(-1*(N-1)/2):((N-1)/2)
                        gaussian_weight_euclidian_distance=gaussian_weight_euclidian_distance+(1/(a*sqrt(2*pi)))*exp(-1*((n1.^2)+(n2.^2))/(2*(a.^2)))*((Boundary_extended_image(i+n1,j+n2)-Boundary_extended_image(i+k+n1,i+l+n2)).^2);
                     end
                 end
                 weight(m,t)=exp((-1*gaussian_weight_euclidian_distance)/(h.^2));
                 acc=acc+weight(m,t);
                 NLM(i-n,j-n)=NLM(i-n,j-n)+weight(m,t)*(Boundary_extended_image(i+k,j+l));
                 t=t+1;
             end
             m=m+1;
         end
         NLM(i-n,j-n)=(1/acc)*NLM(i-n,j-n);
     end
end
imshow(uint8(NLM))
a=0;
for i=1:N
    for j=1:N
        a=a+(1/(N.^2))*(NLM(i,j)-pepper(i,j)).^2; 
    end
end
PSNR=10*log10((255.^2)./a);


         
         
        


