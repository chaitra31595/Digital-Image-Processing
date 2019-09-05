
rose_bright=readraw1("rose_bright.raw");
rose_dark=readraw1("rose_dark.raw");
rose_mix=readraw1("rose_mix.raw");
N=400;
%Transfer function based histogram equalization
X=0:255;
for i=0:255
    count1=0;
    count2=0;
    count3=0;
    for j=1:N
        for k=1:N
            if(rose_bright(j,k)==i)
                count1=count1+1;
            end
            if(rose_dark(j,k)==i)
                count2=count2+1;
            end
            if(rose_mix(j,k)==i)
                count3=count3+1;
            end
        end
    end
    
   Y1(1,i+1)=count1;
   Y2(1,i+1)=count2;
   Y3(1,i+1)=count3;    
end


Probability1=Y1/(N*N);
CDF1(1,1)=Probability1(1,1);
Probability2=Y2/(N*N);
CDF2(1,1)=Probability2(1,1);
Probability3=Y3/(N*N);
CDF3(1,1)=Probability3(1,1);
for i=2:256
    CDF1(1,i)=CDF1(1,i-1)+Probability1(1,i);
    CDF2(1,i)=CDF2(1,i-1)+Probability2(1,i);
    CDF3(1,i)=CDF3(1,i-1)+Probability3(1,i);
end
HS1=floor(CDF1*255);
HS2=floor(CDF2*255);
HS3=floor(CDF3*255);
figure(1)
subplot 311
plot(X,CDF1);
title('Transfer function after Histogram equalization for rose bright');
xlabel('Pixel intensity');
ylabel('CDF');
figure(1)
subplot 312
plot(X,CDF2);
title('Transfer function after Histogram equalization for rose dark');
xlabel('Pixel intensity');
ylabel('CDF');
figure(1)
subplot 313
plot(X,CDF3);
title('Transfer function after Histogram equalization for rose mix');
xlabel('Pixel intensity');
ylabel('CDF');

for k=1:256
    for i=1:N
        for j=1:N
            if(rose_bright(i,j)==k-1)
                rose_bright_hist(i,j)=HS1(1,k);
            end
            if(rose_dark(i,j)==k-1)
                rose_dark_hist(i,j)=HS2(1,k);
            end
            if(rose_mix(i,j)==k-1)
                rose_mix_hist(i,j)=HS3(1,k);
            end
        end
    end
end

figure(2);
imshow(uint8(rose_bright_hist));
title('Transfer function based Histogram equalization enhanced image for rose bright');
figure(3);
imshow(uint8(rose_dark_hist));
title('Transfer function based Histogram equalization enhanced image for rose dark');
figure(4);
imshow(uint8(rose_mix_hist));
title('Transfer function based Histogram equalization enhanced image for rose mix');

for i=0:255
    count1=0;
    count2=0;
    count3=0;
    for j=1:N
        for k=1:N
            if(rose_bright_hist(j,k)==i)
                count1=count1+1;
            end
            if(rose_dark_hist(j,k)==i)
                count2=count2+1;
            end
            if(rose_mix_hist(j,k)==i)
                count3=count3+1;
            end
        end
    end
    
   Y1_hist(1,i+1)=count1;
   Y2_hist(1,i+1)=count2;
   Y3_hist(1,i+1)=count3;    
end
Probability1=Y1_hist/(N*N);
CDF1(1,1)=Probability1(1,1);
Probability2=Y2_hist/(N*N);
CDF2(1,1)=Probability2(1,1);
Probability3=Y3_hist/(N*N);
CDF3(1,1)=Probability3(1,1);
for i=2:256
    CDF1(1,i)=CDF1(1,i-1)+Probability1(1,i);
    CDF2(1,i)=CDF2(1,i-1)+Probability2(1,i);
    CDF3(1,i)=CDF3(1,i-1)+Probability3(1,i);
end
figure(5)
plot(X,CDF1);
title('Transfer function after Histogram equalization for rose bright');
xlabel('Pixel intensity');
ylabel('CDF');
figure(6)
plot(X,CDF2);
title('Transfer function after Histogram equalization for rose dark');
xlabel('Pixel intensity');
ylabel('CDF');
figure(7)
plot(X,CDF3);
title('Transfer function after Histogram equalization for rose mix');
xlabel('Pixel intensity');
ylabel('CDF');

% figure(8)
% subplot 311
% stem(X,Y1_bkt);
% title('Transfer function Histogram for rose bright');
% xlabel('Pixel intensity');
% ylabel('Frequency/Count');
% subplot 312
% stem(X,Y2_bkt);
% title('Transfer function Histogram for rose dark');
% xlabel('Pixel intensity');
% ylabel('Frequency/Count');
% subplot 313
% stem(X,Y3_bkt);
% title('Transfer function Histogram for rose mix');
% xlabel('Pixel intensity');
% ylabel('Frequency/Count');


