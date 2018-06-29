function send_velocity2(lin,ang)
    global vel2_pub

    msg_vel = rosmessage(vel2_pub);
    msg_vel.Linear.X=lin;
    msg_vel.Linear.Y=lin;
    msg_vel.Linear.Z=lin;
    msg_vel.Angular.X=ang;
    msg_vel.Angular.Y=ang;
    msg_vel.Angular.Z=ang;
    send(vel2_pub,msg_vel)
end