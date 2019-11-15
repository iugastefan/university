function verificareRang(A,r, rext)
if r==rext && r ==size(A,1)
    disp('sist comp det')
elseif r==rext && r<size(A,1)
    disp('sist comp nedet')
elseif r~=rext
    disp('sist inc')
end
end