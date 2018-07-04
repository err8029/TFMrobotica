optimal_path=[4 3;5 3;6 3;7 3;8 3;9 3;10 3;11 3;12 3;13 3;14 3;15 3;16 3;17 4;17 5;17 6;17 7;17 8;17 9;17 10;17 11;17 12;17 13;17 14;17 15;17 16;17 17;17 18;17 19;17 20;17 21;16 22;15 23;14 23;13 23;12 23;11 23;10 23;9 22;9 21;9 20;10 19;11 19;12 18;12 17;12 16;11 15;10 14;9 13];
optimal_path=optimal_path';
final_dist=[];
final_s=[];
factor=sin(deg2rad(45));

%curve detection
figure(2)
for c=1:1:size(optimal_path,2)-1
    if optimal_path(2,c)~=optimal_path(2,c+1)
        if optimal_path(1,c)~=optimal_path(1,c+1)
            weight=0;
            %linear splines
            optimal_path_x=[optimal_path(1,c) optimal_path(1,c+1)];
            optimal_path_y=[optimal_path(2,c) optimal_path(2,c+1)];
            dist=min(optimal_path_x):0.25:max(optimal_path_x);
            s=pchip(optimal_path_x,optimal_path_y,dist);
            %curve splines
%             for i=1:1:length(s)
%                 if rem(length(s),2)~=0
%                     %concave curves
%                     if s(1)>s(2)
%                         if i<length(s)/2
%                             weight=weight+0.1;
%                             final_weigth=weight*factor;
%                             s(i)=s(i)+final_weigth;
%                             dist(i)=dist(i)+final_weigth;
%                         elseif i<length(s)/2 && i+1>length(s)/2
%                             s(i)=s(i)+final_weigth;
%                             dist(i)=dist(i)+final_weigth;
%                         else
%                             weight=weight-0.1;
%                             final_weigth=weight*factor;
%                             s(i)=s(i)+final_weigth;
%                             dist(i)=dist(i)+final_weigth;
%                         end
%                     end
%                     if s(1)<s(2)
%                         if i<=length(s)/2
%                             weight=weight+0.1;
%                             final_weigth=weight*factor;
%                             s(i)=s(i)-final_weigth;
%                             dist(i)=dist(i)-final_weigth;
%                         else
%                             weight=weight-0.1;
%                             final_weigth=weight*factor;
%                             s(i)=s(i)-final_weigth;
%                             dist(i)=dist(i)-final_weigth;
%                         end
%                     end
%                 else
%                     if s(1)<s(2)
%                         if i<=length(s)/2
%                             weight=weight+0.1;
%                             final_weigth=weight*factor;
%                             s(i)=s(i)+final_weigth;
%                             dist(i)=dist(i)+final_weigth;
%                         else
%                             weight=weight-0.1;
%                             final_weigth=weight*factor;
%                             s(i)=s(i)+final_weigth;
%                             dist(i)=dist(i)+final_weigth;
%                         end
%                     end
%                     if s(1)>s(2)
%                         if i<=length(s)/2
%                             weight=weight+0.1;
%                             final_weigth=weight*factor;
%                             s(i)=s(i)-final_weigth;
%                             dist(i)=dist(i)-final_weigth;
%                         else
%                             weight=weight-0.1;
%                             final_weigth=weight*factor;
%                             s(i)=s(i)-final_weigth;
%                             dist(i)=dist(i)-final_weigth;
%                         end
%                     end
%                 end
%             end
            final_dist=[final_dist dist];
            final_s=[final_s s];
            plot(dist,s)
            hold on
        end
    end
end
plot(final_dist,final_s,'*')
hold on
plot(optimal_path(1,:),optimal_path(2,:))
hold off