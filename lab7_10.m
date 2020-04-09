close all;
clear all;
warning('off','all');

tic
%keresett fekete-feher kep:
GA_TARGET = double(imresize(im2bw(imread('lab5_happy02.png'),0.5),[64 64]));
GA_POP_SIZE=1000; %generacio meret
GA_MAX_ITER=500; %max iteracio
GA_ELITE_RATE=0.1; %elitrata
GA_MUTATION_RATE=0.0005; %mutacios rata

Generation=0;
%kezdeti egyedek:
Population=randi([0 1], length(GA_TARGET),length(GA_TARGET), GA_POP_SIZE);
while Generation<GA_MAX_ITER
    %fitness szamitas
    Difference=abs(Population-GA_TARGET);
    Fitness=sum(sum(Difference));
    %fitness szerinti rendezes
    [Fitness, index]=sort(Fitness);
    Population=Population(:,:,index);
    %legjobb egyed:
    fprintf('%d. generacio legjobb josaga: %d\n', Generation, Fitness(1));
    imshow((Population(:,:,1)),[]);

    if Fitness(1)==0
        break;
    end

    %elitek kivalasztasa:
    EliteSelection=Population(:,:,1:floor(GA_ELITE_RATE * GA_POP_SIZE));
    %keresztezes
    for i=1:GA_POP_SIZE
        Parent1=randi([1 floor(GA_ELITE_RATE * GA_POP_SIZE)]); %egyik szulo
        Parent2=randi([1 floor(GA_ELITE_RATE * GA_POP_SIZE)]); %masik szulo
        CrossoverPoint=randi([0 1],length(GA_TARGET),length(GA_TARGET)); %veletlen keresztezes
        Population(:,:,i)=EliteSelection(:,:,Parent1).*CrossoverPoint + EliteSelection(:,:,Parent2).*(1-CrossoverPoint);
    end
    %veletlen mutacio, gen=pixel
    for i=1:length(Population(:))*GA_MUTATION_RATE
        Population(randi([1 length(GA_TARGET)]), randi([1 length(GA_TARGET)]), randi([1 GA_POP_SIZE]))= randi([0 1]);
    end

    Generation=Generation+1;
end %while vege
toc
