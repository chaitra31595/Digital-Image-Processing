f = fopen('bird.raw','r');
Data=fread(f,[500*3 375],'*uint8');
fclose(f);
Red=Data(1:3:1498,:)';
Green=Data(2:3:1499,:)';
Blue=Data(3:3:1500,:)';
RGB_ori(:,:,1)=Red;
RGB_ori(:,:,2)=Green;
RGB_ori(:,:,3)=Blue;
figure(1)
imshow(uint8(RGB_ori));
title('Original Image');
C = 255*ones(375,500) - (double(Red));
M = 255*ones(375,500) - (double(Green));
Y = 255*ones(375,500) - (double(Blue));
[height width]=size(C);
b=zeros(height,width);
F_cap=C;
for i=1:height    
    if(mod(i,2)~=0)
     if i~=height
       for j=1:width
           if (F_cap(i,j)>127)
               b(i,j)=255;
           else
               b(i,j)=0;
           end
           e=F_cap(i,j)-b(i,j);
           if j==1 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(1/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
           elseif j==width              
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(3/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
           else 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(3/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(1/16)*e;
           end       
       end
     else
         for j=1:width
               if (F_cap(i,j)>127)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if j~=width
                   F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               end     
         end
     end
    else
        if i~=height
            for j=width:-1:1
                if (F_cap(i,j)>127)
                    b(i,j)=255;
                else
                    b(i,j)=0;
                end
                e=F_cap(i,j)-b(i,j);
               if j==width
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(1/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               elseif j==1
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(3/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               else
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(1/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(3/16)*e;
               end     
            end
        else
            for j=width:-1:1
               if (F_cap(i,j)>127)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if j~=1
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
               end     
            end
        end
    end
end
C_halftoned=b;
b=zeros(height,width);
F_cap=M;
for i=1:height    
    if(mod(i,2)~=0)
      if i~=height
       for j=1:width
           if (F_cap(i,j)>127)
               b(i,j)=255;
           else
               b(i,j)=0;
           end
           e=F_cap(i,j)-b(i,j);
           if j==1 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(1/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
           elseif j==width              
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(3/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
           else 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(3/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(1/16)*e;
           end       
       end
       else
         for j=1:width
               if (F_cap(i,j)>127)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if j~=width
                   F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               end     
         end
     end
    else
        if i~=height
            for j=width:-1:1
                if (F_cap(i,j)>127)
                    b(i,j)=255;
                else
                    b(i,j)=0;
                end
                e=F_cap(i,j)-b(i,j);
               if j==width
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(1/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               elseif j==1
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(3/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               else
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(1/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(3/16)*e;
               end     
            end
        else
            for j=width:-1:1
               if (F_cap(i,j)>127)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if j~=1
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
               end     
            end
        end
    end
end
M_halftoned=b;
b=zeros(height,width);
F_cap=Y;
for i=1:height    
    if(mod(i,2)~=0)
      if i~=height
       for j=1:width
           if (F_cap(i,j)>127)
               b(i,j)=255;
           else
               b(i,j)=0;
           end
           e=F_cap(i,j)-b(i,j);
           if j==1 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(1/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
           elseif j==width              
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(3/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
           else 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(3/16)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(1/16)*e;
           end       
       end
       else
         for j=1:width
               if (F_cap(i,j)>127)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if j~=width
                   F_cap(i,j+1)=F_cap(i,j+1)+(7/16)*e;
               end     
         end
     end
    else
        if i~=height
            for j=width:-1:1
                if (F_cap(i,j)>127)
                    b(i,j)=255;
                else
                    b(i,j)=0;
                end
                e=F_cap(i,j)-b(i,j);
               if j==width
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(1/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               elseif j==1
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(3/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
               else
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(1/16)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(5/16)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(3/16)*e;
               end     
            end
        else
            for j=width:-1:1
               if (F_cap(i,j)>127)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if j~=1
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
               end     
            end
        end
    end
end
Y_halftoned=b;
RGB_cmy_halftoned(:,:,1)=C_halftoned;
RGB_cmy_halftoned(:,:,2)=M_halftoned;
RGB_cmy_halftoned(:,:,3)=Y_halftoned;
figure(2);
imshow(uint8(RGB_cmy_halftoned));
title('Seperable Error Diffusion : CMY');
RGB_cmy_halftoned1(:,:,1)=255*ones(375,500) - (double(C_halftoned));
figure(4);
imshow(uint8(RGB_cmy_halftoned1(:,:,1)));
title('Seperable Error Diffusion : Red plane');
RGB_cmy_halftoned1(:,:,2)=255*ones(375,500) - (double(M_halftoned));
figure(5);
imshow(uint8(RGB_cmy_halftoned1(:,:,2)));
title('Seperable Error Diffusion : Green plane');
RGB_cmy_halftoned1(:,:,3)=255*ones(375,500) - (double(Y_halftoned));
figure(6);
imshow(uint8(RGB_cmy_halftoned1(:,:,3)));
title('Seperable Error Diffusion : Blue plane');
figure(3)
imshow(uint8(RGB_cmy_halftoned1));
title('Seperable Error Diffusion');


% Problem 2.c.2 MBVQ based Error diffusion

v=zeros(375,500,3);
[height, width]=size(Red);
F_cap_Red=double(Red);
F_cap_Green=double(Green);
F_cap_Blue=double(Blue);
for i=1:height    
    if(mod(i,2)~=0)
      if i~=height
       for j=1:width              
           [mbvq,v]=MBVQ(double(Red(i,j)),double(Green(i,j)),double(Blue(i,j)),F_cap_Red(i,j),F_cap_Green(i,j),F_cap_Blue(i,j));
            b_Red(i,j)=v(1,1,1);
            b_Green(i,j)=v(1,1,2);
            b_Blue(i,j)=v(1,1,3);
           e_Red=F_cap_Red(i,j)-b_Red(i,j);
           e_Green=F_cap_Green(i,j)-b_Green(i,j);
           e_Blue=F_cap_Blue(i,j)-b_Blue(i,j);
           if j==1 
               F_cap_Red(i,j+1)=F_cap_Red(i,j+1)+(7/16)*e_Red;
               F_cap_Red(i+1,j+1)=F_cap_Red(i+1,j+1)+(1/16)*e_Red;
               F_cap_Red(i+1,j)=F_cap_Red(i+1,j)+(5/16)*e_Red;
               F_cap_Green(i,j+1)=F_cap_Green(i,j+1)+(7/16)*e_Green;
               F_cap_Green(i+1,j+1)=F_cap_Green(i+1,j+1)+(1/16)*e_Green;
               F_cap_Green(i+1,j)=F_cap_Green(i+1,j)+(5/16)*e_Green;
               F_cap_Blue(i,j+1)=F_cap_Blue(i,j+1)+(7/16)*e_Blue;
               F_cap_Blue(i+1,j+1)=F_cap_Blue(i+1,j+1)+(1/16)*e_Blue;
               F_cap_Blue(i+1,j)=F_cap_Blue(i+1,j)+(5/16)*e_Blue;               
           elseif j==width              
               F_cap_Red(i+1,j-1)=F_cap_Red(i+1,j-1)+(3/16)*e_Red;
               F_cap_Red(i+1,j)=F_cap_Red(i+1,j)+(5/16)*e_Red;
               F_cap_Green(i+1,j-1)=F_cap_Green(i+1,j-1)+(3/16)*e_Green;
               F_cap_Green(i+1,j)=F_cap_Green(i+1,j)+(5/16)*e_Green;
               F_cap_Blue(i+1,j-1)=F_cap_Blue(i+1,j-1)+(3/16)*e_Blue;
               F_cap_Blue(i+1,j)=F_cap_Blue(i+1,j)+(5/16)*e_Blue;
           else 
               F_cap_Red(i,j+1)=F_cap_Red(i,j+1)+(7/16)*e_Red;
               F_cap_Red(i+1,j-1)=F_cap_Red(i+1,j-1)+(3/16)*e_Red;
               F_cap_Red(i+1,j)=F_cap_Red(i+1,j)+(5/16)*e_Red;
               F_cap_Red(i+1,j+1)=F_cap_Red(i+1,j+1)+(1/16)*e_Red;
               F_cap_Green(i,j+1)=F_cap_Green(i,j+1)+(7/16)*e_Green;
               F_cap_Green(i+1,j-1)=F_cap_Green(i+1,j-1)+(3/16)*e_Green;
               F_cap_Green(i+1,j)=F_cap_Green(i+1,j)+(5/16)*e_Green;
               F_cap_Green(i+1,j+1)=F_cap_Green(i+1,j+1)+(1/16)*e_Green;
               F_cap_Blue(i,j+1)=F_cap_Blue(i,j+1)+(7/16)*e_Blue;
               F_cap_Blue(i+1,j-1)=F_cap_Blue(i+1,j-1)+(3/16)*e_Blue;
               F_cap_Blue(i+1,j)=F_cap_Blue(i+1,j)+(5/16)*e_Blue;
               F_cap_Blue(i+1,j+1)=F_cap_Blue(i+1,j+1)+(1/16)*e_Blue;
           end 
       end
      else
         for j=1:width
           [mbvq,v]=MBVQ(double(Red(i,j)),double(Green(i,j)),double(Blue(i,j)),F_cap_Red(i,j),F_cap_Green(i,j),F_cap_Blue(i,j));
            b_Red(i,j)=v(1,1,1);
            b_Green(i,j)=v(1,1,2);
            b_Blue(i,j)=v(1,1,3);
           e_Red=F_cap_Red(i,j)-b_Red(i,j);
           e_Green=F_cap_Green(i,j)-b_Green(i,j);
           e_Blue=F_cap_Blue(i,j)-b_Blue(i,j);
               if j~=width
                   F_cap_Red(i,j+1)=F_cap_Red(i,j+1)+(7/16)*e_Red;
                   F_cap_Green(i,j+1)=F_cap_Green(i,j+1)+(7/16)*e_Green;
                   F_cap_Blue(i,j+1)=F_cap_Blue(i,j+1)+(7/16)*e_Blue;
               end     
         end
     
      end
    else
        if i~=height
            for j=width:-1:1
                  [mbvq,v]=MBVQ(double(Red(i,j)),double(Green(i,j)),double(Blue(i,j)),F_cap_Red(i,j),F_cap_Green(i,j),F_cap_Blue(i,j)); 
                   b_Red(i,j)=v(1,1,1);
                   b_Green(i,j)=v(1,1,2);
                   b_Blue(i,j)=v(1,1,3);
                   e_Red=F_cap_Red(i,j)-b_Red(i,j);
                   e_Green=F_cap_Green(i,j)-b_Green(i,j);
                   e_Blue=F_cap_Blue(i,j)-b_Blue(i,j);
               if j==width
                   F_cap_Red(i,j-1)=F_cap_Red(i,j-1)+(7/16)*e_Red;
                   F_cap_Red(i+1,j-1)=F_cap_Red(i+1,j-1)+(1/16)*e_Red;
                   F_cap_Red(i+1,j)=F_cap_Red(i+1,j)+(5/16)*e_Red;
                   F_cap_Green(i,j-1)=F_cap_Green(i,j-1)+(7/16)*e_Green;
                   F_cap_Green(i+1,j-1)=F_cap_Green(i+1,j-1)+(1/16)*e_Green;
                   F_cap_Green(i+1,j)=F_cap_Green(i+1,j)+(5/16)*e_Green;
                   F_cap_Blue(i,j-1)=F_cap_Blue(i,j-1)+(7/16)*e_Blue;
                   F_cap_Blue(i+1,j-1)=F_cap_Blue(i+1,j-1)+(1/16)*e_Blue;
                   F_cap_Blue(i+1,j)=F_cap_Blue(i+1,j)+(5/16)*e_Blue;
               elseif j==1
                   F_cap_Red(i+1,j+1)=F_cap_Red(i+1,j+1)+(3/16)*e_Red;
                   F_cap_Red(i+1,j)=F_cap_Red(i+1,j)+(5/16)*e_Red;
                   F_cap_Green(i+1,j+1)=F_cap_Green(i+1,j+1)+(3/16)*e_Green;
                   F_cap_Green(i+1,j)=F_cap_Green(i+1,j)+(5/16)*e_Green;
                   F_cap_Blue(i+1,j+1)=F_cap_Blue(i+1,j+1)+(3/16)*e_Blue;
                   F_cap_Blue(i+1,j)=F_cap_Blue(i+1,j)+(5/16)*e_Blue;
               else
                   F_cap_Red(i,j-1)=F_cap_Red(i,j-1)+(7/16)*e_Red;
                   F_cap_Red(i+1,j-1)=F_cap_Red(i+1,j-1)+(1/16)*e_Red;
                   F_cap_Red(i+1,j)=F_cap_Red(i+1,j)+(5/16)*e_Red;
                   F_cap_Red(i+1,j+1)=F_cap_Red(i+1,j+1)+(3/16)*e_Red;
                   F_cap_Green(i,j-1)=F_cap_Green(i,j-1)+(7/16)*e_Green;
                   F_cap_Green(i+1,j-1)=F_cap_Green(i+1,j-1)+(1/16)*e_Green;
                   F_cap_Green(i+1,j)=F_cap_Green(i+1,j)+(5/16)*e_Green;
                   F_cap_Green(i+1,j+1)=F_cap_Green(i+1,j+1)+(3/16)*e_Green;
                   F_cap_Blue(i,j-1)=F_cap_Blue(i,j-1)+(7/16)*e_Blue;
                   F_cap_Blue(i+1,j-1)=F_cap_Blue(i+1,j-1)+(1/16)*e_Blue;
                   F_cap_Blue(i+1,j)=F_cap_Blue(i+1,j)+(5/16)*e_Blue;
                   F_cap_Blue(i+1,j+1)=F_cap_Blue(i+1,j+1)+(3/16)*e_Blue;
               end  
            end
        else
            for j=width:-1:1
                [mbvq,v]=MBVQ(double(Red(i,j)),double(Green(i,j)),double(Blue(i,j)),F_cap_Red(i,j),F_cap_Green(i,j),F_cap_Blue(i,j));
                b_Red(i,j)=v(1,1,1);
                b_Green(i,j)=v(1,1,2);
                b_Blue(i,j)=v(1,1,3);
                e_Red=F_cap_Red(i,j)-b_Red(i,j);
                e_Green=F_cap_Green(i,j)-b_Green(i,j);
                e_Blue=F_cap_Blue(i,j)-b_Blue(i,j); 
               if j~=1
                   F_cap_Red(i,j-1)=F_cap_Red(i,j-1)+(7/16)*e_Red;
                   F_cap_Green(i,j-1)=F_cap_Green(i,j-1)+(7/16)*e_Green;
                   F_cap_Blue(i,j-1)=F_cap_Blue(i,j-1)+(7/16)*e_Blue;
               end  
            end
        end
    end
end

mbvq_rgb(:,:,1)=b_Red;
figure(8);
imshow(uint8(mbvq_rgb(:,:,1)));
title('MBVQ - Red plane');
mbvq_rgb(:,:,2)=b_Green;
figure(9);
imshow(uint8(mbvq_rgb(:,:,2)));
title('MBVQ - Green plane');
mbvq_rgb(:,:,3)=b_Blue;
figure(10);
imshow(uint8(mbvq_rgb(:,:,3)));
title('MBVQ - Blue plane');
figure(7);
imshow(uint8(mbvq_rgb));
title('MBVQ');

