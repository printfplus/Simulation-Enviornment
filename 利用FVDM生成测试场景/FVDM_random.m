function a = FVDM_random(x1,x2,v1,v2)
    a = FVDM(x1,x2,v1,v2);
    a = sample_and_get_A(a);
end
