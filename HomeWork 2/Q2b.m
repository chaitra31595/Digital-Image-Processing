Image=readraw('bridge.raw');
imshow(uint8(Image));
[height, width]=size(Image);
F=Image;
F_cap=F;
MSE=zeros(1,3);
T=192;
%Floyd-Steinberg
for i=1:height    
    if(mod(i,2)~=0)
       for j=1:width
           if (F_cap(i,j)>T)
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
           MSE(1,1)=MSE(1,1)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
       end
    else
        if i~=height
            for j=width:-1:1
                if (F_cap(i,j)>T)
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
               MSE(1,1)=MSE(1,1)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
            end
        else
            for j=width:-1:1
               if (F_cap(i,j)>T)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if j~=1
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/16)*e;
               end  
               MSE(1,1)=MSE(1,1)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
            end
        end
    end
end
PSNR(1,1)=10*log10(255.^2/MSE(1,1));
figure(1);
imshow(uint8(b));
title('Floyd-Steinberg');

%JJN 
b=zeros(height,width);
F_cap=F;
for i=1:height    
    if(mod(i,2)~=0)
      if i~= (height-1)
       for j=1:width
           if (F_cap(i,j)>T)
               b(i,j)=255;
           else
               b(i,j)=0;
           end
           e=F_cap(i,j)-b(i,j);
           if j==1 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/48)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(5/48)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;
               F_cap(i+2,j+1)=F_cap(i+2,j+1)+(3/48)*e;
               F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
           elseif j==2
               F_cap(i,j+1)=F_cap(i,j+1)+(7/48)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(5/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;
               F_cap(i+2,j+1)=F_cap(i+2,j+1)+(3/48)*e;
               F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/48)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e; 
               F_cap(i+2,j-1)=F_cap(i+2,j-1)+(3/48)*e;
           elseif j==width              
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
               F_cap(i+2,j-1)=F_cap(i+2,j-1)+(3/48)*e;
               F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
           elseif j==width-1
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
               F_cap(i+2,j-1)=F_cap(i+2,j-1)+(3/48)*e;
               F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
               F_cap(i,j+1)=F_cap(i,j+1)+(7/48)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
               F_cap(i+2,j+1)=F_cap(i+2,j+1)+(3/48)*e;             
           else 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/48)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(5/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;
               F_cap(i+2,j+1)=F_cap(i+2,j+1)+(3/48)*e;
               F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/48)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
               F_cap(i+2,j-1)=F_cap(i+2,j-1)+(3/48)*e;
               F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/48)*e;
           end  
           MSE(1,2)=MSE(1,2)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
       end
      else
          for j=width:-1:1
               if (F_cap(i,j)>T)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
            if j==1 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/48)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(5/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;              
            elseif j==2
               F_cap(i,j+1)=F_cap(i,j+1)+(7/48)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(5/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e; 
           elseif j==width              
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
           elseif j==width-1
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i,j+1)=F_cap(i,j+1)+(7/48)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;           
           else 
               F_cap(i,j+1)=F_cap(i,j+1)+(7/48)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(5/48)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
            end 
           MSE(1,2)=MSE(1,2)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
          end
      end
      
    else
        if i~=height
            for j=width:-1:1
                if (F_cap(i,j)>T)
                    b(i,j)=255;
                else
                    b(i,j)=0;
                end
                e=F_cap(i,j)-b(i,j);
               if j==width
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/48)*e;
                   F_cap(i,j-2)=F_cap(i,j-2)+(5/48)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
                   F_cap(i+2,j-1)=F_cap(i+2,j-1)+(3/48)*e;
                   F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/48)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
                   F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
               elseif j==width-1
                   F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/48)*e;
                   F_cap(i,j-2)=F_cap(i,j-2)+(5/48)*e;
                   F_cap(i+2,j-1)=F_cap(i+2,j-1)+(3/48)*e;
                   F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/48)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
                   F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
                   F_cap(i+2,j+1)=F_cap(i+2,j+1)+(3/48)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;      
               elseif j==1
                   F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
                   F_cap(i+2,j+1)=F_cap(i+2,j+1)+(3/48)*e;
                   F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/48)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
                   F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;
               elseif j==2
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/48)*e;
                   F_cap(i+2,j-1)=F_cap(i+2,j-1)+(3/48)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
                   F_cap(i+2,j+1)=F_cap(i+2,j+1)+(3/48)*e;
                   F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/48)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
                   F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;                   
               else
                   F_cap(i+1,j)=F_cap(i+1,j)+(7/48)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(5/48)*e;
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/48)*e;
                   F_cap(i,j-2)=F_cap(i,j-2)+(5/48)*e;
                   F_cap(i+2,j-1)=F_cap(i+2,j-1)+(3/48)*e;
                   F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/48)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(5/48)*e;
                   F_cap(i+1,j-2)=F_cap(i+1,j-2)+(3/48)*e;
                   F_cap(i+2,j+1)=F_cap(i+2,j+1)+(3/48)*e;
                   F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/48)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(5/48)*e;
                   F_cap(i+1,j+2)=F_cap(i+1,j+2)+(3/48)*e;     
               end 
               MSE(1,2)=MSE(1,2)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
            end
        else
            for j=width:-1:1
               if (F_cap(i,j)>T)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if (j==2)
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/48)*e;
               elseif (j==1)
               else
                   F_cap(i,j-1)=F_cap(i,j-1)+(7/48)*e;
                   F_cap(i,j-2)=F_cap(i,j-2)+(5/48)*e;
               end
               MSE(1,2)=MSE(1,2)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
            end
        end
    end
