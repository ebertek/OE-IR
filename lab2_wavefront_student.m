%Tested on Matlab R2016b Academic

clear all;
close all;

%% Basemaps
map=imread('32.png'); %N 32x32


%% "defines"
emptyVal=0;
finishVal=-1;
startVal=-2;
obstacleVal=-3;


%% get start and finish positions
%find R
startPos=[-1,-1]; %invalid
for (i=1:size(map,1))
    for (j=1:size(map,2))
        if reshape(map(i,j,:),[1 3])==[255,0,0] %red
            startPos=[i,j];
        end
    end
end


%find F
finishPos=[-1,-1]; %invalid
for (i=1:size(map,1))
    for (j=1:size(map,2))
        if reshape(map(i,j,:),[1 3])==[0,255,0] %green
            finishPos=[i,j];
        end
    end
end

disp(['start coords: ', num2str(startPos)]);
disp(['finish coords: ', num2str(finishPos)]); 

%% Replace start, finish, obstacle cell values
map=rgb2gray(map);
map=1-im2double(map);
map(finishPos(1), finishPos(2))=finishVal; %finish
map(startPos(1), startPos(2))=startVal; %start
for (i=1:size(map,1))
    for (j=1:size(map,2))
        if map(i,j)==1
            map(i,j)=obstacleVal; %obstacle
        end
    end
end

%% generate_wavefront

newWavefrontCells=1;
while(newWavefrontCells>0)
      newWavefrontCells=0;
      cloneMap=map;
% 1. feladat  
    % Hullámfrontok terjesztése
    % Addig fut a ciklus, amíg van olyan üres cella, ahova a hullám
    % eljuthat.
    % Hogyan lehet megoldani, hogy akkor is leálljon a terjesztés, ha a hullám eléri a robotot?

    % - Minden egyes ciklusban egyetlen új hullámfrontot kell lekezelni
    % - Olyan üres cellákat kell keresni, melynek szomszédja hullámfront
    % cella.
    % - Függõleges, vízszintes irányban +2, átlós irányba +3 értékkel
    % növeljük a hullámfront értékét az vizsgált üres cellákba. Törekedni
    % kell a minimális költségû lépésre.
    % - Le kell lezelni az elsõ lépést, ahol a cél (-1 tartalmú) cellát
    % kell körbevenni hullámfronttal
    % - Figyelni kell a hullámfrontba bevont cellák értékének növelésére(newWavefrontCells)!
    
    %%% IDE TESSÉK ÍRNI
    
    
    
    
    %%% EDDIG
       


    map=cloneMap;
    imagesc(map);
    colormap(jet);
    colorbar;
    pause(0.01);
end
    

%% check wavefront vs. startPos
localMax=-1;
for (i=-1:1)
    for (j=-1:1)
        if map(startPos(1)+i,startPos(2)+j)>0
           localMax=map(startPos(1)+i,startPos(2)+j);
        end
    end
end
if localMax>0
    pathavailable=1;
    disp('There is a path!');
else
    pathavailable=0;
    disp('There is NO path!');
end

%% search for the shortest path
if (pathavailable)    
    globalMax=max(map(:));
    if localMax>0
        pathcomplete=0;      
        robotPos(1)=startPos(1);
        robotPos(2)=startPos(2);
        while(~pathcomplete)
            
% 2. feladat  
    % Legrövidebb út keresése
    % A robot (robotPos) aktuális környezetét meg kell vizsgálni (8
    % szomszédos cella) és a legkisebb hullámfront értékût kell választani (minWave)
    % Magát a lépést és útvonal rajzolást a keretprogram elvégzi!
    
    %%% IDE TESSÉK ÍRNI
    
    
    
    
    %%% EDDIG
            


            robotPos=minWave;           
            map(robotPos(1), robotPos(2))=globalMax*1.2; %draw path 
            %% show the wavefronts
            imagesc(map);
            colormap(jet);
            colorbar;
            pause(0.01);
        end
    end
end