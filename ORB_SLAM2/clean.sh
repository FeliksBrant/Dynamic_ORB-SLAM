echo "Removing build/ in ORB_SLAM2/Thirdparty/DBoW2..."
cd Thirdparty/DBoW2
rm -rf build

echo "Removing build/ in ORB_SLAM2/Thirdparty/g2o..."
cd ../g2o
rm -rf build

echo "Removing build/ in ORB_SLAM2/..."
cd ../../
rm -rf build
