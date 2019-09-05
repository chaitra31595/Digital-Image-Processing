function [mbvq,v]=MBVQ(Red,Green,Blue,F_cap_Red,F_cap_Green,F_cap_Blue)
if( (Red+Green)>255)
           if((Green+Blue> 255))
               if((Red+Green+Blue)> 510)
                   mbvq= 'CMYW';
               else
                   mbvq= 'MYGC';
               end
            else
                   mbvq= 'RGMY';
           end
       else
           if(~((Green+Blue)>255))
               if(~((Red+Green+Blue)>255))
                   mbvq= 'KRGB';
               else
                   mbvq= 'RGBM';
               end
           else
               mbvq= 'CMGB';
           end
end

vertex=getNearestVertex(mbvq,F_cap_Red/255,F_cap_Green/255,F_cap_Blue/255);
       if isequal(vertex,'white')
           v(1,1,1:3)=255;
       elseif isequal(vertex,'yellow')
           v(1,1,1)=255;v(1,1,2)=255;v(1,1,3)=0; %v(1,1,1)=0;v(1,1,2)=0;v(1,1,3)=255-Blue;
       elseif isequal(vertex,'cyan')
           v(1,1,1)=0;v(1,1,2)=255;v(1,1,3)=255;%v(1,1,1)=255-Red;v(1,1,2)=0;v(1,1,3)=0;
       elseif isequal(vertex,'green')
           v(1,1,1)=0;v(1,1,2)=255;v(1,1,3)=0;
       elseif isequal(vertex,'red')  
           v(1,1,1)=255;v(1,1,2)=0;v(1,1,3)=0;
       elseif isequal(vertex,'blue')
           v(1,1,1)=0;v(1,1,2)=0;v(1,1,3)=255;
       elseif isequal(vertex,'magenta')
           v(1,1,1)=255;v(1,1,2)=0;v(1,1,3)=255;%v(1,1,1)=0;v(1,1,2)=255-Green;v(1,1,3)=0;
       else
           v(1,1,1)=0;v(1,1,2)=0;v(1,1,3)=0;
       end
end