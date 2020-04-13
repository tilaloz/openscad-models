use <CylinderGrid.scad>;

// Parameters for SAE 3/8-in drive deep 6-point
short = 0.6;
meas_dia =    [[29.8,27.8,25.6,24.0,22.0,19.9,18.6,16.8,16.6,16.7],
               [30.0,27.9,25.8,23.7,22.3,19.8,18.7,16.7,16.7,16.7],
               [34.0,31.9,undef,undef,undef,undef,undef,undef,undef,undef]];
meas_length =  [[29.8,27.8,25.6,24.0,22.0,19.9,18.6,16.8,16.6,16.7*short],
               [30.0,27.9,25.8,23.7,22.3,19.8,18.7,16.7,16.7,16.7]*short,
               [34.0,31.9,undef,undef,undef,undef,undef,undef,undef,undef]*short];    
cylinder_grid(meas_dia,meas_length); 