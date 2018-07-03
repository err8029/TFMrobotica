function nav(optimal_path,optimal_path2)
%init the purepursuit controller
controller=purePursuit_init(optimal_path,1);
controller2=purePursuit_init(optimal_path2,1);

disp(controller)
disp(controller2)
end

