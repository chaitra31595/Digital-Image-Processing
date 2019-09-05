function G=correction_angle_scaling(image,theta,xy_pos_centre_point,xy_centre,N1,width,height)
output_image_to_cartesian_conv=[0 1 -0.5;-1 0 (N1+0.5);0 0 1];
input_image_to_cartesian_conv=[0 1 -0.5;-1 0 (N1+0.5);0 0 1];
for J=1:N1
    for K=1:N1
        xy_pos=output_image_to_cartesian_conv*[J;K;1];
        b=[cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0;0 0 1];
        c=[1 0 -xy_pos_centre_point(1,1);0 1 -xy_pos_centre_point(2,1);0 0 1];
        d=[1 0 xy_pos_centre_point(1,1);0 1 xy_pos_centre_point(2,1);0 0 1];
        e=[1 0 -xy_centre(1,1);0 1 -xy_centre(2,1);0 0 1];
        f=[1 0 xy_centre(1,1);0 1 xy_centre(2,1);0 0 1];
        s=[161/width 0 0;0 161/height 0;0 0 1];
        a=[1 0 xy_centre(1,1)-xy_pos_centre_point(1,1);0 1 xy_centre(2,1)-xy_pos_centre_point(2,1);0 0 1];
        uv_pos=pinv(f*s*b*e*a)*[xy_pos(1,1) xy_pos(2,1) 1]';
        PQ_pos=pinv(input_image_to_cartesian_conv)*[uv_pos(1,1) uv_pos(2,1) 1]';
        if(uint8(PQ_pos(1,1))>=1 && uint8(PQ_pos(1,1))<=N1 && uint8(PQ_pos(2,1))>=1 && uint8(PQ_pos(2,1)<=N1))
         G(J,K)=bilinear_interpolation1(image,uint8(PQ_pos),N1);
        else
         G(J,K)=255;
        end        
    end
end

end
