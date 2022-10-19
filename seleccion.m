function [padres] = seleccion (poblacion,evaluacion)
% La funcion selecciona dos individuos de la poblacion para su cruzamiento
% segun el metodo de seleccion por torneo. El tamaño de la poblacion debe
% ser un numero par.
long=size(poblacion,1);
padres=zeros(long/2,2);
% En la primera columna de la variable padres se tienen los vencedores del
% torneo 
prob=0.75;
suma=sum(evaluacion);
% Se selecciona el individuo de mayor evaluacion y se considera como el
% primer padre y al último como el de menor evaluacion.
[~,M]=max(evaluacion); 
[~,m]=min(evaluacion);
padres(1,1)=m;
padres(long/2,2)=M;
padres(long/2,1)=randi(long);
% #######################################################################
for i=4:2:(long)-1
   num=rand;
   p1=evaluacion(i)/suma;
   p2=evaluacion(i+1)/suma;
   if num>=prob
       if p1>=p2
           padres(i/2,1)=i;
       else
           padres(i/2,1)=i+1;
       end
   else
       if p1>=p2
           padres(i/2,1)=i+1;
       else
           padres(i/2,1)=i;
       end
   end
end
% Rellenamos con un vector aleatorio a los padres de la segunda columna
padres(1:long/2-1,2)=randperm(long,(long/2)-1);