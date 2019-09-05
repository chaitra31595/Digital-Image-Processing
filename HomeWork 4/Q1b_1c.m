L=[1 4 6 4 1];
E=[-1 -2 0 2 1];
S=[-1 0 2 0 -1];
W=[-1 2 0 -2 1];
R=[1 -4 6 -4 1];
N=510;

fin=fopen('comb.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
image=reshape(I,N,N)';
figure(1);
imshow(image);
image1=double(image);
image=double(image1-(sum(sum(image1))/(N*N)));
Boundary_extended_image=zeros(N+4,N+4);
Boundary_extended_image(3:N+2,3:N+2)=image;
Boundary_extended_image(1,3:N+2)=image(3,:);
Boundary_extended_image(2,3:N+2)=image(2,:);
Boundary_extended_image(N+4,3:N+2)=image(N-2,:);
Boundary_extended_image(N+3,3:N+2)=image(N-1,:);
Boundary_extended_image(:,1)=Boundary_extended_image(:,5);
Boundary_extended_image(:,2)=Boundary_extended_image(:,4);
Boundary_extended_image(:,N+4)=Boundary_extended_image(:,N);
Boundary_extended_image(:,N+3)=Boundary_extended_image(:,N+1);


response_map1=average_response(L'*L,Boundary_extended_image,N);
response_map2=average_response(E'*E,Boundary_extended_image,N);
response_map3=average_response(S'*S,Boundary_extended_image,N);
response_map4=average_response(W'*W,Boundary_extended_image,N);
response_map5=average_response(R'*R,Boundary_extended_image,N);
response_map6=average_response(L'*E,Boundary_extended_image,N);
response_map7=average_response(E'*L,Boundary_extended_image,N);
response_map8=average_response(L'*S,Boundary_extended_image,N);
response_map9=average_response(S'*L,Boundary_extended_image,N);
response_map10=average_response(L'*W,Boundary_extended_image,N);
response_map11=average_response(W'*L,Boundary_extended_image,N);
response_map12=average_response(L'*R,Boundary_extended_image,N);
response_map13=average_response(R'*L,Boundary_extended_image,N);
response_map14=average_response(W'*R,Boundary_extended_image,N);
response_map15=average_response(R'*W,Boundary_extended_image,N);
response_map16=average_response(E'*S,Boundary_extended_image,N);
response_map17=average_response(S'*E,Boundary_extended_image,N);
response_map18=average_response(E'*W,Boundary_extended_image,N);
response_map19=average_response(W'*E,Boundary_extended_image,N);
response_map20=average_response(E'*R,Boundary_extended_image,N);
response_map21=average_response(R'*E,Boundary_extended_image,N);
response_map22=average_response(S'*W,Boundary_extended_image,N);
response_map23=average_response(W'*S,Boundary_extended_image,N);
response_map24=average_response(S'*R,Boundary_extended_image,N);
response_map25=average_response(R'*S,Boundary_extended_image,N);



n=25;
E1=energy_feature_window(response_map1,N,n);
E2=energy_feature_window(response_map2,N,n);
E3=energy_feature_window(response_map3,N,n);
E4=energy_feature_window(response_map4,N,n);
E5=energy_feature_window(response_map5,N,n);
E6=energy_feature_window(response_map6,N,n);
E7=energy_feature_window(response_map7,N,n);
E8=energy_feature_window(response_map8,N,n);
E9=energy_feature_window(response_map9,N,n);
E10=energy_feature_window(response_map10,N,n);
E11=energy_feature_window(response_map11,N,n);
E12=energy_feature_window(response_map12,N,n);
E13=energy_feature_window(response_map13,N,n);
E14=energy_feature_window(response_map14,N,n);
E15=energy_feature_window(response_map15,N,n);
E16=energy_feature_window(response_map16,N,n);
E17=energy_feature_window(response_map17,N,n);
E18=energy_feature_window(response_map18,N,n);
E19=energy_feature_window(response_map19,N,n);
E20=energy_feature_window(response_map20,N,n);
E21=energy_feature_window(response_map21,N,n);
E22=energy_feature_window(response_map22,N,n);
E23=energy_feature_window(response_map23,N,n);
E24=energy_feature_window(response_map24,N,n);
E25=energy_feature_window(response_map25,N,n);

k=1;
for i=1:N
    for j=1:N
        e=[E1(i,j) E2(i,j) E3(i,j) E4(i,j) E5(i,j) E6(i,j) E7(i,j) E8(i,j) E9(i,j) E10(i,j) E11(i,j) E12(i,j) E13(i,j) E14(i,j) E15(i,j) E16(i,j) E17(i,j) E18(i,j) E19(i,j) E20(i,j) E21(i,j) E22(i,j) E23(i,j) E24(i,j) E25(i,j)];  
        e=e./E1(i,j);
        data(k,:)=e; 
        k=k+1;
    end
end
               
% Rx_t=data;
% 
% cluster_count=7;
% u(1,:)=Rx_t(510*30+90,:);
% u(2,:)=Rx_t(510*40+255,:);
% u(3,:)=Rx_t(510*150+35,:);
% u(4,:)=Rx_t(510*150+458,:);
% u(5,:)=Rx_t(510*255+255,:);
% u(6,:)=Rx_t(510*455+90,:);
% u(7,:)=Rx_t(510*455+419,:);
% 
% flag=true;
% iteration_count=0;
% while(flag)
% temp=u;
%  for i=1:length(data)
%      for j=1:cluster_count
%        ca(1,j)=sqrt(sum((data(i,:)-u(j,:)).^2));
%      end
%     [d(i,1),c(i,1)]=min(ca);
%     
%  end
% 
%  u=zeros(cluster_count,25);
% for j=1:cluster_count
%     count=0;
%    for i=1:length(data)
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
% if((sum(sum(abs(check)))==0) || (iteration_count==100))
%     flag=false;
% end
% end
% 
% 
% type=[0,42,84,126,168,210,255];
% k=1;
% for i=1:N
%     for j=1:N
%        new_image1(i,j)=type(1,c(k,1));  
%        k=k+1;
%     end
% end
% figure(2);imshow(uint8(new_image1));
% title('Window size = 25 Texture Segmentation using k-means');
% u(1,:)=Rx_t(510*30+90,:);
% u(2,:)=Rx_t(510*40+255,:);
% u(3,:)=Rx_t(510*150+35,:);
% u(4,:)=Rx_t(510*150+458,:);
% u(5,:)=Rx_t(510*255+255,:);
% u(6,:)=Rx_t(510*455+90,:);
% u(7,:)=Rx_t(510*455+419,:);
% 
% idx=kmeans(data,7,'Start',u);

idx=kmeans(data,7);
type=[0,42,84,126,168,210,255];
k=1;
for i=1:N
    for j=1:N
       new_image(i,j)=type(1,idx(k,1));  
       k=k+1;
    end
end
figure(3);imshow(uint8(new_image));
title('Window size = 25 Texture Segmentation using k-means');


[coeff,score]=pca(data);
Rx_t=score*coeff';
cluster_count=7;
dim=7;
% u_pca(1,:)=Rx_t(510*30+90,1:dim);
% u_pca(2,:)=Rx_t(510*40+255,1:dim);
% u_pca(3,:)=Rx_t(510*150+35,1:dim);
% u_pca(4,:)=Rx_t(510*150+458,1:dim);
% u_pca(5,:)=Rx_t(510*255+255,1:dim);
% u_pca(6,:)=Rx_t(510*455+90,1:dim);
% u_pca(7,:)=Rx_t(510*455+419,1:dim);
% 
% flag=true;
% iteration_count=0;
% while(flag)
% temp_pca=u_pca;
%  for i=1:length(data)
%      for j=1:cluster_count
%        ca(1,j)=sqrt(sum((Rx_t(i,1:dim)-u_pca(j,1:dim)).^2));
%      end
%     [d(i,1),c(i,1)]=min(ca);
%     
%  end
% 
%  u_pca=zeros(cluster_count,dim);
% for j=1:cluster_count
%     count=0;
%    for i=1:length(data)
%      if(c(i,1)==j)
%         count=count+1;
%         u_pca(j,:)=u_pca(j,:)+Rx_t(i,1:dim);
%      end
%    end
%    if(count~=0)
%     u_pca(j,:)=u_pca(j,:)./count;
%    end
% end
% 
% check_pca=temp_pca-u_pca;
% iteration_count=iteration_count+1;
% if((sum(sum(abs(check_pca)))==0) || (iteration_count==100))
%     flag=false;
% end
% end
% 
% 
% type=[0,42,84,126,168,210,255];
% k=1;
% for i=1:N
%     for j=1:N
%        new_image2(i,j)=type(1,c(k,1));  
%        k=k+1;
%     end
% end
% figure(4);imshow(uint8(new_image2));
% title('Window size = 25,reduced dimension=7 Texture Segmentation using k-means,PCA');
% 
% idx=kmeans(Rx_t,7,'Start',u);
idx=kmeans(Rx_t(:,1:dim),7);
type=[0,42,84,126,168,210,255];
k=1;
for i=1:N
    for j=1:N
       new_image3(i,j)=type(1,idx(k,1));  
       k=k+1;
    end
end
figure(5);imshow(uint8(new_image3));
title('Window size = 25,reduced dimension=7 Texture Segmentation using k-means,PCA');







