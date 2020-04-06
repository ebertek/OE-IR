close all;
clear all;
warning('off','all');

tic
%keresett fekete-feh�r k�p:
GA_TARGET = double(imresize(im2bw(imread('lab5_happy02.png'),0.5),[64 64]));
GA_POP_SIZE=1000; %gener�ci� m�ret
GA_MAX_ITER=500; %max iter�ci�
GA_ELITE_RATE=0.1; %elitr�ta
GA_MUTATION_RATE=0.0005; %mut�ci�s r�ta

Generation=0;
%kezdeti egyedek:
Population=randi([0 1], length(GA_TARGET),length(GA_TARGET), GA_POP_SIZE);
while Generation<GA_MAX_ITER
    %fitness sz�m�t�s
    Difference=abs(Population-GA_TARGET);
    Fitness=sum(sum(Difference));
    %fitness szerinti rendez�s
    [Fitness, index]=sort(Fitness);
    Population=Population(:,:,index);
    %legjobb egyed:
    fprintf('%d. gener�ci� legjobb j�s�ga: %d\n', Generation, Fitness(1));
    imshow((Population(:,:,1)),[]);

    if Fitness(1)==0
        break;
    end

    %elitek kiv�laszt�sa:
    EliteSelection=Population(:,:,1:floor(GA_ELITE_RATE * GA_POP_SIZE));
    %keresztez�s
    for i=1:GA_POP_SIZE
        Parent1=randi([1 floor(GA_ELITE_RATE * GA_POP_SIZE)]); %egyik sz�l�
        Parent2=randi([1 floor(GA_ELITE_RATE * GA_POP_SIZE)]); %m�sik sz�l�
        CrossoverPoint=randi([0 1],length(GA_TARGET),length(GA_TARGET)); %v�letlen keresztez�s
        Population(:,:,i)=EliteSelection(:,:,Parent1).*CrossoverPoint + EliteSelection(:,:,Parent2).*(1-CrossoverPoint);
    end
    %v�letlen mut�ci�, g�n=pixel
    for i=1:length(Population(:))*GA_MUTATION_RATE
        Population(randi([1 length(GA_TARGET)]), randi([1 length(GA_TARGET)]), randi([1 GA_POP_SIZE]))= randi([0 1]);
    end

    Generation=Generation+1;
end %while v�ge
toc
