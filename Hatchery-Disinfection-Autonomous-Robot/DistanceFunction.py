# Priyanka Supraja Balaji
# Implementing SLAM Algorithms using 2-D LiDAR data for mapping
# Michigan Technological University
# Distance Function Script

# Finds the nth occurence subStr in the bigStr
def find_nth(bigStr, subStr, n):
  start = bigStr.find(subStr)
  while start >= 0 and n > 1:
      start = bigStr.find(subStr, start+len(subStr))
      n -= 1
  return start

# Gets the distance values in array given the output from scans(info)
def getDist(info):
  data = [1.1,2.1]
  data.clear()
  info = info.replace("{","");
  info = info.replace("}","");
  info = info + ",";
  for i in range(360):
      searcher = str("" + str(i) + ":");
      numInd = int(info.find(searcher));
      index = numInd + len(searcher) + 1;
      comma = find_nth(info, ",", i+1);
      data.append(int(info[index:comma]))
  return data

# Calling the distance function  
distance = getDist(j)


