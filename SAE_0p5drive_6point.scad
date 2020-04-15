use <CylinderGrid.scad>;

// Parameters for SAE 1/2-in drive  6-point
meas_dia =    [[33.5,32.0,30.0,27.8,27.0,undef],
               [25.3,23.1,22.1,22.1,22.1,22.1]];
meas_length = [[33.5,32.0,30.0,27.8,27.0,undef],
               [25.3,23.1,22.1,22.1,22.1,22.1]];    
cylinder_grid(meas_dia,meas_length); 