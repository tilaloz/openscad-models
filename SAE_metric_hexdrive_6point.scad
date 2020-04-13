use <CylinderGrid.scad>;

// Parameters for SAE and Metric Hex Drive Sockets 6-point
meas_dia =    [[7.3,7.3,7.3,7.3,7.3,7.3],
               [7.3,7.3,undef,7.3,7.3,7.3]];
meas_length = [[for (d=meas_dia[0]) 15], //Cheesy way to get same size vector of vectors (need to make helper function)
               [for (d=meas_dia[1]) 15]];
    
//Need a min radius because sockets are bigger than the hex drive
cylinder_grid(meas_dia,meas_length,min_grid_radius=8.5);  