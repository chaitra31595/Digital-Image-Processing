fin=fopen('deer.raw','r');
I=fread(fin,691*550,'uint8=>uint8'); 
image=reshape(I,550,691)';
figure(1);
imshow(image);
title('input image');
a=image;
image=image/255;
load('S_conditional.mat');
load('K_conditional.mat');
load('T_conditional.mat');
[height width]=size(image);
Boundary_extended_image=zeros(height+2,width+2);
Boundary_extended_image(2:height+1,2:width+1)=image;
F=Boundary_extended_image;
M=zeros(height+2,width+2);
flag=true;
G=zeros(height+2,width+2);
h=1;
while(flag)
temp=G;
for i=2:height+1
    for j=2:width+1
        if(F(i,j)==1)
           temp1=[F(i,j+1),F(i-1,j+1),F(i-1,j),F(i-1,j-1),F(i,j-1),F(i+1,j-1),F(i+1,j),F(i+1,j+1)];
           m=0;
           for n=1:length(T_conditional)
              if(isequal(temp1,T_conditional(n,:)))
                  m=1;
              end
           end
           M(i,j)=m;        
        end
    end
end
% figure(2);
% imshow(M);
for i=2:height+1
    for j=2:width+1
            G(i,j)=S_T_unconditional(F(i,j),M(i,j),M(i,j+1),M(i-1,j+1),M(i-1,j),M(i-1,j-1),M(i,j-1),M(i+1,j-1),M(i+1,j),M(i+1,j+1));
    end
end
% figure(3);
% imshow(G);
h=h+1;
if(isequal(temp,G))
  flag=false;
end
F=G;
M=zeros(height+2,width+2);
end
figure(4);
imshow(G);
title('Thinned input image');
R1=G;
% %to correct the image
F1=Boundary_extended_image;
F2=F1;
k=1;
m=1;
for i=2:height+1
    for j=2:width+1
        if (F1(i,j)==0)
           F2(i,j)=connectivity_4(F1(i,j),F1(i,j+1),F1(i-1,j),F1(i,j-1),F1(i+1,j));
           if(F1(i,j)==0 && F2(i,j)==1)
              location_defect(m,:)=[i,j]; 
              m=m+1;
           end
        end
    end
end
figure(5);
imshow(F2*255);
title('Corrected/ defect removed image');

M=zeros(height+2,width+2);
flag=true;
G=zeros(height+2,width+2);
h=1;
F=F2;   
while(flag)
temp=G;
for i=2:height+1
    for j=2:width+1
        if(F(i,j)==1)
           temp1=[F(i,j+1),F(i-1,j+1),F(i-1,j),F(i-1,j-1),F(i,j-1),F(i+1,j-1),F(i+1,j),F(i+1,j+1)];
           m=0;
           for n=1:length(T_conditional)
              if(isequal(temp1,T_conditional(n,:)))
                  m=1;
              end
           end
           M(i,j)=m;        
        end
    end
end
% figure(6);
% imshow(M);
for i=2:height+1
    for j=2:width+1
            G(i,j)=S_T_unconditional(F(i,j),M(i,j),M(i,j+1),M(i-1,j+1),M(i-1,j),M(i-1,j-1),M(i,j-1),M(i+1,j-1),M(i+1,j),M(i+1,j+1));
    end
end
% figure(7);
% imshow(G);
h=h+1;
if(isequal(temp,G))
  flag=false;
end
F=G;
M=zeros(height+2,width+2);
end
figure(8);
imshow(G);
title('Corrected/defect removed  thinned image');
R2=G;




    
