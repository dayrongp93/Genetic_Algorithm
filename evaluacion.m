function eval = evaluacion(user,costo)
% Esta funcion evalua cierto individuo en la funcion objetivo de nuestro
% problema 
eval=0;
for i=1:length(user)
    eval=eval+costo(i)*user(i);
end