use <CylinderGrid.scad>;

// Parameters for Metric 1/2-in drive  6-point
meas_dia =    [[30.0,28.0,27.6,27.1,26.0,24.0,23.1],
               [22.2,22.1,22.1,22.1,22.2,22.0,22.2]];
meas_length = [[30.0,28.0,27.6,27.1,26.0,24.0,23.1],
               [22.2,22.1,22.1,22.1,22.2,22.0,22.2]]*0.6;
cylinder_grid(meas_dia,meas_length); 