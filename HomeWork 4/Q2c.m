N=56;
% run('C:\Users\lenovo\Downloads\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup.m');
fin=fopen('one_1-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
one1=reshape(I,N,N);
figure(1);
imshow(one1);
N=56;
fin=fopen('one_2-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
one2=reshape(I,N,N);
figure(2);
imshow(one2);
N=56;
fin=fopen('one_3-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
one3=reshape(I,N,N);
figure(3);
imshow(one3);
N=56;
fin=fopen('one_4-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
one4=reshape(I,N,N);
figure(4);
imshow(one4);
N=56;
fin=fopen('one_5-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
one5=reshape(I,N,N);
figure(5);
imshow(one5);
N=56;
fin=fopen('zero_1-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
zero1=reshape(I,N,N);
figure(6);
imshow(zero1);
fin=fopen('zero_2-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
zero2=reshape(I,N,N);
figure(7);
imshow(zero2);
N=56;
fin=fopen('zero_3-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
zero3=reshape(I,N,N);
figure(8);
imshow(zero3);
N=56;
fin=fopen('zero_4-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
zero4=reshape(I,N,N);
figure(9);
imshow(zero4);
fin=fopen('zero_5-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
zero5=reshape(I,N,N);
figure(10);
imshow(zero5);
fin=fopen('eight-1.raw','r');
I=fread(fin,N*N,'uint8=>uint8');
eight=reshape(I,N,N);
figure(11);
imshow(eight);

Ia=single(one1);
[fa1_1, da1_1] = vl_sift(Ia) ;
Ia=single(one2);
[fa1_2, da1_2] = vl_sift(Ia) ;
Ia=single(one3);
[fa1_3, da1_3] = vl_sift(Ia) ;
Ia=single(one4);
[fa1_4, da1_4] = vl_sift(Ia) ;
Ia=single(one5);
[fa1_5, da1_5] = vl_sift(Ia) ;
Ia=single(zero1);
[fa0_1, da0_1] = vl_sift(Ia) ;
Ia=single(zero2);
[fa0_2, da0_2] = vl_sift(Ia) ;
Ia=single(zero3);
[fa0_3, da0_3] = vl_sift(Ia) ;
Ia=single(zero4);
[fa0_4, da0_4] = vl_sift(Ia) ;
Ia=single(zero5);
[fa0_5, da0_5] = vl_sift(Ia) ;
Ia=single(eight);
[fa8, da8] = vl_sift(Ia) ;


 D=[da0_1';da0_2';da0_3';da0_4';da0_5';da1_1';da1_2';da1_3';da1_4';da1_5'];
 
 [IDX, C] = kmeans(double(D), 2);
 
 [m,n]=size(da8);
 count0=0;
 count1=0;
 data=double(da8');
 for i=1:n
      dist1(i,:)=sqrt(sum((data(i,:)-C(1,:)).^2));
      dist2(i,:)=sqrt(sum((data(i,:)-C(2,:)).^2));
      if(dist1(i,:)<dist2(i,:))
          label(i,1)=0;
          count0=count0+1;
      else
          label(i,1)=1;
          count1=count1+1;
      end
 end
 
 figure(12);
 histogram(label);
 xlabel('Labels');
 ylabel('Frequency');
 title('Histogram of Bag of Words for ''eight''');