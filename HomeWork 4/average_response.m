function response_map=average_response(filter,Boundary_extended_image,N)
e=0;
n=2;
for i=3:N+2
    for j=3:N+2
        temp=0;
        for k=-n:n
            for l=-n:n
                temp=temp+Boundary_extended_image(i+k,j+l)*filter(k+n+1,l+n+1);
            end
        end
        response_map(i-2,j-2)=temp;
        e=e+(1/(N*N))*((temp).^2);
    end
end
end