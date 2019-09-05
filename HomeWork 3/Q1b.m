fin=fopen('hat.raw','r');
I=fread(fin,512*512,'uint8=>uint8'); 
image=reshape(I,512,512)';
figure(1);
imshow(image);
N=512;
output_image_to_cartesian_conv=[0 1 -0.5;-1 0 (N+0.5);0 0 1];
input_image_to_cartesian_conv=[0 1 -0.5;-1 0 (N+0.5);0 0 1];

pos_1=output_image_to_cartesian_conv*[1;1;1];
pos_2=output_image_to_cartesian_conv*[128;0.5*(N+1);1];
pos_3=output_image_to_cartesian_conv*[1;N;1];
pos_4=output_image_to_cartesian_conv*[0.5*(1+0.5*(N+1));0.5*(1+0.5*(N+1));1];
pos_5=output_image_to_cartesian_conv*[0.5*(1+0.5*(N+1));0.5*(N+0.5*(N+1));1];
pos_6=output_image_to_cartesian_conv*[0.5*(N+1);0.5*(N+1);1];

A(:,1)=[1 pos_1(1,1) pos_1(2,1) (pos_1(1,1)).^2  pos_1(1,1)*pos_1(2,1) (pos_1(2,1)).^2]'; 
A(:,2)=[1 pos_2(1,1) pos_2(2,1) (pos_2(1,1)).^2  pos_2(1,1)*pos_2(2,1) (pos_2(2,1)).^2]';
A(:,3)=[1 pos_3(1,1) pos_3(2,1) (pos_3(1,1)).^2  pos_3(1,1)*pos_3(2,1) (pos_3(2,1)).^2]';
A(:,4)=[1 pos_4(1,1) pos_4(2,1) (pos_4(1,1)).^2  pos_4(1,1)*pos_4(2,1) (pos_4(2,1)).^2]';
A(:,5)=[1 pos_5(1,1) pos_5(2,1) (pos_5(1,1)).^2  pos_5(1,1)*pos_5(2,1) (pos_5(2,1)).^2]';
A(:,6)=[1 pos_6(1,1) pos_6(2,1) (pos_6(1,1)).^2  pos_6(1,1)*pos_6(2,1) (pos_6(2,1)).^2]';

pos_1=input_image_to_cartesian_conv*[1;1;1];
pos_2=input_image_to_cartesian_conv*[1;0.5*(N+1);1];
pos_3=input_image_to_cartesian_conv*[1;N;1];
pos_4=input_image_to_cartesian_conv*[0.5*(1+0.5*(N+1));0.5*(1+0.5*(N+1));1];
pos_5=input_image_to_cartesian_conv*[0.5*(1+0.5*(N+1));0.5*(N+0.5*(N+1));1];
pos_6=input_image_to_cartesian_conv*[0.5*(N+1);0.5*(N+1);1];

