fin=fopen('pattern4.raw','r');
I=fread(fin,375*375,'uint8=>uint8'); 
image=reshape(I,375,375)';
figure(1);
imshow(image);
load('S_conditional.mat');
load('K_conditional.mat');
load('T_conditional.mat');
N=375;
image=image/255;
Boundary_extended_image(2:N+1,2:N+1)=image;
Boundary_extended_image(1,2:N+1)=image(2,:);
Boundary_extended_image(N+2,2:N+1)=image(N-1,:);
Boundary_extended_image(2:N+1,1)=image(:,2);
Boundary_extended_image(2:N+1,N+2)=image(:,N-1);
F=Boundary_extended_image;
M=zeros(N+2,N+2);
flag=true;
G=zeros(N+2,N+2);
G1=zeros(N+2,N+2);
h=1;
while(flag)
temp=G;
for i=2:N+1
    for j=2:N+1
        if(F(i,j)==1)
           temp1=[F(i,j+1),F(i-1,j+1),F(i-1,j),F(i-1,j-1),F(i,j-1),F(i+1,j-1),F(i+1,j),F(i+1,j+1)];
           m=0;
           for n=1:length(K_conditional)
              if(isequal(temp1,K_conditional(n,:))) % for shrinking, S_condtional and for thinning= T_conditional, skeletonization = K_conditional is to be used 
                  m=1;
              end
           end
           M(i,j)=m;        
        end
    end
end
% figure(2);
% imshow(M);
for i=2:N+1
    for j=2:N+1
            G(i,j)=K_unconditional(F(i,j),M(i,j),M(i,j+1),M(i-1,j+1),M(i-1,j),M(i-1,j-1),M(i,j-1),M(i+1,j-1),M(i+1,j),M(i+1,j+1));  % for shrinking and thinning = S_T_uncondtional, skeletonization = K_unconditional is to be used 
    end
end
% figure(3);
% imshow(G);
h=h+1;
if(isequal(temp,G))
  flag=false;
end
F=G;
M=zeros(N+2,N+2);
end
figure(4);
imshow(G);

% only for skeletonization
% for i=2:N+1
%     for j=2:N+1       
%         G1(i,j)=K_bridging(G(i,j),G(i,j+1),G(i-1,j+1),G(i-1,j),G(i-1,j-1),G(i,j-1),G(i+1,j-1),G(i+1,j),G(i+1,j+1));
%     end
% end
% figure(5);
% imshow(G1);
   

