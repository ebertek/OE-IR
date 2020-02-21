%Tested on MATLAB R2019b Academic
prompt = 'Clear ruleTable? [Y/N]';
str = input(prompt,'s');
if upper(str) == 'N'
    if exist('ruleTable', 'var')
        clearvars -except ruleTable
        disp(ruleTable)
    end
else
    clear all;
    disp('ruleTable empty')
end
close all;

%% Basemaps
map = imread('lab1_32d.png');

%% "defines"
%cell values
emptyVal    =  0;
finishVal   = -1;
robotVal    = -2;
pathVal     = -2.5;
obstacleVal = -3;

%rule table size (movement and direction possibilities - min: 4x4)
directions = 4;
movements  = 4;

%directions (where is the finish cell)
dirRight = 1;
dirLeft  = 2;
dirUp    = 3;
dirDown  = 4;

%movements (where to move)
moveRight = 1;
moveLeft  = 2;
moveUp    = 3;
moveDown  = 4;

if exist('ruleTable', 'var') == 0
    ruleTable = zeros(directions,movements);
end
%% get start and finish positions
%find R
startPos = [-1,-1]; %invalid
for i = 1:size(map,1)
    for j = 1:size(map,2)
        if reshape(map(i,j,:),[1 3]) == [255,0,0] %red
            startPos = [i,j];
        end
    end
end


%find F
finishPos = [-1,-1]; %invalid
for i = 1:size(map,1)
    for j = 1:size(map,2)
        if reshape(map(i,j,:),[1 3]) == [0,255,0] %green
            finishPos = [i,j];
        end
    end
end

disp(['start coords: ', num2str(startPos)]);
disp(['finish coords: ', num2str(finishPos)]); 

%% Replace start, finish, obstacle cell values
map = rgb2gray(map);
map = 1-im2double(map);
map(finishPos(1),finishPos(2)) = finishVal; %finish
map(startPos(1),startPos(2)) = robotVal; %start
for i = 1:size(map,1)
    for j = 1:size(map,2)
        if map(i,j) == 1
            map(i,j) = obstacleVal; %obstacle
        end
    end
end

%%learning
robotPos = startPos;

while norm(robotPos) ~= norm(finishPos)

    newPos = robotPos;
    directionIndex = -1;
  % 1. feladat
    %directionIndex, azaz a robothoz képest a cél irányának meghatározása 
    %directions 
    % dirRight = 1;
    % dirLeft  = 2;
    % dirUp    = 3;
    % dirDown  = 4;
    %%% IDE TESSÉK ÍRNI
    kulonbseg = finishPos-robotPos;
    if abs(kulonbseg(1)) > abs(kulonbseg(2)) % sorok különbsége nagyobb
        if kulonbseg(1) > 0
            directionIndex = dirDown;
        else
            directionIndex = dirUp;
        end
    else % oszlopok különbsége nagyobb
        if kulonbseg(2) > 0
            directionIndex = dirRight;
        else
            directionIndex = dirLeft;
        end
    end
    kulonbsegAbs_eredeti = norm(kulonbseg);
    %%% EDDIG
    disp(directionIndex)
    
  % 2. feladat
    %movementIndex, azaz az adott irányhoz tartozó legnagyobb jóságú lépés
    %kiválasztása a szabálytáblából
    %movements (lépések, merre léphetünk?)
    % moveRight = 1;
    % moveLeft  = 2;
    % moveUp    = 3;
    % moveDown  = 4;
    %%% IDE TESSÉK ÍRNI
    [legjobb,movementIndex] = max(ruleTable(directionIndex,:));
    %%% EDDIG

  % 3. feladat
    %az új lépés kiszámítása, azaz "newPos" változó sorának ill.
    %oszlopának inkrementálása ill. dekrementálása
    %%% IDE TESSÉK ÍRNI
    switch movementIndex
        case moveRight
            if robotPos(2) < size(map,1) - 1
                newPos(2) = robotPos(2) + 1;
            end
        case moveLeft
            if robotPos(2) > 2
                newPos(2) = robotPos(2) - 1;
            end
        case moveUp
            if robotPos(1) > 2
                newPos(1) = robotPos(1) - 1;
            end
        case moveDown
            if robotPos(1) < size(map,2) - 1
                newPos(1) = robotPos(1) + 1;
            end
    end
    %%% EDDIG
    
  % 4. feladat
    %távolság ellenõrzése, ha közeledtünk => szabály megerõsítése, ha
    %távolodtunk => szabály lerontása
    %%% IDE TESSÉK ÍRNI
    kulonbseg = finishPos-newPos;
    kulonbsegAbs_uj = norm(kulonbseg);
    if kulonbsegAbs_uj < kulonbsegAbs_eredeti
        ruleTable(directionIndex,movementIndex) = ruleTable(directionIndex,movementIndex) + 1;
    else
        ruleTable(directionIndex,movementIndex) = ruleTable(directionIndex,movementIndex) - 1;
    end
    %%% EDDIG
    
    %display movement
    map(robotPos(1),robotPos(2)) = pathVal;
    robotPos = newPos;
    map(robotPos(1),robotPos(2)) = robotVal;
    
    disp(ruleTable);
    imagesc(map);
    colormap(jet);
    pause(0.1);

end
%% Retry
prompt = 'Retry? [Y/N]';
str = input(prompt,'s');
if upper(str) == 'Y'
    lab1_selflearn_student
end
