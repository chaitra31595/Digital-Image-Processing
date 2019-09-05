run('C:\Users\lenovo\Downloads\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup.m');
fin=fopen('river1.raw','r');
Data=fread(fin,[768*3 1024],'uint8=>uint8');
Red=Data(1:3:2302,:);
Green=Data(2:3:2303,:);
Blue=Data(3:3:2304,:);
RGB_ori(:,:,1)=Red;
RGB_ori(:,:,2)=Green;
RGB_ori(:,:,3)=Blue;
Im1=RGB_ori;
figure(1);
imshow(Im1);
fin=fopen('river2.raw','r');
Data=fread(fin,[768*3 1024],'uint8=>uint8');
Red=Data(1:3:2302,:);
Green=Data(2:3:2303,:);
Blue=Data(3:3:2304,:);
RGB_ori(:,:,1)=Red;
RGB_ori(:,:,2)=Green;
RGB_ori(:,:,3)=Blue;
Im2=RGB_ori;
Ia=single(rgb2gray(Im1));
[fa, da] = vl_sift(Ia) ;
 perm = randperm(size(fa,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(fa(:,sel)) ;
h2 = vl_plotframe(fa(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(da(:,sel),fa(:,sel)) ;
set(h3,'color','g') ;
figure(2);
imshow(Im2);
Ib=single(rgb2gray(Im2));
[fb, db] = vl_sift(Ib) ;
perm = randperm(size(fb,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(fb(:,sel)) ;
h2 = vl_plotframe(fb(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(db(:,sel),fb(:,sel)) ;
set(h3,'color','g') ;
 
% [matches, scores] = vl_ubcmatch(da, db);
% 
% figure(3) ; clf ;
% imagesc(cat(2, Im1, Im2)) ;
% 
% xa = fa(1,matches(1,:)) ;
% xb = fb(1,matches(2,:)) + size(Im1,2) ;
% ya = fa(2,matches(1,:)) ;
% yb = fb(2,matches(2,:)) ;
% 
% hold on ;
% h = line([xa ; xb], [ya ; yb]) ;
% set(h,'linewidth', 1, 'color', 'b') ;
% 
% vl_plotframe(fa(:,matches(1,:))) ;
% fb(1,:) = fb(1,:) + size(Im1,2) ;
% vl_plotframe(fb(:,matches(2,:))) ;
% axis image off ;

% [value,index]=max(fa(3,:));
% 
% [m,n]=size(db);
% d1=double(db');
% d2=double(da');
% for i=1:n
%     dist(i,:)=sqrt(sum((d1(i,:)-d2(index,:)).^2));
% end
% [value,index1]=min(dist);
% 
% figure(4) ; clf ;
% imagesc(cat(2, Im1, Im2)) ;
% 
% xa = fa_sorted(1,index) ;
% xb = fb_sorted(1,index1) + size(Im1,2) ;
% ya = fa_sorted(2,index) ;
% yb = fb_sorted(2,index1) ;
% hold on ;
% h = line([xa ; xb], [ya ; yb]) ;
% set(h,'linewidth', 1, 'color', 'b') ;
% vl_plotframe(fa(:,matches(1,:))) ;
% fb(1,:) = fb(1,:) + size(Im1,2) ;
% vl_plotframe(fb(:,matches(2,:))) ;
% axis image off ;

% 
% [fa_sorted_scale,ind]=sort(fa(3,:),'descend');
% fa_sorted=fa(:,ind);
% da_sorted=da(:,ind);
% [fb_sorted_scale,ind]=sort(fb(3,:),'descend');
% fb_sorted=fb(:,ind);
% db_sorted=db(:,ind);

[m,n]=size(da);
d1=double(da');
for i=1:n
    l2(i,:)=sqrt(sum((d1(i,:).^2)));
end
[value,index]=max(l2);

[m,n]=size(db);
d1=double(db');
d2=double(da');
for i=1:n
    dist(i,:)=sqrt(sum((d1(i,:)-d2(index,:)).^2));
end
[value,ind]=min(dist);

figure(5) ; clf ;
imagesc(cat(2, Im1, Im2)) ;
xa = fa(1,index) ;
xb = fb(1,ind) + size(Im1,2) ;
ya = fa(2,index) ;
yb = fb(2,ind) ;
hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;
% h1 = vl_plotframe(fa(:,index)) ;
% h2 = vl_plotframe(fb(:,ind)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% h3 = vl_plotsiftdescriptor(da(:,index),fa(:,index)) ;
% h4 = size(Im1,2)+ vl_plotsiftdescriptor(db(:,ind),fb(:,ind)) ;

% set(h3,'color','g') ;
% set(h4,'color','g') ;

figure(6);
subplot(1,2,1);
imshow(Im1);
h1 = vl_plotframe(fa(:,index)) ;
set(h1,'color','k','linewidth',3) ;
h3 = vl_plotsiftdescriptor(da(:,index),fa(:,index)) ;

subplot(1,2,2);
imshow(Im2);
h1 = vl_plotframe(fb(:,ind)) ;
set(h1,'color','k','linewidth',3) ;
h3 = vl_plotsiftdescriptor(db(:,ind),fb(:,ind)) ;




