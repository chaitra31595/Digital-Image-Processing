function E=energy_feature_window(response_map,N,n)
Boundary_extended_image=extend_only_boundary(response_map,N,n);

for i=1+0.5*(n-1):N+0.5*(n-1)
    for j=1+0.5*(n-1):N+0.5*(n-1)   
        temp=0;
        for k=-0.5*(n-1):0.5*(n-1)
            for l=-0.5*(n-1):0.5*(n-1)
               temp=temp+(1/(n*n))*((abs(Boundary_extended_image(i+k,j+l))).^2);
            end
        end
        E(i-0.5*(n-1),j-0.5*(n-1))=temp;
    end
end