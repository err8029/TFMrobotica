function [controller] = purePursuit_init(optimal_path,v,w,lookahead)
    controller = robotics.PurePursuit;
    controller.Waypoints = optimal_path;
    controller.DesiredLinearVelocity = v;%0.3
    controller.MaxAngularVelocity = w;%0.5
    controller.LookaheadDistance = lookahead;
end