% Bucket filling method
% Case 1: rose_bright
rose_bright_bkt=rose_bright;
bucket_size=256;
n=(N*N)/bucket_size; %number of pixel per bucket
Y_upd=Y1;
for i=256:-1:1
     if((Y_upd(1,i))> n)
          for m=256:-1:1
              if(Y_upd(1,i)>n && Y_upd(1,m)<n)
                  c=Y_upd(1,i)-n-Y_upd(1,m);
                  for j=N:-1:1
                       for k=N:-1:1
                            if(rose_bright_bkt(j,k)==(i-1) && Y_upd(1,i)>n && Y_upd(1,m)<n)
                               rose_bright_bkt(j,k)=(m-1);
                               Y_upd(1,m)=Y_upd(1,m)+1;
                               Y_upd(1,i)=Y_upd(1,i)-1;
                            end
                       end
                  end                   
              end
          end
     end
end

figure(9);
imshow(uint8(rose_bright_bkt));
title('Cumulative Probability based Histogram equalization for rose bright (Bucket filling)');

%Case 2: rose_dark
rose_dark_bkt=rose_dark;
bucket_size=256;
n=(N*N)/bucket_size; %number of pixel per bucket
Y_upd=Y2;
for i=256:-1:1
     if((Y_upd(1,i))> n)
          for m=256:-1:1
              if(Y_upd(1,i)>n && Y_upd(1,m)<n)
                  c=Y_upd(1,i)-n-Y_upd(1,m);
                  for j=N:-1:1
                       for k=N:-1:1
                            if(rose_dark_bkt(j,k)==(i-1) && Y_upd(1,i)>n && Y_upd(1,m)<n)
                               rose_dark_bkt(j,k)=(m-1);
                               Y_upd(1,m)=Y_upd(1,m)+1;
                               Y_upd(1,i)=Y_upd(1,i)-1;
                            end
                       end
                  end                   
              end
          end
     end
end

figure(10);
imshow(uint8(rose_dark_bkt));
title('Cumulative Probability based Histogram equalization for rose dark (Bucket filling)');


%Case 3: rose_mix
rose_mix_bkt=rose_dark;
bucket_size=256;
n=(N*N)/bucket_size; %number of pixel per bucket
Y_upd=Y3;
for i=256:-1:1
     if((Y_upd(1,i))> n)
          for m=256:-1:1
              if(Y_upd(1,i)>n && Y_upd(1,m)<n)
                  c=Y_upd(1,i)-n-Y_upd(1,m);
                  for j=N:-1:1
                       for k=N:-1:1
                            if(rose_mix_bkt(j,k)==(i-1) && Y_upd(1,i)>n && Y_upd(1,m)<n)
                               rose_mix_bkt(j,k)=(m-1);
                               Y_upd(1,m)=Y_upd(1,m)+1;
                               Y_upd(1,i)=Y_upd(1,i)-1;
                            end
                       end
                  end                   
              end
          end
     end
end

figure(11);
imshow(uint8(rose_mix_bkt));
title('Cumulative Probability based Histogram equalization for rose mix (Bucket filling)');

X=0:255;
for i=0:255
    count1=0;
    count2=0;
    count3=0;
    for j=1:N
        for k=1:N
            if(rose_bright_bkt(j,k)==i)
                count1=count1+1;
            end
            if(rose_dark_bkt(j,k)==i)
                count2=count2+1;
            end
            if(rose_mix_bkt(j,k)==i)
                count3=count3+1;
            end
        end
    end
    
   Y1_bkt(1,i+1)=count1;
   Y2_bkt(1,i+1)=count2;
   Y3_bkt(1,i+1)=count3;    
end

% figure(12)
% subplot 311
% stem(X,Y1_bkt);
% title('Cumulative Probability Histogram for rose bright');
% xlabel('Pixel intensity');
% ylabel('Frequency/Count');
% % subplot 312
% stem(X,Y2_bkt);
% title('Cumulative Probability Histogram for rose dark');
% xlabel('Pixel intensity');
% ylabel('Frequency/Count');
% subplot 313
% stem(X,Y3_bkt);
% title('Cumulative Probability Histogram for rose mix');
% xlabel('Pixel intensity');
% ylabel('Frequency/Count');


%%Another method
% rose_bright_bkt1=rose_bright;
% bucket_size=256;
% n=(N*N)/bucket_size; %number of pixel per bucket
% Y_upd1=Y1;
% for i=2:256
%     c1=Y_upd1(1,i)-n;   
%     for j=1:1:N
%         for k=1:N:N
%            if(rose_bright_bkt1(j,k)==(i-1) && Y_upd1(1,i)>n )
%                  rose_bright_bkt1(j,k)=(i-2);
%                  Y_upd1(1,i)=Y_upd1(1,i)-1;
%                  Y_upd1(1,i-1)=Y_upd1(1,i-1)+1;
%                  c=c-1;
%            end
%         end    
%     end    
% end
%        
% 
% figure(10);
% imshow(uint8(rose_bright_bkt1));
%  title('Cumulative Probability based Histogram equalization for rose bright (Bucket filling)');