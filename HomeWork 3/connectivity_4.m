function G=connectivity_4(M,M0,M2,M4,M6)

count=0;
if(M0==1)
    count=count+1;
end
if(M2==1)
    count=count+1;
end
if(M4==1)
    count=count+1;
end
if(M6==1)
    count=count+1;
end

if(count==4)
    G=1;
else
    G=M;
end
end