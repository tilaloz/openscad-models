use <CylinderGrid.scad>;

//Left here as an example for testing
// Parameters for Bit Socket Tray 
dia1 = 18.0;
dia2 = 11.9;
len1 = 26.9; //Consider shortening for faster Print time
len2 = 22.2; //Consider shortening for faster Print time
meas_dia = [[dia1,dia1,dia1,dia1,dia1,dia1],
            [dia1,dia1,dia1,dia1,dia1,dia1],
            [dia1,dia1,dia1,dia1,dia1,dia1],
            [dia1,dia1,dia1,dia1,dia1,undef],
            [dia2,dia2,dia2,dia2,dia2,dia2],
            [dia2,dia2,dia2,dia2,dia2,dia2]];
meas_length = [for (row=meas_dia) [for (item=row) item>=dia1 ? len1:len2 ]];
    
cylinder_grid(meas_dia,meas_length);