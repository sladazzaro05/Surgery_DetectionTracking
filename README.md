FINAL_PROJECT
=============

Computer Vision final project...using RGB color histograms to first detect objects in videos of robotic surgery, and then track them using similar concepts with the neighborhood around centroid detected.

In order to run the code used, the MainRealTime function should be called, which is in the classificationTracking folder.  Different sets of the training images were used with the best results coming from using pulmonary3 and pulmonary4 located in the pulmonary_arteries folder.

Syntax:
MainRealTime( trainDir, videoPath, vidOutputName, s, widthOfBins, thresh );

where:
trainDir- 	directory of training images.  Note there should be
               		a subdirectory in trainDir which contains .jpg images
videoPath- 	the path to the video to be used for testing
vidOutputName- 	the name of video file to output
s- 		the window size that each frame will be split up in to form
               		histograms (good value to use is 40)
widthOfBins- 	the width of the bins for the RGB color
               		histograms (good value to use is 16)
thresh- 	the cutoff distance threshold used to measure whether
               		or not window histograms are close enough to the training
               		histograms. (good value to use is -5 for pulmonary artery)

NOTE: The first time running the program in a new Matlab window, there will be an overhead time cost as Matlab must create a parallel pool of workers since this program uses the Parallel Computing toolbox.
