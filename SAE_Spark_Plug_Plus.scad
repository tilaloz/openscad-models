use <CylinderGrid.scad>;

// Parameters for SAE and Metric Hex Drive Sockets 6-point
meas_dia =    [[25.0,24.8,23.2,22.9,21.3],
               [25.1,22.2,17.9,17.1,19.0],
               [22.2,19.8,17.2,16.6,16.6],
               [16.0,14.6,12.6,12.0,undef]];
meas_length = [[15.0,15.0,13.0,11.0,14.0],
               [25.1,22.2,17.9,17.1,19.0]*0.6,
               [22.2,19.8,17.2,16.6,16.6]*0.6,
               [16.0,14.6,12.6,12.0,undef]*0.6];
    
//Need a min radius because sockets are bigger than the hex drive
cylinder_grid(meas_dia,meas_length);   