function G=bilinear_interpolation1(image,PQ_pos,N)
% Boundary_extended_image=255*ones(N+2,N+2);
% Boundary_extended_image(2:N+1,2:N+1)=image;
% image=Boundary_extended_image;

if((mod(PQ_pos(1,1),1)==0) && (mod(PQ_pos(2,1),1)==0) && (PQ_pos(1,1)>=1)&&(PQ_pos(1,1)<=N) && (PQ_pos(2,1)>=1)&& (PQ_pos(2,1)<=N))
    G=image(PQ_pos(1,1),PQ_pos(2,1));
elseif((mod(PQ_pos(1,1),1)==0) && (mod(PQ_pos(2,1),1)~=0))
    fQ11=image((PQ_pos(1,1)),floor(PQ_pos(2,1)));
    fQ12=image((PQ_pos(1,1)),ceil(PQ_pos(2,1)));
    a=double([(ceil(PQ_pos(2,1))-PQ_pos(2,1)); (PQ_pos(2,1)-floor(PQ_pos(2,1)))]);
    b=double([fQ11 fQ12]);
    G=b*a;
   
elseif((mod(PQ_pos(1,1),1)~=0) && (mod(PQ_pos(2,1),1)==0))
    fQ11=image(floor(PQ_pos(1,1)),(PQ_pos(2,1)));
    fQ21=image(ceil(PQ_pos(1,1)),(PQ_pos(2,1)));
    b=double([fQ11; fQ21]);
    c=double([(ceil(PQ_pos(1,1))-PQ_pos(1,1)) (PQ_pos(1,1)-floor(PQ_pos(1,1)))]);
    G=c*b;    
    
else
    fQ11=image(floor(PQ_pos(1,1)),floor(PQ_pos(2,1)));
    fQ12=image(floor(PQ_pos(1,1)),ceil(PQ_pos(2,1)));
    fQ21=image(ceil(PQ_pos(1,1)),floor(PQ_pos(2,1)));
    fQ22=image(ceil(PQ_pos(1,1)),ceil(PQ_pos(2,1)));
    a=double([(ceil(PQ_pos(2,1))-PQ_pos(2,1)); (PQ_pos(2,1)-floor(PQ_pos(2,1)))]);
    b=double([fQ11 fQ12;fQ21 fQ22]);
    c=double([(ceil(PQ_pos(1,1))-PQ_pos(1,1)) (PQ_pos(1,1)-floor(PQ_pos(1,1)))]);
    d=double((1/((ceil(PQ_pos(1,1))-floor(PQ_pos(1,1)))*(ceil(PQ_pos(2,1))-floor(PQ_pos(2,1))))));
    G=d*c*b*a;
end
end