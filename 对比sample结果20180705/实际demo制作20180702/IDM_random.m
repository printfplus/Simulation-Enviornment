function a = IDM_random(x1,x2,v1,v2)
    a = IDM(x1,x2,v1,v2);
    a = sample_and_get_A(a);
end
