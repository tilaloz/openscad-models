use <CylinderGrid.scad>;

// Parameters for SAE 1/4-in drive 6-point
meas_dia = [[19.5,17.5,15.8,14.6,13.0,11.9,11.4,11.4,11.4,11.8,undef],
            [19.6,17.9,15.8,14.2,13.0,11.9,11.5,11.5,11.4,11.5,11.4 ]];
meas_length = [[for (i=[0:10]) 15.0],[for (i=[0:10]) 10]];
    
cylinder_grid(meas_dia,meas_length,scale=1.02,bias=0.5); 