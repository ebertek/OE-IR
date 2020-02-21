map = zeros(50); % térkép csupa nullával
robot = [25, 25]; % robot aktuális pozíciója
map(robot(1),robot(2)) = 1; % térképen látszódjon a robot
% keret:
  map(1,:) = 2;
  map(50,:) = 2;
  map(:,1) = 2;
  map(:,50) = 2;
imagesc(map) % kirajzolás

% 10 pozíció fel:
for i=1:10 
    map(robot(1),robot(2)) = 0;
    robot(1) = robot(1) - 1;
    map(robot(1),robot(2)) = 1;
    imagesc(map);
    pause(0.1);
end
% 10 pozíció jobbra:
for i=1:10 
    map(robot(1),robot(2)) = 0;
    robot(2) = robot(2) + 1;
    map(robot(1),robot(2)) = 1;
    imagesc(map);
    pause(0.1);
end
% robot körbevétele fallal:
for k=-1:1
    for l=-1:1
        if ~and(k==0 , l==0)
            map(robot(1)+k,robot(2)+l)=2;
        end
    end
end
imagesc(map);
