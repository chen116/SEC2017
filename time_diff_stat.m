clear
load('sf_routes');
%load('rome_routes');
has_routes_cnt = 0;
has_routes_index = [];

cnt=size(routes,2);
for k=1:cnt
    if(~isempty(routes{k}))
        has_routes_cnt=has_routes_cnt+1;
        has_routes_index(has_routes_cnt)=k;
    end

end
clrs=distinguishable_colors(has_routes_cnt);
num_cars = length(has_routes_index);

modes = zeros(num_cars,1);
for  k=1:num_cars%length(has_routes_index)
         maps = routes{has_routes_index(k)};
         
         time =  (maps(:,3))';
         dif_arr= diff(time);
         modes(k)=mode(diff(time));
         
         
end
datastats(modes)
