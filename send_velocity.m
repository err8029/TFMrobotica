function send_velocity(lin,ang)
    global vel_pub

    msg_vel = rosmessage(vel_pub);
    msg_vel.Linear.X=lin;
    msg_vel.Linear.Y=lin;
    msg_vel.Linear.Z=lin;
    msg_vel.Angular.X=ang;
    msg_vel.Angular.Y=ang;
    msg_vel.Angular.Z=ang;
    send(vel_pub,msg_vel)
end

