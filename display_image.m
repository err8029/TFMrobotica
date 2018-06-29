function display_image(cam_msg,img_handle)
    axes(img_handle)
    imshow(img_view(cam_msg))
end