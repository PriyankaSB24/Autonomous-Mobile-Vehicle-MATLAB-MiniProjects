# Autonomous-Mobile-Vehicle-MATLAB-MiniProjects

Each of the files are a mini-projects about autonomous vehicles principles such as SLAM, Visual Odometry, and Object Detection. All project are coded for MATLAB. 

## LiDARDataOccupancyMap

This mini project creates occupancy maps from LiDAR scan data provided by the SLAM MATLAB toolbox. The project uses LiDAR scan data from an autonomous vehicle navigating a building, to create simultaneous maps(SLAM) as the data from the scans are processed. Output includes graphs of improvement in generated maps post-algorithms such as loop closures and pose graph optimization. The generated map is used to build a final occupancy map, which illustrates the predicted map of the building. 
<img width="753" alt="Screen Shot 2022-06-11 at 4 55 17 PM" src="https://user-images.githubusercontent.com/71840701/173204648-7732d22f-9dd3-4c1c-9cf8-cbff713b356c.png">
<img width="750" alt="Screen Shot 2022-06-11 at 4 55 48 PM" src="https://user-images.githubusercontent.com/71840701/173204650-0039d0f4-8658-4ee8-8276-f302b36a4c67.png">
<img width="749" alt="Screen Shot 2022-06-11 at 4 56 03 PM" src="https://user-images.githubusercontent.com/71840701/173204654-ae18046d-af8f-424e-9ed6-d37aedf32d4b.png">



## DrivingPointCloudPlot

This mini project creates Point Cloud plots for moving vehicles in dynamic road environments using LiDAR data, GPS data, and IMU data provided by the Navigation MATLAB toolbox. The LiDAR, GPS data, and IMU Orientations data are for an autonomous vehicle driving in Mountain View, California. The code creates a simulation of the change in the car's location based on GPS data, and plots the real-time point clouds for the surrounding environment as the car travels. 

<img width="550" alt="Screen Shot 2022-06-11 at 6 35 22 PM" src="https://user-images.githubusercontent.com/71840701/173207025-2e707729-4b51-41b0-b033-461609c1ccd0.png">
<img width="548" alt="Screen Shot 2022-06-11 at 6 35 30 PM" src="https://user-images.githubusercontent.com/71840701/173207028-8824749a-9e6a-45a5-b3dd-88e5281de820.png">
