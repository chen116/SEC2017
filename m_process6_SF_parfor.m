clear
clc
close all

% use vector % have multiple nodes % fog in_outmatrix 
%% find 1km by 1km square
clear
clc
close all
tic
format long
cntt= 1

%profile on
% 1km square

% 37.7638,-122.4165
% 37.7962,-122.4165
% 37.7638,-122.4565
% 37.7962,-122.4565


tl_lon = -122.443;
bl_lat = 37.775;


tl_lat = 37.785;

tr_lat = tl_lat ;
tr_lon = -122.430;


% 3km square
lon_diff = 0.0135;
lat_diff= 0.0112;
tl_lon = -122.443-lon_diff;
bl_lat = 37.775-lat_diff;


tl_lat = 37.785+lat_diff;

tr_lat = tl_lat ;
tr_lon = -122.430+lon_diff;

bl_lon = tl_lon;
br_lat = bl_lat;
br_lon = tr_lon ;


tl = [tl_lat tl_lon ];
tr =  [tr_lat tr_lon];
bl = [bl_lat bl_lon ];
br = [br_lat br_lon];

ma = [tl;tr;bl;br];


t_dist = lldistkm(tl,tr);
lon_dist = t_dist
l_dist = lldistkm(tl,bl);
lat_dist = l_dist
r_dist = lldistkm(tr,br);
b_dist = lldistkm(bl,br);

s_lat = l_dist/(tl_lat-bl_lat);
s_lon = t_dist/(tr_lon -tl_lon );
%center = [(l_dist)/2 (t_dist)/2];



h = figure;%set(h, 'Visible', 'off');
% 
r=0.5;
h = sqrt(3)/2;

%centers = r*[ 2*h,1;h,2.5;2*h,4;3*h,2.5]+r;


base = 3;
cnt = 1;

for i=1:base
    if mod(i,2)==0
        %even clos
        num=base;
        for j = 1:num
           centers(cnt,:) = r*[1+h+2*(j-1)*h,i*1.5+0.5]; 
           cnt = cnt +1;
        end  
    else
        %odd clos
        num=base-1;
        for j = 1:num
           centers(cnt,:) = r*[1+2*(j)*h,i*1.5+0.5];
           cnt = cnt +1;
        end          

    end
end
       
time_slot = 5;
% files = dir('test_data/*.txt');
% cnt=1;
% for file = files'
%     routes{cnt}= load(strcat('test_data/',file.name));
%     cnt=cnt+1;
%     % Do some stuff
% end
load('sf_routes');
cnt=size(routes,2);

has_routes_cnt = 0;
has_routes_index = [];
for k=1:cnt
    if(~isempty(routes{k}))
        has_routes_cnt=has_routes_cnt+1;
        has_routes_index(has_routes_cnt)=k;
    end

end

min_time=1211036344;
max_time=1213083384;

total_pred = 0;
correct_pred = 0;

car = []; % pre_location[lat lon], pre_timestamp, speed,  going_to
lat_scale = lat_dist/(tl_lat-bl_lat);
lon_scale = lon_dist/(tr_lon-tl_lon);



if( mod(base,2)==0)
    num_nodes = base/2*base+base/2*(base-1);
else
    num_nodes = (base-1)/2*(base)+(base-1)/2*(base-1)+base-1;
end

in_ma = zeros(num_nodes,num_nodes);
out_ma = in_ma;



cur_car_pos = zeros(1,has_routes_cnt);

num_cars =30%length(has_routes_index);
car=zeros(num_cars,5);
clrs=distinguishable_colors(num_cars);

for j = min_time:max_time
    if mod(j,10000)==0
       j 
    end
    
