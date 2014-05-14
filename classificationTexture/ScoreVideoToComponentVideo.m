function [ out, component ] = ScoreVideoToComponentVideo( scoreVideo )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

out = 0;
[L,num] = bwlabeln(scoreVideo);
max = 0;
component = 0;

for i = 1:num
    temp = sum(sum(sum(L==i)));
    if (temp>max)
        component=i;
        max = temp;
    end
end
if component == 0
    out = scoreVideo;
else
    %check if a good portion of biggest component is classified correcty.
    %If not then don't show it on screen
    %Good values are 0.007, .006, .005, .004, .003
    percentage = 0.015 * ( size(scoreVideo,1) * size(scoreVideo,2) * size(scoreVideo,3) );
    display(max);
    display(percentage);
    if (max < percentage)
        component = 0;
    else
        out = (L==component);
    end
end

end
