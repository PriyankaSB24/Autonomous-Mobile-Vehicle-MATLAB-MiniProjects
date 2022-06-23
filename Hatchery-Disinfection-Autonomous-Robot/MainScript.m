% Priyanka Supraja Balaji
% Implementing SLAM Algorithms using 2-D LiDAR data for mapping
% Michigan Technological University
% Main Runner Script

%% Set up all the imports necessary
pl3 = py.importlib.import_module('PyLidar3');
np = py.importlib.import_module('numpy');
plt = py.importlib.import_module('matplotlib');

%% Establish a connection
port = 'com4';
Obj = pl3.YdLidarG4(port);
connect = Obj.Connect();

%% Set up for data acquisition and set the number of scans
gen = Obj.StartScanning();
numScans = 600;

 %% Initialize variables and create a scans cell array to store individual scan data
scans = cell(numScans,1);
angle = [];
dist = [];
a = [];
d = [];
degRadConversion = double(3.1415926535/180);

%% Scan data numScans times
  for i=1 : numScans
      % Get data in the form of string, convert to a char array
      s = py.next(gen);
      strScan = convertCharsToStrings(s.char);
      % Use functions in Python file to get a distance and angle list for
      % the individual scan
      d = pyrunfile('DistanceFunction.py', "distance", j = strScan);
      a = pyrunfile('AngleFunction.py', "angle");
    
      % Convert angle data into a cell array
      angle = [0];
      for j=2:360
          xCoord = double(a{1, j});
          xCoord = times(double(xCoord), double(3.1415926535/180));
          angle = [angle, xCoord];
      end
      % Convert distance data into a cell array
      dist = [double(d{1, 1}) / double(1000)];
      for k=2:360
          yCoord = double(d{1, k});
          yCoord = double(yCoord) / double(1000);
          dist = [dist, yCoord];
      end
      % Create a lidarScan object for the given data in one 360 degree
      % rotation, add to scans
      singleScan = lidarScan(dist, angle);
      scans{i} = singleScan;
      pause(0.1);
      % Map the lidar data for a single scan
      plotScan = lidarScan(dist, angle);
      plotScan = removeInvalidData(plotScan);
      plot(plotScan)
      refreshdata
      drawnow
      % Clear data from variables
      clear singleScan;
      clear angle;
      clear dist;
      clear a;
      clear d;
  end
    
%% SLAM Algorithms

% Set SLAM parameters
maxLidarRange = 14;
mapResolution = 40;  

% Create object to perform SLAM
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

%c Set SLAM object parameters - subject to change based on LiDAR used
slamAlg.LoopClosureThreshold = 110;
slamAlg.LoopClosureSearchRadius = 2;

% Add 10 scans to the object iteratively, print if the scan is accepted
for i=1:10
  [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, scans{i});
  if isScanAccepted
      fprintf('Added scan %d \n', i);
  end
end

% Plot a graph without any completed closure
figure;
show(slamAlg);
title({'Map','Pose Graph without Closure'});

% Set Loop Closure Detection to false
firstTimeLCDetected = false;

% Create another figure and add remaining scans
% Loop closure is detected automatically, optimization is performed
figure;
for i=10:numScans
  [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, scans{i});
  if ~isScanAccepted
      fprintf('Added scan %d \n', i);
      continue;
  end

  % If optimization has occured and LCD is not detected, graphs Pose
  % graph after LCD is completed
  if optimizationInfo.IsPerformed && ~firstTimeLCDetected
      show(slamAlg, 'Poses', 'off');
      hold on;
      show(slamAlg.PoseGraph);
      hold off;
      firstTimeLCDetected = true;
      drawnow
  end
end
title('First loop closure - With and without');

% Set up parameters to build an Occupany map
[scans, optimizedPoses]  = scansAndPoses(slamAlg);
map = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);

% Create a figure for the map and update it
figure;
show(map);
hold on
show(slamAlg.PoseGraph, 'IDs', 'off');
hold off
title('Occupancy Map Built Using Lidar SLAM');

% Stop scanning
Obj.StopScanning()
Obj.Disconnect()


