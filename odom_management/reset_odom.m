function reset_odom()
    global odom_pub_reset
    global odom_pub_reset2

    msg = rosmessage(odom_pub_reset);
    msg2 = rosmessage(odom_pub_reset2);
    
    send(odom_pub_reset,msg);
    send(odom_pub_reset2,msg2);
end

