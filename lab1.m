map = zeros(50); % t�rk�p csupa null�val
robot = [25, 25]; % robot aktu�lis poz�ci�ja
map(robot(1),robot(2)) = 1; % t�rk�pen l�tsz�djon a robot
% keret:
  map(1,:) = 2;
  map(50,:) = 2;
  map(:,1) = 2;
  map(:,50) = 2;
imagesc(map) % kirajzol�s

% 10 poz�ci� fel:
for i=1:10 
    map(robot(1),robot(2)) = 0;
    robot(1) = robot(1) - 1;
    map(robot(1),robot(2)) = 1;
    imagesc(map);
    pause(0.1);
end
% 10 poz�ci� jobbra:
for i=1:10 
    map(robot(1),robot(2)) = 0;
    robot(2) = robot(2) + 1;
    map(robot(1),robot(2)) = 1;
    imagesc(map);
    pause(0.1);
end
% robot k�rbev�tele fallal:
for k=-1:1
    for l=-1:1
        if ~and(k==0 , l==0)
            map(robot(1)+k,robot(2)+l)=2;
        end
    end
end
imagesc(map);
