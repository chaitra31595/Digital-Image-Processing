L=[1 4 6 4 1];
E=[-1 -2 0 2 1];
S=[-1 0 2 0 -1];
W=[-1 2 0 -2 1];
R=[1 -4 6 -4 1];
N=128;
n=2;
fin=fopen('texture1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image1=image;
% figure(1);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E1=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture2.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image2=image;
% figure(2);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E2=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture3.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image3=image;
% figure(3);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E3=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture4.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image4=image;
% figure(4);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E4=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture5.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image5=image;
% figure(5);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E5=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture6.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image6=image;
% figure(6);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E6=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture7.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image7=image;
% figure(7);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E7=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture8.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image8=image;
% figure(8);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E8=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture9.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image9=image;
% figure(9);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E9=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture10.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image10=image;
% figure(10);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E10=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture11.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image11=image;
% figure(11);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E11=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
fin=fopen('texture12.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
image12=image;
% figure(12);
% imshow(image);
Boundary_extended_image=extend_boundary(image,N);
E12=feature_vector(L,E,S,W,R,Boundary_extended_image,N);
combined_E=[E1; E2; E3; E4; E5; E6; E7; E8; E9; E10; E11; E12];

for i=1:25
   variance_feature(i,:)=(sum(((combined_E(:,i)-mean(combined_E(:,i))).^2))/12);
end


for i=1:12
   standard_deviation=sqrt(sum(((combined_E(i,:)-mean(combined_E(i,:))).^2))/25);
   std_combined(i,:)=(combined_E(i,:)-mean(combined_E(i,:)))./standard_deviation;
   a=min(combined_E(i,:));
   b=max(combined_E(i,:));
   norm_combined(i,:)=(combined_E(i,:)-a)/(b-a);
end

 
X=std_combined';
for i=1:25   
   X_pca(i,:)=(X(i,:)-mean(X(i,:)));
end


Zx=X_pca;
[U,S,V]=svd(Zx);
a=U(:,1:3)*S(1:3,:)*V';
Ur=U(:,1:3);
Rx=Ur'*a;
Rx_t=Rx'; 
t=Rx_t;


for i=1:12
   standard_deviation=sqrt(sum(((Rx_t(i,:)-mean(Rx_t(i,:))).^2))/3);
   Rx_t_std_combined(i,:)=(Rx_t(i,:)-mean(Rx_t(i,:)))./standard_deviation;
   a=min(Rx_t(i,:));
   b=max(Rx_t(i,:));
   Rx_t_norm_combined(i,:)=(Rx_t(i,:)-a)/(b-a);
end

Rx_t=Rx_t_std_combined;

labels={'1','2','3','4','5','6','7','8','9','10','11','12'};
for i=1:12
figure(1);plot3(Rx_t(i,1),Rx_t(i,2),Rx_t(i,3),'*');hold on;grid on;
text(Rx_t(i,1),Rx_t(i,2),Rx_t(i,3),labels(i));
end  
xlabel('1st Pricipal Component');
ylabel('2nd Principal Component');
zlabel('3rd Principal Component');
title('Principal Component Analysis: Reduced 3D Feature Space');


% Rx_t=std_combined; for 25D clustering
% k-means clustering
cluster_count=4;
datapoints=12;
dim=3;
k=1;
a=randi([1 datapoints]);
u(1,:)=Rx_t(a,:);
chosen_points_index(1,1)=a;
% Step 1: Initialization of k centroids
for i=2:cluster_count
    
for j=1:datapoints
    flag=false;
    for k=1:i-1
     if(j==chosen_points_index(k,1))
         flag=true;
     end
    end
    if(flag==true)
        c(j,1)=0;
    else 
        c(j,1)=sqrt(sum((Rx_t(j,:)-u(i-1,:)).^2));
    end 
end
probability(:,1)=(c(:,1).^2)/sum((c(:,1).^2));
[val,ind]=max(probability);
chosen_points_index(i,1)=ind;
u(i,:)=Rx_t(ind,:);
end

% Step 2: k -means clustering
flag=true;
iteration_count=0;
while(flag)
temp=u;
 for i=1:datapoints
    for j=1:cluster_count
       ca(1,j)=sqrt(sum((Rx_t(i,:)-u(j,:)).^2));
     end
    [d(i,1),c(i,1)]=min(ca);
 end

 u=zeros(cluster_count,dim);
for j=1:cluster_count
    count=0;
   for i=1:12
     if(c(i,1)==j)
        count=count+1;
        u(j,:)=u(j,:)+Rx_t(i,:);
     end
   end
   if(count~=0)
    u(j,:)=u(j,:)./count;
   end
end

check=temp-u;
iteration_count=iteration_count+1;
if(sum(sum(abs(check)))==0 || iteration_count==100)
    flag=false;
end
end
disp('After clustering using k++ initialization');
disp(c);

disp('Initialization of centroids using k++ : Index position of data points');
disp(chosen_points_index);

% cluster_count=4;
% u(1,:)=Rx_t(5,:);
% u(2,:)=Rx_t(8,:);
% u(3,:)=Rx_t(9,:);
% u(4,:)=Rx_t(6,:);
% 
% flag=true;
% iteration_count=0;
% while(flag)
% temp=u;
%  for i=1:12
%      for j=1:cluster_count
%        ca(1,j)=sqrt(sum((Rx_t(i,:)-u(j,:)).^2));
%      end
%     [d(i,1),c(i,1)]=min(ca);
% 
%  end
% 
%  u=zeros(cluster_count,dim);
% for j=1:cluster_count
%     count=0;
%    for i=1:12
%      if(c(i,1)==j)
%         count=count+1;
%         u(j,:)=u(j,:)+Rx_t(i,:);
%      end
%    end
%    if(count~=0)
%     u(j,:)=u(j,:)./count;
%    end
% end
% 
% check=temp-u;
% iteration_count=iteration_count+1;
% if(sum(sum(abs(check)))==0 || iteration_count==100)
%     flag=false;
% end
% end
% 
% actual_ind=[1,2,3,4,1,4,1,2,3,2,3,4]';
% correct=0;
% for i=1:12
%  if(actual_ind(i,1)==c(i,1))
%     correct=correct+1;
%  end
% end
% disp(correct);


%                
% e1=[E1(1,1:6) E1(1,8) E1(1,10) E1(1,12) E1(1,14) E1(1,16) E1(1,18) E1(1,20) E1(1,22) E1(1,24)]; 
% e2=[E2(1,1:6) E2(1,8) E2(1,10) E2(1,12) E2(1,14) E2(1,16) E2(1,18) E2(1,20) E2(1,22) E2(1,24)]; 
% e3=[E3(1,1:6) E3(1,8) E3(1,10) E3(1,12) E3(1,14) E3(1,16) E3(1,18) E3(1,20) E3(1,22) E3(1,24)]; 
% e4=[E4(1,1:6) E4(1,8) E4(1,10) E4(1,12) E4(1,14) E4(1,16) E4(1,18) E4(1,20) E4(1,22) E4(1,24)]; 
% e5=[E5(1,1:6) E5(1,8) E5(1,10) E5(1,12) E5(1,14) E5(1,16) E5(1,18) E5(1,20) E5(1,22) E5(1,24)]; 
% e6=[E6(1,1:6) E6(1,8) E6(1,10) E6(1,12) E6(1,14) E6(1,16) E6(1,18) E6(1,20) E6(1,22) E6(1,24)]; 
% e7=[E7(1,1:6) E7(1,8) E7(1,10) E7(1,12) E7(1,14) E7(1,16) E7(1,18) E7(1,20) E7(1,22) E7(1,24)]; 
% e8=[E8(1,1:6) E8(1,8) E8(1,10) E8(1,12) E8(1,14) E8(1,16) E8(1,18) E8(1,20) E8(1,22) E8(1,24)]; 
% e9=[E9(1,1:6) E9(1,8) E9(1,10) E9(1,12) E9(1,14) E9(1,16) E9(1,18) E9(1,20) E9(1,22) E9(1,24)]; 
% e10=[E10(1,1:6) E10(1,8) E10(1,10) E10(1,12) E10(1,14) E10(1,16) E10(1,18) E10(1,20) E10(1,22) E10(1,24)]; 
% e11=[E11(1,1:6) E11(1,8) E11(1,10) E11(1,12) E11(1,14) E11(1,16) E11(1,18) E11(1,20) E11(1,22) E11(1,24)]; 
% e12=[E12(1,1:6) E12(1,8) E12(1,10) E12(1,12) E12(1,14) E12(1,16) E12(1,18) E12(1,20) E12(1,22) E12(1,24)]; 
% 
% combined_15_E=[e1; e2; e3; e4; e5; e6; e7; e8; e9; e10; e11; e12];
% 
% for i=1:15
%    standard_deviation_15=sqrt(sum((combined_15_E(:,i).^2))/12);
%    std_combined_15(:,i)=(combined_15_E(:,i)-mean(combined_15_E(:,i)))./standard_deviation_15;
%    norm_combined_15(:,i)=(combined_15_E(:,i)-min(combined_15_E(:,i)))./(max(combined_15_E(:,i))-min(combined_15_E(:,i)));
% end
%  
% X_15=norm_combined_15';
% for i=1:15
%    X_pca_15(i,:)=(X_15(i,:)-mean(X_15(i,:)));
% end
% 
% Zx_15=X_pca_15;
% [U_15,S_15,V_15]=svd(Zx_15);
% a_15=U_15(:,(1:3))*S_15(1:3,:)*V_15';
% Ur_15=U_15(:,1:3);
% Rx_15=Ur_15'*a_15;
% Rx_t_15=Rx_15';                
%                                             
% 
% labels={'1','2','3','4','5','6','7','8','9','10','11','12'};
% for i=1:12
% figure(2);plot3(Rx_t_15(i,1),Rx_t_15(i,2),Rx_t_15(i,3),'*');hold on;
% text(Rx_t_15(i,1),Rx_t_15(i,2),Rx_t_15(i,3),labels(i));
% end  
% 
% cluster_count=4;
% u(1,:)=Rx_t_15(1,:);
% u(2,:)=Rx_t_15(2,:);
% u(3,:)=Rx_t_15(3,:);
% u(4,:)=Rx_t_15(4,:);
% 
% flag=true;
% iteration_count=0;
% while(flag)
% temp=u;
%  for i=1:12
%     c1=sqrt(((Rx_t_15(i,1)-u(1,1)).^2)+((Rx_t_15(i,2)-u(1,2)).^2)+((Rx_t_15(i,3)-u(1,3)).^2));
%     c2=sqrt(((Rx_t_15(i,1)-u(2,1)).^2)+((Rx_t_15(i,2)-u(2,2)).^2)+((Rx_t_15(i,3)-u(2,3)).^2));
%     c3=sqrt(((Rx_t_15(i,1)-u(3,1)).^2)+((Rx_t_15(i,2)-u(3,2)).^2)+((Rx_t_15(i,3)-u(3,3)).^2));
%     c4=sqrt(((Rx_t_15(i,1)-u(4,1)).^2)+((Rx_t_15(i,2)-u(4,2)).^2)+((Rx_t_15(i,3)-u(4,3)).^2));
%     [d(i,1),c(i,1)]=min([c1 c2 c3 c4]);
%  end
% 
%  u=zeros(cluster_count,3);
% for j=1:cluster_count
%     count=0;
%    for i=1:12
%      if(c(i,1)==j)
%         count=count+1;
%         u(j,:)=u(j,:)+Rx_t_15(i,:);
%      end
%    end
%    if(count~=0)
%     u(j,:)=u(j,:)./count;
%    end
% end
% 
% check=temp-u;
% iteration_count=iteration_count+1;
% if(sum(sum(abs(check)))==0 || iteration_count==100)
%     flag=false;
% end
% end
% 
% actual_ind=[1,2,3,4,1,4,1,2,3,2,3,4]';
% correct=0;
% for i=1:12
%  if(actual_ind(i,1)==c(i,1))
%     correct=correct+1;
%  end
% end
% disp(correct);

