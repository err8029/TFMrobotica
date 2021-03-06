function path_analyser(optimal_path,optimal_path2,MAP,MAP2,MAX_X,MAX_Y,xStart,yStart,xTarget,yTarget)
    replan_flag=0;    
    first=0;
    second=0;
    %run through the paths with the same speeds
    for n_pt1=1:1:length(optimal_path)
        for n_pt2=1:1:length(optimal_path2)
            if (optimal_path(n_pt1,:)<=optimal_path2(n_pt2,:)+1)
                first=true;
                if (optimal_path(n_pt1,:)>=optimal_path2(n_pt2,:)-1)
                    second=true;
                    if first==true && second==true && n_pt2==n_pt1
                        %obtain the coordenates of the collision point
                        pt=optimal_path(n_pt1,:);
                        pt2=optimal_path2(n_pt2,:);
                        %if both ways collide in the same point, save it in both
                        %maps
                        x=pt(1);
                        y=pt(2);
                        x2=pt(1);
                        y2=pt(2);
                        if pt==pt2
                            MAP(x,y)=-1;
                            MAP2(x,y)=-1;
                        %if both ways collide in a decimal point save an square in
                        %both maps
                        else
                            MAP(x,y)=-1;
                            MAP(x2,y2)=-1;
                            MAP(x2,y)=-1;
                            MAP(x,y2)=-1;

                            MAP2(x,y)=-1;
                            MAP2(x2,y2)=-1;
                            MAP2(x2,y)=-1;
                            MAP2(x,y2)=-1;
                        end
                        %collision found
                        replan_flag=1;
                    elseif n_pt2==length(optimal_path2) && n_pt1==length(optimal_path1)
                        replan_flag=2;
                    end
                end
            end
        end
    end 
    %replan and nav
    if replan_flag==1
        %A* algorithm   
        disp('collision detected')
        optimal_path=astar(xTarget,yTarget,xStart,yStart,MAP,MAX_X,MAX_Y);
        optimal_path2=astar(xTarget2,yTarget2,xStart2,yStart2,MAP2,MAX_X,MAX_Y);       
        %reanalyse the new paths
        path_analyser(optimal_path,optimal_path2,map,MAP,MAP2,MAX_X,MAX_Y,xStart,yStart,xTarget,yTarget)   
        %navigation
        nav(optimal_path,optimal_path2,xTarget,yTarget,xTarget2,yTarget2,xStart,yStart,xStart2,yStart2,dmap)
    elseif replanflag==2
        disp('no path')
    else
        disp('no collision')
    end
end

