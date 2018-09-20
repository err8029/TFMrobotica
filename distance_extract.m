function [distance,dir] = distance_extract(new_scan)
    dis=[];
    new_scan=new_scan(:,2)';
    for i=1:1:length(new_scan)        
        if isnan(new_scan(i))==false
            dis=[dis new_scan(i)];
        end
    end
    %if all is NaN then the distance is outside the range of the sensor
    if isempty(dis)
        dis=5;
    end
    [distance index]=min(dis);
    if index<(length(new_scan)/2)
        dir='l';
    else
        dir='r';
    end
end

