# Priyanka Supraja Balaji
# Implementing SLAM Algorithms using 2-D LiDAR data for mapping
# Michigan Technological University
# Angle Function Script

# Gets the angle values in array
def getAngle():
   data = [1.1,2.1]
   data.clear()
  
   for i in range(360):
       data.append(int(i))
   return data

# Calling the angl function  
angle = getAngle()

