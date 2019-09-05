function [P1,Q1,P2,Q2,P3,Q3,P4,Q4,theta,centre_point,width,height]=coordinate_extraction1(N1,image)
for i=1:N1
    for j=1:N1
        if(image(i,j)>249)
            image(i,j)=255;
        end
    end
end

for i=1:N1
    count_row(i,1)=0;
    for j=1:N1      
     if(image(i,j)~=255)
        count_row(i,1)=count_row(i,1)+1;
     end
    end
end
for j=1:N1
    count_col(j,1)=0;
    for i=1:N1      
     if(image(i,j)~=255)
        count_col(j,1)=count_col(j,1)+1;
     end
    end
end
temp1=count_row;%-N1*ones(N1,1);
temp2=count_col;%-N1*ones(N1,1);
for i=2:N1-1
   if((temp1(i-1,1)==0) &&(temp1(i,1)~=0)) 
       P1=i;
   end
   if((temp1(i+1,1)==0) && (temp1(i,1)~=0)) 
       P2=i;
   end
   if((temp2(i-1,1)==0) && (temp2(i,1)~=0)) 
       Q3=i;
   end
   if((temp2(i+1,1)==0) &&  (temp2(i,1)~=0)) 
       Q4=i;
    end
end
k=1;l=1;m=1;n=1;
for j=1:N1
    if(image(P1,j)~=255)
      temp3(1,m)=j;
      m=m+1;
    end
    if(image(P2,j)~=255)
      temp4(1,k)=j;
      k=k+1;
    end
    if(image(j,Q3)~=255)
      temp5(1,l)=j;
      l=l+1;
    end
    if(image(j,Q4)~=255)
      temp6(1,n)=j;
      n=n+1;
    end
end
if( isequal(temp3,temp4) && isequal(temp5,temp6))
 Q1=Q3;
 Q2=Q4;
 P3=P2;
 P4=P1;
else
Q1=mean(temp3);
Q2=mean(temp4);
P3=mean(temp5);
P4=mean(temp6);
end
width=sqrt(((P1-P3).^2)+((Q1-Q3).^2));
height=sqrt(((P1-P4).^2)+((Q1-Q4).^2));
centre_point=[(P3+P4)/2 (Q3+Q4)/2];
theta=atan((P2-P3)/(Q2-Q3));
end