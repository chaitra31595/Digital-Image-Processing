function Boundary_extended_image=extend_only_boundary(image2,N,n)
image1=double(image2);
image=image1;
Boundary_extended_image=zeros(N+(n-1),N+(n-1));
Boundary_extended_image(1+0.5*(n-1):N+0.5*(n-1),1+0.5*(n-1):N+0.5*(n-1))=image;
for i=1:0.5*(n-1)
   Boundary_extended_image(i,0.5*(n-1)+1:N+0.5*(n-1))=image(0.5*(n-1)-i+2,1:N);
   Boundary_extended_image(0.5*(n-1)+N+i,0.5*(n-1)+1:N+0.5*(n-1))=image(N-i,1:N);
end
for j=1:0.5*(n-1)
   Boundary_extended_image(:,j)=Boundary_extended_image(:,2*0.5*(n-1)-j+2);
   Boundary_extended_image(:,N+0.5*(n-1)+j)=Boundary_extended_image(:,(0.5*(n-1)+N)-j);
end

end