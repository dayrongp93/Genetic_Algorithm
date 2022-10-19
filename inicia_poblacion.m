function A = inicia_poblacion(I,J)
A=randi([0,1],I,J);
m=max(A,[],2);
for i=1:I
    if m(i)==0
        r=randi(J);
        A(i,r)=1;
    end
end