end
PSNR(1,2)=10*log10(255.^2/MSE(1,2));
figure(2);
imshow(uint8(b));
title('JJN');


%Stucki
b=zeros(height,width);
F_cap=F;
for i=1:height    
    if(mod(i,2)~=0)
      if i~= (height-1)
       for j=1:width
           if (F_cap(i,j)>T)
               b(i,j)=255;
           else
               b(i,j)=0;
           end
           e=F_cap(i,j)-b(i,j);
           if j==1 
               F_cap(i,j+1)=F_cap(i,j+1)+(8/42)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(4/42)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;
               F_cap(i+2,j+1)=F_cap(i+2,j+1)+(2/42)*e;
               F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
           elseif j==2
               F_cap(i,j+1)=F_cap(i,j+1)+(8/42)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(4/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;
               F_cap(i+2,j+1)=F_cap(i+2,j+1)+(2/42)*e;
               F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/42)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e; 
               F_cap(i+2,j-1)=F_cap(i+2,j-1)+(2/42)*e;
           elseif j==width              
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
               F_cap(i+2,j-1)=F_cap(i+2,j-1)+(2/42)*e;
               F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
           elseif j==width-1
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
               F_cap(i+2,j-1)=F_cap(i+2,j-1)+(2/42)*e;
               F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
               F_cap(i,j+1)=F_cap(i,j+1)+(8/42)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
               F_cap(i+2,j+1)=F_cap(i+2,j+1)+(2/42)*e;             
           else 
               F_cap(i,j+1)=F_cap(i,j+1)+(8/42)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(4/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;
               F_cap(i+2,j+1)=F_cap(i+2,j+1)+(2/42)*e;
               F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/42)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
               F_cap(i+2,j-1)=F_cap(i+2,j-1)+(2/42)*e;
               F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/42)*e;
           end 
           MSE(1,3)=MSE(1,3)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
       end
      else
          for j=width:-1:1
               if (F_cap(i,j)>T)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
            if j==1 
               F_cap(i,j+1)=F_cap(i,j+1)+(8/42)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(4/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;              
            elseif j==2
               F_cap(i,j+1)=F_cap(i,j+1)+(8/42)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(4/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e; 
           elseif j==width              
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
           elseif j==width-1
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i,j+1)=F_cap(i,j+1)+(8/42)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;           
           else 
               F_cap(i,j+1)=F_cap(i,j+1)+(8/42)*e;
               F_cap(i,j+2)=F_cap(i,j+2)+(4/42)*e;
               F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
               F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
               F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;
               F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
               F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
            end 
           MSE(1,3)=MSE(1,3)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
          end
      end
      
    else
        if i~=height
            for j=width:-1:1
                if (F_cap(i,j)>T)
                    b(i,j)=255;
                else
                    b(i,j)=0;
                end
                e=F_cap(i,j)-b(i,j);
               if j==width
                   F_cap(i,j-1)=F_cap(i,j-1)+(8/42)*e;
                   F_cap(i,j-2)=F_cap(i,j-2)+(4/42)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
                   F_cap(i+2,j-1)=F_cap(i+2,j-1)+(2/42)*e;
                   F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/42)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
                   F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
               elseif j==width-1
                   F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
                   F_cap(i,j-1)=F_cap(i,j-1)+(8/42)*e;
                   F_cap(i,j-2)=F_cap(i,j-2)+(4/42)*e;
                   F_cap(i+2,j-1)=F_cap(i+2,j-1)+(2/42)*e;
                   F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/42)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
                   F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
                   F_cap(i+2,j+1)=F_cap(i+2,j+1)+(2/42)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;      
               elseif j==1
                   F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
                   F_cap(i+2,j+1)=F_cap(i+2,j+1)+(2/42)*e;
                   F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/42)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
                   F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;
               elseif j==2
                   F_cap(i,j-1)=F_cap(i,j-1)+(8/42)*e;
                   F_cap(i+2,j-1)=F_cap(i+2,j-1)+(2/42)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
                   F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
                   F_cap(i+2,j+1)=F_cap(i+2,j+1)+(2/42)*e;
                   F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/42)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
                   F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;                   
               else
                   F_cap(i+1,j)=F_cap(i+1,j)+(8/42)*e;
                   F_cap(i+2,j)=F_cap(i+2,j)+(4/42)*e;
                   F_cap(i,j-1)=F_cap(i,j-1)+(8/42)*e;
                   F_cap(i,j-2)=F_cap(i,j-2)+(4/42)*e;
                   F_cap(i+2,j-1)=F_cap(i+2,j-1)+(2/42)*e;
                   F_cap(i+2,j-2)=F_cap(i+2,j-2)+(1/42)*e;
                   F_cap(i+1,j-1)=F_cap(i+1,j-1)+(4/42)*e;
                   F_cap(i+1,j-2)=F_cap(i+1,j-2)+(2/42)*e;
                   F_cap(i+2,j+1)=F_cap(i+2,j+1)+(2/42)*e;
                   F_cap(i+2,j+2)=F_cap(i+2,j+2)+(1/42)*e;
                   F_cap(i+1,j+1)=F_cap(i+1,j+1)+(4/42)*e;
                   F_cap(i+1,j+2)=F_cap(i+1,j+2)+(2/42)*e;     
               end
            MSE(1,3)=MSE(1,3)+(1/(height*width))*((F(i,j)-b(i,j)).^2);   
            end
        else
            for j=width:-1:1
               if (F_cap(i,j)>T)
                    b(i,j)=255;
               else
                    b(i,j)=0;
               end
               e=F_cap(i,j)-b(i,j);
               if (j==2)
                   F_cap(i,j-1)=F_cap(i,j-1)+(8/42)*e;
               elseif (j==1)
               else
                   F_cap(i,j-1)=F_cap(i,j-1)+(8/42)*e;
                   F_cap(i,j-2)=F_cap(i,j-2)+(4/42)*e;
               end
               MSE(1,3)=MSE(1,3)+(1/(height*width))*((F(i,j)-b(i,j)).^2);
            end
        end
    end
end
PSNR(1,3)=10*log10(255.^2/MSE(1,3));
figure(3);
imshow(uint8(b));
title('Stucki');