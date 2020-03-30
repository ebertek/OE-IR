clear all;
warning('off','all') %warning kikapcsolasa
tic
GA_TARGET = 'Hello World'; %keresett string
GA_POP_SIZE=10000; %populacio meret
GA_MAX_ITER=500; %max iteracio
GA_ELITE_RATE=0.10; %orokleshez hasznalt elitrata
GA_MUTATION_RATE=0.20; %mutacios rata (gen=karater)

Generation=0;
%kezdeti ertekek feltoltese, ASCII:
Population=randi([32 122], GA_POP_SIZE,length(GA_TARGET));

%amig el nem erjuk a max iteraciot:
while Generation<GA_MAX_ITER

    %josag szamitas =celertektol valo elteres
    Difference=abs(Population-GA_TARGET);
    Fitness=sum(Difference');

    Generation=Generation+1;
    %fitness szerinti sorbarendezes:
    [Fitness, index]=sort(Fitness);
    Population=Population(index,:);
    %legjobb egyed kiirasa:
    disp(sprintf('%d. generacio legjobb josaga: %d,%s', Generation, Fitness(1),char(Population(1,:))));
    if Fitness(1)==0
        break; %ha megtalaltuk, kilepunk
    end;

    %oroklesben resztvevo elitek
    EliteSelection=Population(1:floor(GA_ELITE_RATE * GA_POP_SIZE),:);
    %veletlen keresztezes:
    for i=1:GA_POP_SIZE
        Parent1=randi([1 floor(GA_ELITE_RATE * GA_POP_SIZE)]); %egyik szulo
        Parent2=randi([1 floor(GA_ELITE_RATE * GA_POP_SIZE)]); %masik szulo
        CrossoverPoint=randi([0 1],1,length(GA_TARGET)); %veletlen genek
        Population(i,:)=EliteSelection(Parent1,:).*CrossoverPoint + EliteSelection(Parent2,:).*(1-CrossoverPoint);
    end
    %mutacio, csak veletlen 1-1 gen mutalodik a teljes populacion belul
    for i=1:length(Population(:))*GA_MUTATION_RATE
        Population(randi(randi([1 GA_POP_SIZE]),[1 length(GA_TARGET)]))= randi(255);
    end

end %while vege
toc