%     for k=1:num_cars%length(has_routes_index)
%         maps = routes{has_routes_index(k)};
%         time = flip(maps(:,3));
%         if(~isempty(find(time==j, 1)))
%             index = find(time==j, 1);
%             lon = (maps(index,2)-bl_lon).*lon_scale;
%             lat = (maps(index,1)-bl_lat).*lat_scale;
%             base_dis = 9999;
%             coor = [lat lon];
%             
%             for kk = 1:size(centers,1)
%                 dis = pdist([coor;centers(kk,:)],'euclidean');
%                 if(dis < base_dis)
%                     cur_pos = kk;
%                     base_dis = dis;
%                 end                
%             end
%             
%             cur_car_pos(k)=cur_pos;
%             
%         end
%     end
%     num_cars_cnt_node = zeros(1,num_nodes);
%     
%     for k=1:num_cars
%         if cur_car_pos(k)>0
%             num_cars_cnt_node(cur_car_pos(k)) = num_cars_cnt_node(cur_car_pos(k)) + 1;
%         end
%     end
%     incoming = 0;
%     for k=1:num_nodes
%         if(k~=4)
%            incoming = incoming + out_ma(k,4); 
%         else
%            incoming = incoming - out_ma(k,4) ; 
%         end
%         out_ma(k,4)=0;
%     end
%     num_cars_cnt_node(4)=num_cars_cnt_node(4)+incoming
%     
        
     for k=1:num_cars%length(has_routes_index)
         maps = routes{has_routes_index(k)};
        % maps(:,2) = (maps(:,2)-bl_lon).*lon_scale;
        % maps(:,1) = (maps(:,1)-bl_lat).*lat_scale;

        time =  (maps(:,3));
        if(~isempty(find(time==j, 1)))
            index = find(time==j, 1);
            lon = (maps(index,2)-bl_lon).*lon_scale;
            lat = (maps(index,1)-bl_lat).*lat_scale;
            coor = [lat lon];
% % % 
%             del_row = true(1,size(routes{has_routes_index(k)},1));
%             del_row(index)=false;
%             routes{has_routes_index(k)}=routes{has_routes_index(k)}(del_row,:);
%             clear('routes{has_routes_index(k)}');
            


            %if(pdist([coor; center],'euclidean')<0.5)
                if(car(k,1)==0)
                    car(k,:) = [lat lon j 0 0];
                else
                    pre_coor = [car(k,1) car(k,2)];
                    speed = pdist([coor; pre_coor],'euclidean')/(j-car(k,3));
                    going_to = 0;                                                            
                    if (pre_coor(1)-coor(1)~=0 && pre_coor(2)-coor(2)~=0 )
                            % check if prediction is correct:
                            if(car(k,5)>0)   
%                                 base_dis = 99999;
%                                 for kkk = 1:num_nodes
%                                     dis =  pdist([coor;centers(kkk,:)],'euclidean') ;
%                                     if (dis < base_dis)
%                                         base_dis = dis;
%                                         im_at = kkk;
%                                     end
%                                 end 
                                                dis = zeros(num_nodes,1);
                                                for kkk = 1:num_nodes
                                                        dis(kkk) =   pdist([coor;centers(kkk,:)],'euclidean') ;
                                                end
                                                [v , im_at] = min(dis);
                                if(im_at ==car(k,5) )
                                   correct_pred = correct_pred + 1; 
                                end
                                total_pred = total_pred +1;

                                plot([coor(2) pre_coor(2)],[ coor(1) pre_coor(1)],'-o','Color',clrs(k,:),'LineWidth',3)
                                hold on
                                     
                           end

                        for kk = 1:size(centers,1)
                            center = centers(kk,:);
                            

                            

                            
                            
                            if(pdist([coor; center],'euclidean')<r && pdist([pre_coor; center],'euclidean')<r)
                                if(lon == pre_coor(2))
                                    x_inter(1) = sqrt(r^2-(lon-center(2))^2)+center(1);
                                    x_inter(2) = -sqrt(r^2-(lon-center(2))^2)+center(1);
                                    itersecs = [x_inter(1) lon ;x_inter(2) lon ];
                                else

                                    a =  (lat - pre_coor(1)) / (lon - pre_coor(2));
                                    b = lat-a*lon;
                                    x_inter = roots([1+a^2 -2*center(2)+2*a*(b-center(1)) center(2)^2+(b-center(1))^2-r^2 ]);
                                    itersecs = [a*x_inter(1)+b x_inter(1) ;a*x_inter(2)+b x_inter(2) ];
                                end

                                 if(isreal(x_inter))
                                    for iter = 1:2
                                        if( pdist([itersecs(iter,:); pre_coor],'euclidean')==...
                                                pdist([coor; pre_coor],'euclidean')+...
                                                pdist([coor; itersecs(iter,:)],'euclidean'))

                                           heading_toward = itersecs(iter,:);

                                            if(pdist([coor; heading_toward],'euclidean')/speed<time_slot)
                                                %heading_toward = (coor-pre_coor)./(j-car(k,3)).*time_slot + coor; %itersecs(iter,:);
                                                %x= coor(2)+(coor(2)-pre_coor(2));% heading_toward(2)-center(2);
                                                %y =coor(1)+(coor(1)-pre_coor(1));% heading_toward(1)-center(1);
                                                new_coor = coor*2-pre_coor;
                                             
                                                dis = zeros(num_nodes,1);
                                                for kkk = 1:num_nodes
                                                   % if (kkk~=kk)
                                                        dis(kkk) =  pdist([new_coor;centers(kkk,:)],'euclidean') ;
