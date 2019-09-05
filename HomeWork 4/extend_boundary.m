function Boundary_extended_image=extend_boundary(image2,N)
image1=double(image2);
image=image1;
% image=double(((image1-min(min(image1)))./(max(max(image1))-min(min(image1))))*255);
image=double(image1-(sum(sum(image1))/(N*N)));
% for i=0:255
%     count1=0;
%     for j=1:N
%         for k=1:N
%             if(image1(j,k)==i)
%                 count1=count1+1;
%             end
%         end
%     end   
%    Y1(1,i+1)=count1;
% end
% 
% Probability1=Y1/(N*N);
% CDF1(1,1)=Probability1(1,1);
% 
% for i=2:256
%     CDF1(1,i)=CDF1(1,i-1)+Probability1(1,i);
% end
% HS1=floor(CDF1*255);
% 
% for k=1:256
%     for i=1:N
%         for j=1:N
%             if(image1(i,j)==k-1)
%                 image(i,j)=HS1(1,k);
%             end
%         end
%     end
% end

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
end