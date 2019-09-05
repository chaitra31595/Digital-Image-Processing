fin=fopen('lighthouse.raw','r');
I=fread(fin,512*512,'uint8=>uint8'); 
image=reshape(I,512,512)';
N=512;
figure(1);
imshow(image);
fin=fopen('lighthouse1.raw','r');
I=fread(fin,256*256,'uint8=>uint8'); 
image1=reshape(I,256,256)';
figure(2);
imshow(image1);
fin=fopen('lighthouse2.raw','r');
I=fread(fin,256*256,'uint8=>uint8'); 
image2=reshape(I,256,256)';
figure(3);
imshow(image2);
fin=fopen('lighthouse3.raw','r');
I=fread(fin,256*256,'uint8=>uint8'); 
image3=reshape(I,256,256)';
figure(4);
imshow(image3);
N1=256;
output_image_to_cartesian_conv=[0 1 -0.5;-1 0 (N1+0.5);0 0 1];
input_image_to_cartesian_conv=[0 1 -0.5;-1 0 (N1+0.5);0 0 1];
[P1,Q1,P2,Q2,P3,Q3,P4,Q4,theta,centre_point,width,height]=coordinate_extraction1(N1,image1);
theta1=theta+(3*pi/2);
xy_pos_centre_point=output_image_to_cartesian_conv*[centre_point(1,1);centre_point(1,2);1];
xy_centre=output_image_to_cartesian_conv*[0.5*N1;0.5*N1;1];
G1=correction_angle_scaling(image1,theta1,xy_pos_centre_point,xy_centre,N1,width,height);
figure(5)
imshow(uint8(G1));

[P1,Q1,P2,Q2,P3,Q3,P4,Q4,theta,centre_point,width,height]=coordinate_extraction1(N1,image2);
theta1=theta+(pi);
xy_pos_centre_point=output_image_to_cartesian_conv*[centre_point(1,1);centre_point(1,2);1];
xy_centre=output_image_to_cartesian_conv*[0.5*N1;0.5*N1;1];
G2=correction_angle_scaling(image2,theta1,xy_pos_centre_point,xy_centre,N1,width,height);
figure(6)
imshow(uint8(G2));
 
[P1,Q1,P2,Q2,P3,Q3,P4,Q4,theta,centre_point,width,height]=coordinate_extraction1(N1,image3);
theta1=theta;
xy_pos_centre_point=output_image_to_cartesian_conv*[centre_point(1,1);centre_point(1,2);1];
xy_centre=output_image_to_cartesian_conv*[0.5*N1;0.5*N1;1];
G3=correction_angle_scaling(image3,theta1,xy_pos_centre_point,xy_centre,N1,width,height);
figure(7)
imshow(uint8(G3));

m=1;
for i=1:N
    for j=1:N
        if(image(i,j)==255)
          if((j+160)<512 && (i+160)<512)
            if(isequal(image(i:i+159,j:j+159),255*ones(160,160)))
                    top_left(m,:)=[i,j];
                    m=m+1; 
            end
          end
        end
    end
end

G=image;
%centre of the image is 128.5,128.5, since the image should be 160*160, the
%co-ordinate should be 128.5-80=48.5 which is equivalent to taking starting
%from 48,48
G(top_left(1,1):top_left(1,1)+159,top_left(1,2):top_left(1,2)+159)=G2(48:48+159,48:48+159);
G(top_left(2,1):top_left(2,1)+159,top_left(2,2):top_left(2,2)+159)=G1(48:48+159,48:48+159);
G(top_left(3,1):top_left(3,1)+159,top_left(3,2):top_left(3,2)+159)=G3(48:48+159,48:48+159);
figure(8);
imshow(uint8(G));