%                                                         if (dis < base_dis   )
%                                                             base_dis = dis;
%                                                             going_to = kkk;
% 
%                                                         end
                                                    %end

                                                end
                                                [v , going_to] = min(dis);
                                                if(~(going_to==4 || kk==4))
                                                    going_to = 0;
                                                    
                                                else

%                                                     out_ma(kk,going_to)=out_ma(kk,going_to)+1;
                                                    plot([new_coor(2) coor(2)  ],[new_coor(1) coor(1) ],'-d','Color',clrs(k,:),'MarkerSize',5)
                                                    hold on                                                    
                                                    plot([coor(2) pre_coor(2)],[coor(1) pre_coor(1)],'-*','Color',clrs(k,:))
                                                    hold on
%                                                     plot([new_coor(2) heading_toward(2) ],[new_coor(1) heading_toward(1) ],'-d','Color',clrs(k,:),'MarkerSize',5)
%                                                     hold on                                                    
%                                                     plot([heading_toward(2) coor(2) pre_coor(2)],[heading_toward(1) coor(1) pre_coor(1)],'-*','Color',clrs(k,:))
%                                                     hold on
%                                                     plot([coor(2) pre_coor(2)],[coor(1) pre_coor(1)],'-o','Color',clrs(k,:))
%                                                     hold on
                                                end
                                      
                                            end
                                            cntt=cntt+1;



                                        end
                                    end

                                 end

                            end % <0.5
                        end% where center matter
                        
                        
                        
                    end  

                    car(k,:) = [lat lon j speed going_to];
                end

           %  end % <0.5 
        end





     end
end

 





for i=1:size(centers,1)
   
    x=r*[-1 -0.5 0.5 1 0.5 -0.5 -1]+centers(i,2);
    y=r*sqrt(3)*[0 -0.5 -0.5 0 0.5 0.5 0]+centers(i,1);
    plot(x,y,'-r','Linewidth',1)
    hold on
    plot(centers(i,2),centers(i,1),'rd')
    hold on
   
    ang=0:0.05:2*pi; 
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(centers(i,2)+xp,centers(i,1)+yp,'-b');
    hold on
end



hold off
    lon_max = r*(1+base*1.5+1+0.5)
    lat_max=r*(1+2*base*h+1)
   xlabel('km')
   ylabel('km')
  xlim([0 lon_max])
  ylim([0 lat_max])


toc
% saveas(h,'figure','png');
savefig('sf_535cars.fig')
%openfig('newout.fig','new','visible')
correct_pred
total_pred 
suc_rate = correct_pred/total_pred 

%profile viewer
%min time 1211048366
%max time 1213082663
