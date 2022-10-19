function [solucion] = genetico(tampob,costos,maxgen,pcruza,pmuta,pena)
% La funcion cerresponde a la ejecucion del algoritmo genetico en el que se
% generaran todas las generaciones de individuos y se tomaran los mejores
% individuos y de ellos se elije al mejor de todos ellos. En nuestro
% algoritmo cabe destacar que primeramente se ejecuta el operador de
% cruzamiento y despues el de mutacion.

% Iniciemos la matriz de información acerca del cubrimiento.
load('A.mat');

J=length(costos);
poblacion=inicia_poblacion(tampob,J);
eval=zeros(tampob,1);
penalizacion=zeros(tampob,size(A,1));

% ########################################################################

% A continuacion se da inicio a la ejecucion del algoritmo

% Inicialicemos un vector donde se iran guardando a los individuos mejores
% adaptados de cada una de las generaciones.
mejores=zeros(maxgen,J);
% Iniciemos el ciclo de las generaciones
for g=1:maxgen
    % Evaluemos la aptitupd de cada individuo
    for i=1:tampob
        eval(i)=evaluacion(poblacion(i,:),costos);
    end
    % Realicemos el proceso de seleccion de los individuos
    if rem(tampob,2)==0 % Cuando la poblacion es par
        padres=seleccion(poblacion,eval);
        % Una vez seleccionados los pares de individuos listos para el
        % cruzamiento se ejecutara el mismo.
        hijos_cruza=cruzamiento(padres,poblacion,pcruza);
        % Una vez obtenidos los hijos por cruzamiento se les aplicara
        % el operador genetico de mutacion. 
        hijos=mutacion(hijos_cruza,pmuta);
        % Debemos ver ahora cuales individuos son factibles como
        % solucion.
        for i=1:tampob
            for j=1:size(A,1)
                if sum(A(j,:).*(hijos(i,:)))==0
                    penalizacion(i,j)=1;
                else
                    penalizacion(i,j)=0;
                end
            end
        end
        % Apliquemos un factor de penalización para evitar la convergencia
        % hacia una solución no factible
        S=sum(penalizacion,2);
        for i=1:tampob
            if S(i)~=0
                eval(i)=evaluacion(hijos(i,:),costos)+length(costos).*pena;
            else
                eval(i)=evaluacion(hijos(i,:),costos);
            end
        end 
        % Ahora vamos a seleccionar al mejor individuo de la generacion
        [~,ind]=min(eval);
        % Debemos chequear el caso en que todos los individuos son
        % infactibles
        if sum(A(j,:).*(hijos(ind,:)))==0
            mejores(g,:)=ones(1,J);
        else
            mejores(g,:)=hijos(ind,:);
        end
        % Para volver a iniciar el ciclo se debe hacer lo siguiente
        poblacion=hijos;
        

    else % Cuando la poblacion es impar
        % Como la poblacion es tiene un numero impar de individuos
        % pasaremos a la siguiente generacion al individuo mejor
        % adaptado
        [~,ind1]=min(eval);
        hijos=zeros(size(poblacion));
        hijos(1,:)=poblacion(ind1,:);
        % Vamos a redefinir la poblacion con un numero par de
        % individuos.
        poblacion_imp=[poblacion(1:ind1-1,:);poblacion(ind1+1:end,:)]; % Esta poblacion tiene un numero par de individuos
        % Ahora podemos realizar el mismo algoritmo seguido para el
        % caso de una poblacion par.
        padres=seleccion(poblacion_imp,eval([(1:ind1-1) (ind1+1:end)]));
        hijos_cruza=cruzamiento(padres,poblacion_imp,pcruza);
        hijos(2:end,:)=mutacion(hijos_cruza,pmuta);
        % Debemos ver ahora cuales individuos son factibles como
        % solucion.
        for i=1:tampob
            for j=1:size(A,1)
                if sum(A(j,:).*(hijos(i,:)))==0
                    penalizacion(i,j)=1;
                else
                    penalizacion(i,j)=0;
                end
            end
        end
        % Apliquemos un factor de penalización para evitar la convergencia
        % hacia una solución no factible
        S=sum(penalizacion,2);
        for i=1:tampob
            if S(i)~=0
                eval(i)=evaluacion(hijos(i,:),costos)+length(costos).*pena;
            else
                eval(i)=evaluacion(hijos(i,:),costos);
            end
        end 
        % Ahora vamos a seleccionar al mejor individuo de la generacion
        [~,ind]=min(eval);
        % Debemos chequear el caso en que todos los individuos son
        % infactibles
        if sum(A(j,:).*(hijos(ind,:)))==0
            mejores(g,:)=ones(1,J);
        else
            mejores(g,:)=hijos(ind,:);
        end
        % Para volver a iniciar el ciclo se debe hacer lo siguiente
        poblacion=hijos;
    end
end


% Ya obtenido la poblacion de los individuos resultantes de todas
% las generaciones vamos a escoger a el mejor individuo de entre
% los mejores por generacion.
mejor_evaluacion=zeros(maxgen,1);
for i=1:maxgen
    mejor_evaluacion(i)=evaluacion(mejores(i,:),costos);
end
[~,ind]=min(mejor_evaluacion);
solucion=mejores(ind,:);