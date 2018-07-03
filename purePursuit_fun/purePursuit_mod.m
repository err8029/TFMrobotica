function [controller] = purePursuit_mod(controller,lin)
controller.DesiredLinearVelocity = lin;
controller.MaxAngularVelocity = lin*3;
controller.LookaheadDistance = lin/4;
end

