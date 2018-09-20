classdef Manual_nav < handle
    %MANUAL_NAV Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods (Access=public)
        function MN=Manual_nav()
        end
        function key_velCommand2(~,GUI,ID,key)
            if strcmp('up2',ID) || strcmp('uparrow',key)%move up robot 2
                %update images
                if GUI.img_rate2==3
                    GUI.robots.display_image(GUI.enable_bts.enable2,GUI.img2_handle,2)
                    GUI.img_rate2=0;
                end
                for c=1:1:1
                    GUI.robots.send_velocity(GUI.robots.vel2,0,2)
                end 
                 GUI.img_rate2=GUI.img_rate2+1;
            end
            if strcmp('down2',ID) || strcmp('downarrow',key)%move down robot 2
                %update images
                if GUI.img_rate2==3
                    GUI.robots.display_image(GUI.enable_bts.enable2,GUI.img2_handle,2)
                    GUI.img_rate2=0;
                end
                for c=1:1:1
                    GUI.robots.send_velocity(-GUI.robots.vel2,0,2)
                end
                 GUI.img_rate2=GUI.img_rate2+1;
            end
            if strcmp('left2',ID) || strcmp('leftarrow',key)%move left robot 2
                %update images
                if GUI.img_rate2==3
                    GUI.robots.display_image(GUI.enable_bts.enable2,GUI.img2_handle,2)
                    GUI.img_rate2=0;
                end
                for c=1:1:1
                    GUI.robots.send_velocity(0,GUI.robots.w2,2)
                end
                 GUI.img_rate2=GUI.img_rate2+1;
            end
            if strcmp('right2',ID) || strcmp('rightarrow',key)%move right robot 2
                %update images
                if GUI.img_rate2==3
                    GUI.robots.display_image(GUI.enable_bts.enable2,GUI.img2_handle,2)
                    GUI.img_rate2=0;
                end
                for c=1:1:1
                    GUI.robots.send_velocity(0,-GUI.robots.w2,2)
                end
                 GUI.img_rate2=GUI.img_rate2+1;
            end
        end
        function key_velCommand(~,GUI,ID,key)
            if strcmp('up',ID)|| strcmp('w',key)%move up robot 1
                %update images
                if GUI.img_rate1==3
                    GUI.robots.display_image(GUI.enable_bts.enable1,GUI.img1_handle,1)
                    GUI.img_rate1=0;
                end
                for c=1:1:1
                    GUI.robots.send_velocity(GUI.robots.vel1,0,1)
                end
                GUI.img_rate1=GUI.img_rate1+1;
            end
            if strcmp('down',ID) || strcmp('s',key)%move down robot 1
                %update images
                if GUI.img_rate1==3
                    GUI.robots.display_image(GUI.enable_bts.enable1,GUI.img1_handle,1)
                    GUI.img_rate1=0;
                end
                for c=1:1:1
                    GUI.robots.send_velocity(-GUI.robots.vel1,0,1)
                end
                GUI.img_rate1=GUI.img_rate1+1;
            end
            if strcmp('left',ID) || strcmp('a',key)%move left robot 1
                 %update images
                if GUI.img_rate1==3
                    GUI.robots.display_image(GUI.enable_bts.enable1,GUI.img1_handle,1)
                    GUI.img_rate1=0;
                end
                for c=1:1:1
                    GUI.robots.send_velocity(0,GUI.robots.w1,1)
                end
                GUI.img_rate1=GUI.img_rate1+1;
            end
            if strcmp('right',ID) || strcmp('d',key)%move right robot 1
                %update images
                if GUI.img_rate1==3
                    GUI.robots.display_image(GUI.enable_bts.enable1,GUI.img1_handle,1)
                    GUI.img_rate1=0;
                end
                for c=1:1:1
                    GUI.robots.send_velocity(0,-GUI.robots.w1,1)
                end
                GUI.img_rate1=GUI.img_rate1+1;
            end
        end
    end
end

