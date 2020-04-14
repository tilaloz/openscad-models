use <CylinderGrid.scad>;

// Parameters for SAE 3/8-in drive deep 6-point
short = 0.6;
meas_dia =    [[undef,undef,undef,undef,undef,undef,undef,undef,undef,16.7],
               [25.5,23.9,23.6,21.9,20.7,19.9,18.6,16.8,16.6,16.7],
               [26.0,24.0,23.7,22.2,20.9,19.8,18.8,17.3,16.7,16.7],
               [30.0,28.1,27.7,undef,undef,undef,16.7,16.7,16.7,16.7]];
meas_length = [[undef,undef,undef,undef,undef,undef,undef,undef,undef,16.7],
               [25.5,23.9,23.6,21.9,20.7,19.9,18.6,16.8,16.6,16.7],
               [26.0,24.0,23.7,22.2,20.9,19.8,18.8,17.3,16.7,16.7]*short,
               [30.0,28.1,27.7,undef,undef,undef,16.7,16.7,16.7,16.7]*short];    
cylinder_grid(meas_dia,meas_length); 