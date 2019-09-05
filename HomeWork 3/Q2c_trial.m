f = fopen('rice.raw','r');
Data=fread(f,[690*3 500],'*uint8');
fclose(f);
Red=Data(1:3:2068,:)';
Green=Data(2:3:2069,:)';
Blue=Data(3:3:2070,:)';
RGB_ori(:,:,1)=Red;
RGB_ori(:,:,2)=Green;
RGB_ori(:,:,3)=Blue;
image1=rgb2gray(RGB_ori);
threshold=sum(sum(double(image1)))/(500*690);
image=image1>threshold;
figure(1)
imshow(uint8(255*image));
load('S_conditional.mat');
load('K_conditional.mat');
load('T_conditional.mat');
[height width]=size(image);

I1=imadjust(image1);

I=I1>40;
bw = bwareaopen(I,20);
se = strel('disk',1);
bw = imclose(bw,se);
bw = imfill(bw,'holes');
image=bw;



Boundary_extended_image=zeros(height+2,width+2);
Boundary_extended_image(2:height+1,2:width+1)=image;

F_hat=Boundary_extended_image;
F=F_hat;
M=zeros(height+2,width+2);
flag=true;
G=zeros(height+2,width+2);
h=1;
F2=F;
% while(flag)
% temp=F2;
% for i=2:height+1
%     for j=2:width+1
%         if (F(i,j)==1)
%            F2(i,j)=connectivity_4_1(F(i,j),F(i,j+1),F(i-1,j),F(i,j-1),F(i+1,j));
%            if(F2(i,j)==1)
%               F2(i,j)=connectivity_8_1(F(i,j),F(i,j+1),F(i-1,j+1),F(i-1,j),F(i-1,j-1),F(i,j-1),F(i+1,j-1),F(i+1,j),F(i+1,j+1));
%            end
%         end
%         if (F(i,j)==0)
%            F2(i,j)=connectivity_4_2(F(i,j),F(i,j+1),F(i-1,j),F(i,j-1),F(i+1,j));
%            if(F2(i,j)==1)
%               F2(i,j)=connectivity_8_2(F(i,j),F(i,j+1),F(i-1,j+1),F(i-1,j),F(i-1,j-1),F(i,j-1),F(i+1,j-1),F(i+1,j),F(i+1,j+1));
%            end
%         end
%     end
% end
% h=h+1;
% if(isequal(temp,F2))
%   flag=false;
% end
% end
% 
% figure(2)
% imshow(uint8(F2*255));

F=F2;
flag=true;
h=1;
while(flag)
temp=G;

for i=2:height+1
    for j=2:width+1
        if(F(i,j)==1)
           temp1=[F(i,j+1),F(i-1,j+1),F(i-1,j),F(i-1,j-1),F(i,j-1),F(i+1,j-1),F(i+1,j),F(i+1,j+1)];
           m=0;
           for n=1:length(K_conditional)
              if(isequal(temp1,K_conditional(n,:)))
                  m=1;
%                   break;
              end
           end
           M(i,j)=m;        
        end
    end
end
figure(2);
imshow(M);
for i=2:height+1
    for j=2:width+1
            G(i,j)=K_unconditional(F(i,j),M(i,j),M(i,j+1),M(i-1,j+1),M(i-1,j),M(i-1,j-1),M(i,j-1),M(i+1,j-1),M(i+1,j),M(i+1,j+1));
    end
end
figure(3);
imshow(G);
h=h+1;
if(isequal(temp,G))
  flag=false;
end
F=G;
M=zeros(height+2,width+2);
end
figure(4);
imshow(G);
