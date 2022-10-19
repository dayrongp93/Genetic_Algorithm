function hijos = cruzamiento(padres,poblacion,pcruza)
% La funcion aplicaun cruzamiento a dos individuos atendiendo a la regla de
% cruce por un punto aleatorio del cromosoma de ambos individuos. La
% poblacion debe tener un numero par de individuos.
long=size(poblacion,1);
% Inicialicemos la matriz que contiene la informacion sobre los hijos que
% será igual al tamaño de la poblacion inicial.
hijos=zeros(size(poblacion));
for i=1:long/2
    num=rand;
    if padres(i)==padres(i+long/2)
        % En caso de que los padres sean iguales sus hijos tambien lo seran
        hijos(i,:)=poblacion(padres(i),:);
        hijos(i+long/2,:)=poblacion(padres(i),:);
    else
        if num<=pcruza
            % En caso de que el numero aleatorio sea menor que la
            % probabilidad de cruzamiento se realiza el cruce.
            p=randi(size(poblacion,2));
            padre1=poblacion(padres(i),:);
            padre2=poblacion(padres(i+long/2),:);
            hijo1=[padre1(1:p),padre2(p+1:end)];
            hijo2=[padre2(1:p),padre2(p+1:end)];
            hijos(2*i-1,:)=hijo1;
            hijos(2*i,:)=hijo2;
        else
            % En caso de que el numero aleatorio sea mayor que la
            % probabilidad de cruzamiento no se realiza el cruce.
            padre1=poblacion(padres(i));
            padre2=poblacion(padres(i+long/2));
            hijos(2*i-1,:)=padre1;
            hijos(2*i,:)=padre2;
        end
    end
end