function mutados = mutacion(poblacion,pmuta)
% Esta funcion determina si un individuo sufre una mutacion de acuerdo a un
% numero aleatorio que se genera y si es menor que la probabilidad de 
% cruzamiento entonces se ejecuta la mutacion.
% Vamos a inicializar los individuos que seran los mutados.
long=size(poblacion,1);
mutados=zeros(size(poblacion));
% ########################################################################
for i=1:long
    % Generemos un numero aleatorio 
    num=rand;
    if num<pmuta
        % Se realiza la mutacion de acuero a como sigue 
        ind=randi(size(poblacion,2));
        if poblacion(i,ind)==0
            poblacion(i,ind)=1;
            mutados=poblacion;
        else
            poblacion(i,ind)=0;
            mutados=poblacion;
        end
    else
        % No se realiza ninguna mutacion
        mutados=poblacion;
    end
end