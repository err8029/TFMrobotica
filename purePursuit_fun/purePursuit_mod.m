<<<<<<< HEAD

=======
function [controller] = purePursuit_mod(controller,lin)
controller.DesiredLinearVelocity = lin;
controller.MaxAngularVelocity = lin*3;
controller.LookaheadDistance = lin/4;
end
>>>>>>> 072e61af2bb22ad289d5acff8730778f594b7e80

