function [ circles, zerosInARow, realValsInARow, shouldCallDetector ] = DetectObjects( vidAllCopy, trainingHistograms, s, widthOfBins, thresh, skip, circles, zerosInARow, realValsInARow )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

componentVideo = VideoToScoreVideoSkip( double(vidAllCopy), trainingHistograms, s, widthOfBins, thresh, skip);
[componentVideo, num] = ScoreVideoToComponentVideo( componentVideo );
%display(strcat(datestr(now,'HH:MM:SS'),' [INFO] Timer Will Look For Mean and Radius'));
if (num ~= 0)
    [meanxNew, meanyNew, radiusNew] = GetCircleInfo(componentVideo,s);
    if (circles(1,1) ~= 0)
        if (meanxNew == 0)
            zerosInARow = zerosInARow + 1;
            realValsInARow = 0;
        end
        if (zerosInARow >= 2) %if 2 zeros in a row, then conclude it's off screen
            circles(1,1) = meanxNew;
            circles(1,2) = meanyNew;
            circles(1,3) = radiusNew;
        else
            %To make sure noise wasn't captured only take small changes in
            %obj position
            display(norm(circles(1,1:2) - [meanxNew, meanyNew] ) ^ 2);
            display(trackingThreshold);
            if ( norm(circles(1,1:2) - [meanxNew, meanyNew] ) ^ 2 < trackingThreshold )
                circles(1,1) = meanxNew;
                circles(1,2) = meanyNew;
                circles(1,3) = radiusNew;
                zerosInARow = 0;
            else
                zerosInARow = zerosInARow + 1;
                realValsInARow = 0;
            end
        end
    else
        %if object hasn't yet been detected, then set it to new
        %detection as long as been detected twice in a row
        realValsInARow = realValsInARow + 1;
        zerosInARow = 0;
        if (realValsInARow >= 3)
            circles(1,1) = meanxNew;
            circles(1,2) = meanyNew;
            circles(1,3) = radiusNew;
        end
    end
else
    zerosInARow = zerosInARow + 1;
    realValsInARow = 0;
    if (zerosInARow >= 2) %if 2 zeros in a row, then conclude it's off screen
        circles(1,1) = 0;
        circles(1,2) = 0;
        circles(1,3) = 0;
    end
end
display(strcat(datestr(now,'HH:MM:SS'),' [INFO] Detection Finished'));

shouldCallDetector = 1;


end