u=[ pos_1(1,1) pos_2(1,1) pos_3(1,1) pos_4(1,1) pos_5(1,1) pos_6(1,1) ]'; 
v=[ pos_1(2,1) pos_2(2,1) pos_3(2,1) pos_4(2,1) pos_5(2,1) pos_6(2,1) ]';
a=pinv(A')*u;
b=pinv(A')*v;

A1=[a';b'];

%a
pos_1=output_image_to_cartesian_conv*[1;1;1];
pos_2=output_image_to_cartesian_conv*[0.5*(N+1);128;1];
pos_3=output_image_to_cartesian_conv*[N;1;1];
pos_4=output_image_to_cartesian_conv*[0.5*(1+0.5*(N+1));0.5*(1+0.5*(N+1));1];
pos_5=input_image_to_cartesian_conv*[0.5*(N+0.5*(N+1));0.5*(1+0.5*(N+1));1];
pos_6=output_image_to_cartesian_conv*[0.5*(N+1);0.5*(N+1);1];

A(:,1)=[1 pos_1(1,1) pos_1(2,1) (pos_1(1,1)).^2  pos_1(1,1)*pos_1(2,1) (pos_1(2,1)).^2]'; 
A(:,2)=[1 pos_2(1,1) pos_2(2,1) (pos_2(1,1)).^2  pos_2(1,1)*pos_2(2,1) (pos_2(2,1)).^2]';
A(:,3)=[1 pos_3(1,1) pos_3(2,1) (pos_3(1,1)).^2  pos_3(1,1)*pos_3(2,1) (pos_3(2,1)).^2]';
A(:,4)=[1 pos_4(1,1) pos_4(2,1) (pos_4(1,1)).^2  pos_4(1,1)*pos_4(2,1) (pos_4(2,1)).^2]';
A(:,5)=[1 pos_5(1,1) pos_5(2,1) (pos_5(1,1)).^2  pos_5(1,1)*pos_5(2,1) (pos_5(2,1)).^2]';
A(:,6)=[1 pos_6(1,1) pos_6(2,1) (pos_6(1,1)).^2  pos_6(1,1)*pos_6(2,1) (pos_6(2,1)).^2]';

pos_1=input_image_to_cartesian_conv*[1;1;1];
pos_2=input_image_to_cartesian_conv*[0.5*(N+1);1;1];
pos_3=input_image_to_cartesian_conv*[N;1;1];
pos_4=input_image_to_cartesian_conv*[0.5*(1+0.5*(N+1));0.5*(1+0.5*(N+1));1];
pos_5=input_image_to_cartesian_conv*[0.5*(N+0.5*(N+1));0.5*(1+0.5*(N+1));1];
pos_6=input_image_to_cartesian_conv*[0.5*(N+1);0.5*(N+1);1];

u=[ pos_1(1,1) pos_2(1,1) pos_3(1,1) pos_4(1,1) pos_5(1,1) pos_6(1,1) ]'; 
v=[ pos_1(2,1) pos_2(2,1) pos_3(2,1) pos_4(2,1) pos_5(2,1) pos_6(2,1) ]';
a=pinv(A')*u;
b=pinv(A')*v;

A2=[a';b'];

%b

pos_1=output_image_to_cartesian_conv*[1;N;1];
pos_2=output_image_to_cartesian_conv*[0.5*(N+1);N-128;1];
pos_3=output_image_to_cartesian_conv*[N;N;1];
pos_4=output_image_to_cartesian_conv*[0.5*(1+0.5*(N+1));0.5*(N+0.5*(N+1));1];
pos_5=input_image_to_cartesian_conv*[0.5*(N+0.5*(N+1));0.5*(N+0.5*(N+1));1];
pos_6=output_image_to_cartesian_conv*[0.5*(N+1);0.5*(N+1);1];

A(:,1)=[1 pos_1(1,1) pos_1(2,1) (pos_1(1,1)).^2  pos_1(1,1)*pos_1(2,1) (pos_1(2,1)).^2]'; 
A(:,2)=[1 pos_2(1,1) pos_2(2,1) (pos_2(1,1)).^2  pos_2(1,1)*pos_2(2,1) (pos_2(2,1)).^2]';
A(:,3)=[1 pos_3(1,1) pos_3(2,1) (pos_3(1,1)).^2  pos_3(1,1)*pos_3(2,1) (pos_3(2,1)).^2]';
A(:,4)=[1 pos_4(1,1) pos_4(2,1) (pos_4(1,1)).^2  pos_4(1,1)*pos_4(2,1) (pos_4(2,1)).^2]';
A(:,5)=[1 pos_5(1,1) pos_5(2,1) (pos_5(1,1)).^2  pos_5(1,1)*pos_5(2,1) (pos_5(2,1)).^2]';
A(:,6)=[1 pos_6(1,1) pos_6(2,1) (pos_6(1,1)).^2  pos_6(1,1)*pos_6(2,1) (pos_6(2,1)).^2]';

pos_1=input_image_to_cartesian_conv*[1;N;1];
pos_2=input_image_to_cartesian_conv*[0.5*(N+1);N;1];
pos_3=input_image_to_cartesian_conv*[N;N;1];
pos_4=input_image_to_cartesian_conv*[0.5*(1+0.5*(N+1));0.5*(N+0.5*(N+1));1];
pos_5=input_image_to_cartesian_conv*[0.5*(N+0.5*(N+1));0.5*(N+0.5*(N+1));1];
pos_6=input_image_to_cartesian_conv*[0.5*(N+1);0.5*(N+1);1];

u=[ pos_1(1,1) pos_2(1,1) pos_3(1,1) pos_4(1,1) pos_5(1,1) pos_6(1,1) ]'; 
v=[ pos_1(2,1) pos_2(2,1) pos_3(2,1) pos_4(2,1) pos_5(2,1) pos_6(2,1) ]';
a=pinv(A')*u;
b=pinv(A')*v;

A3=[a';b'];

%d

pos_1=output_image_to_cartesian_conv*[N;1;1];
pos_2=output_image_to_cartesian_conv*[(N-128);0.5*(N+1);1];
pos_3=output_image_to_cartesian_conv*[N;N;1];
pos_4=output_image_to_cartesian_conv*[0.5*(N+0.5*(N+1));0.5*(1+0.5*(N+1));1];
pos_5=input_image_to_cartesian_conv*[0.5*(N+0.5*(N+1));0.5*(N+0.5*(N+1));1];
pos_6=output_image_to_cartesian_conv*[0.5*(N+1);0.5*(N+1);1];

A(:,1)=[1 pos_1(1,1) pos_1(2,1) (pos_1(1,1)).^2  pos_1(1,1)*pos_1(2,1) (pos_1(2,1)).^2]'; 
A(:,2)=[1 pos_2(1,1) pos_2(2,1) (pos_2(1,1)).^2  pos_2(1,1)*pos_2(2,1) (pos_2(2,1)).^2]';
A(:,3)=[1 pos_3(1,1) pos_3(2,1) (pos_3(1,1)).^2  pos_3(1,1)*pos_3(2,1) (pos_3(2,1)).^2]';
A(:,4)=[1 pos_4(1,1) pos_4(2,1) (pos_4(1,1)).^2  pos_4(1,1)*pos_4(2,1) (pos_4(2,1)).^2]';
A(:,5)=[1 pos_5(1,1) pos_5(2,1) (pos_5(1,1)).^2  pos_5(1,1)*pos_5(2,1) (pos_5(2,1)).^2]';
A(:,6)=[1 pos_6(1,1) pos_6(2,1) (pos_6(1,1)).^2  pos_6(1,1)*pos_6(2,1) (pos_6(2,1)).^2]';

pos_1=input_image_to_cartesian_conv*[N;1;1];
pos_2=input_image_to_cartesian_conv*[N;0.5*(N+1);1];
pos_3=input_image_to_cartesian_conv*[N;N;1];
pos_4=input_image_to_cartesian_conv*[0.5*(N+0.5*(N+1));0.5*(1+0.5*(N+1));1];
pos_5=input_image_to_cartesian_conv*[0.5*(N+0.5*(N+1));0.5*(N+0.5*(N+1));1];
pos_6=input_image_to_cartesian_conv*[0.5*(N+1);0.5*(N+1);1];

u=[ pos_1(1,1) pos_2(1,1) pos_3(1,1) pos_4(1,1) pos_5(1,1) pos_6(1,1) ]'; 
v=[ pos_1(2,1) pos_2(2,1) pos_3(2,1) pos_4(2,1) pos_5(2,1) pos_6(2,1) ]';
a=pinv(A')*u;
b=pinv(A')*v;

A4=[a';b'];

F=zeros(N,N);
for J=1:512
    for K=1:512
        xy_pos=output_image_to_cartesian_conv*[J;K;1];
        if(J>=K && (K<=(N-J+1)))
            updated_A=A2;
        elseif(J>=K && (K>=(N-J+1)))
            updated_A=A4;
        elseif(J<=K && (K<=(N-J+1)))
            updated_A=A1;
        else
            updated_A=A3;
        end
        uv_pos=updated_A*[1 xy_pos(1,1) xy_pos(2,1) (xy_pos(1,1).^2)  xy_pos(1,1)*xy_pos(2,1) (xy_pos(2,1).^2)]';
        PQ_pos=pinv(input_image_to_cartesian_conv)*[uv_pos(1,1) uv_pos(2,1) 1]';
        if((PQ_pos(1,1))>=1 && (PQ_pos(1,1))<=N && (PQ_pos(2,1))>=1 && (PQ_pos(2,1)<=N))
         F(J,K)=bilinear_interpolation1(uint8(image),(PQ_pos),N);
        else
         F(J,K)=0;
        end  
    end
end         
   
figure(2);
imshow(uint8(F));