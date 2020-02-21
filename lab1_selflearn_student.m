%Tested on Matlab R2016b Academic
prompt = 'Clear ruleTable? [Y/N]';
str = input(prompt,'s');
if(upper(str)=='N')
    clearvars -except ruleTable
    disp(ruleTable)
else
    clear all;
    disp('ruleTable empty')
end
close all;

%% Basemaps
map=imread('lab1_32d.png');



%% "defines"
%cell values
emptyVal=0;
finishVal=-1;
robotVal=-2;
pathVal=-2.5;
obstacleVal=-3;

%rule table size (movement and direction possibilities - min: 4x4)
directions=4;
movements=4;

%directions (where is the finish cell)
dirRight=1;
dirLeft=2;
dirUp=3;
dirDown=4;

%movements (where to move)
moveRight=1;
moveLeft=2;
moveUp=3;
moveDown=4;

if (exist('ruleTable')==0)    
    ruleTable=zeros(directions,movements);
end
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
map(startPos(1), startPos(2))=robotVal; %start
for (i=1:size(map,1))
    for (j=1:size(map,2))
        if map(i,j)==1
            map(i,j)=obstacleVal; %obstacle
        end
    end
end

%%learning
robotPos=startPos;

while(norm(robotPos)~=norm(finishPos))
   
    newPos=robotPos;
    directionIndex=-1;
  % 1. feladat  
    %directionIndex, azaz a robothoz k�pest a c�l ir�ny�nak meghat�roz�sa 
    %directions 
    % dirRight=1;
    % dirLeft=2;
    % dirUp=3;
    % dirDown=4;
    %%% IDE TESS�K �RNI
    kulonbseg=finishPos-robotPos;
    if abs(kulonbseg(1)) > abs(kulonbseg(2)) % sorok k�l�nbs�ge nagyobb
        if kulonbseg(1)>0
            directionIndex = dirDown;
        else
            directionIndex = dirUp;
        end
    else % oszlopok k�l�nbs�ge nagyobb
        if kulonbseg(2)>0
            directionIndex = dirRight;
        else
            directionIndex = dirLeft;
        end
    end
   
    
    %%% EDDIG
    disp(directionIndex)
    
  % 2. feladat
    %movementIndex, azaz az adott ir�nyhoz tartoz� legnagyobb j�s�g� l�p�s
    %kiv�laszt�sa a szab�lyt�bl�b�l
    %movements (l�p�sek, merre l�phet�nk?)
    % moveRight=1;
    % moveLeft=2;
    % moveUp=3;
    % moveDown=4;
    %%% IDE TESS�K �RNI
    
    
    
    
    %%% EDDIG
    
  % 3. feladat   
    %az �j l�p�s kisz�m�t�sa, azaz "newPos" v�ltoz� sor�nak ill.
    %oszlop�nak inkrement�l�sa ill. dekrement�l�sa
    %%% IDE TESS�K �RNI
    
    
    
    
    %%% EDDIG
    
  % 4. feladat
    %t�vols�g ellen�rz�se, ha k�zeledt�nk => szab�ly meger�s�t�se, ha
    %t�volodtunk => szab�ly leront�sa
    %%% IDE TESS�K �RNI
    
    
    
    
    %%% EDDIG   
    
    %display movement
    map(robotPos(1),robotPos(2))=pathVal;
    robotPos=newPos;
    map(robotPos(1),robotPos(2))=robotVal;
    
    disp(ruleTable);
    imagesc(map);
    colormap(jet);
    pause(0.1);

 
end
%% Retry    
prompt = 'Retry? [Y/N]';
str = input(prompt,'s');
if(upper(str)=='Y')
    selflearn_student
end
