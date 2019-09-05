fin=fopen('classroom.raw','r');
I=fread(fin,1072*712,'uint8=>uint8'); 
image=reshape(I,1072,712)';
figure(1);
imshow(image);
K1=-0.3536;
K2= 0.1730;
K3= 0;
[height,width]=size(image);
uc=0.5*(height+1);
vc=0.5*(width+1);
fx=600;
fy=600;
m=1;
for i=1:712
    for j=1:1072
         x(m,1)=(i-uc)/fx;
         y(m,1)=(j-vc)/fy;
         r=sqrt(x(m,1).^2+y(m,1).^2);
         xd(m,1)=x(m,1)*(1+K1*(r.^2)+K2*(r.^4)+K3*(r.^6));
         yd(m,1)=y(m,1)*(1+K1*(r.^2)+K2*(r.^4)+K3*(r.^6));
         m=m+1;
    end
end

X=[ones((1072*712),1) x y];
b=regress(xd,X);
c=regress(yd,X);
%(or)
% b=X\xd;
% c=X\yd;
% b=b';
% c=c';

figure(2);
scatter3(x,y,xd);
figure(3);
scatter3(x,y,yd);
figure(4)
plot3(x,y,X*b,'xr');
figure(5)
plot3(x,y,X*c,'xr');


% function_x=(c(3)*(xd-b(1))+(-b(3)*(yd-c(1))))/(c(3)*b(2)-b(3)*c(2));
% function_y=(c(2)*(xd-b(1))+(-b(2)*(yd-c(1))))/(c(2)*b(3)-b(2)*c(3));
F=zeros(height,width);
for i=1:712
    for j=1:1072
        xd=(i-uc)/fx;
        yd=(j-vc)/fy;
        x=(c(3)*(xd-b(1)))+(-b(3)*(yd-c(1)))/(c(3)*b(2)-b(3)*c(2));
        y=(c(2)*(xd-b(1)))+(-b(2)*(yd-c(1)))/(c(2)*b(3)-b(2)*c(3));
        u=fx*x+uc;
        v=fy*y+vc;
        PQ_pos=[u;v];
         if((PQ_pos(1,1))>=1 && (PQ_pos(1,1))<=height && (PQ_pos(2,1))>=1 && (PQ_pos(2,1)<=width))
         F(i,j)=bilinear_interpolation2(uint8(image),(PQ_pos),height,width);
        else
         F(i,j)=0;
        end 
    end
end
figure(6);
imshow(uint8(F));
