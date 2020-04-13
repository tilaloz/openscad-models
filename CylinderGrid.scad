// Useful Functions that don't appear to be available in OpenSCAD
// Sum a Vector
function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;
// Find the Cumulative Sum of the elements of a vector <= some index
function cumsum(x,pos=0,sum=0,res=[]) =
        (pos == len(x)) ? res :
                cumsum(x, pos=pos+1,
            sum=sum+x[pos], res=concat(res,sum+x[pos]));
// Concatenate to vectors together
function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
// input : nested list
// output : list with the outer level nesting removed
function flatten(l) = [ for (a = l) for (b = a) b ] ;

// Some unique function to CylinderGrid

// Inner Diamter that needs some margin 
function id_margin(id,scale,bias) = [for (row=id) [for (item=row) scale*item + bias ]];

//Max that works reliably regardless of whether or not there is an undef at the beginning
function my_max(a) = max([for (i=a) if (is_num(i)) i]); 
// Find the max of each "column" in a vector of vectors
function col_max(a) = [for (i=[0:len(a[0])-1]) my_max([for (row=a) if (row[i]!=undef) row[i]]) ];

// Parameters that every CylinderGrid
connector_thickness = 3;
wall_thickness = 1.5;
bottom = 2;
fn = 50;
fudge = 1/cos(180/fn); 

//Left here as an example for testing
// Parameters for Bit Socket Tray 
dia1 = 18.0;
dia2 = 11.9;
len1 = 26.9; //Consider shortening for faster Print time
len2 = 22.2; //Consider shortening for faster Print time
meas_dia = [[dia1,dia1,dia1,dia2,dia1,dia1],
            [dia1*1.2,dia1,dia2,dia2,dia1,dia1],
            [dia1,undef,dia1,dia2,dia1,dia1],
            [dia1,dia1,10,dia2,dia1,undef],
            [dia2,dia2,dia2,dia2,2,undef],
            [undef,dia2,dia2,undef,undef,undef]];
meas_length = [[len1,len1,len1,len2,len1,len1],
            [len1*1.2,len1,len2,len2,len1,len1],
            [len1,undef,len1,len1,len1,len1],
            [len1,len1,10,len1,len1,undef],
            [len2,len1,len2*1.4,len2,30,len2],
            [undef,len2,len2,len2,len2*0.8,len2]];

module cylinder_grid(meas_dia,meas_length,scale=1.02,bias=0.40,min_grid_radius=0){
    meas_dia_with_margin = id_margin(meas_dia,scale,bias);
    diameter = [ for (d=flatten(meas_dia_with_margin)) d] ;
    length = [ for (d=flatten(meas_length)) d] ;
        
    n = max([for (row=meas_dia) len(row)]);
    m = len(meas_dia);
    
    grid_x_spacing = [for (row=meas_dia_with_margin) 
        (my_max(row) + wall_thickness)/2.0 > min_grid_radius 
            ? (my_max(row) + wall_thickness)/2.0 : min_grid_radius];
    grid_y_spacing = [for (item=col_max(meas_dia_with_margin)) 
        (item + wall_thickness)/2.0 > min_grid_radius ? (item + wall_thickness)/2.0 : min_grid_radius ];
    
    grid_x = cumsum([0, for (i=[1:m-1]) grid_x_spacing[i]+grid_x_spacing[i-1]]);    
    grid_y = cumsum([0, for (j=[1:n-1]) grid_y_spacing[j]+grid_y_spacing[j-1]]);    
    echo(grid_x,grid_y);
    echo(grid_x_spacing,grid_y_spacing);
    
    
    
    
    // Calculate some results from Cylinder Grid
    max_length = max(length);
    min_length = min(length);
    
    echo(len(diameter),len(length));
    assert(len(diameter)==len(length),"Must have equal length diameter and length vectors");
       
    
    module connected_cylinder(inner_radius,hole_depth,wall_thickness,
                                grid_x_spacing,grid_y_spacing,connected){
        difference(){
            union(){
                cylinder(h=hole_depth+bottom,r=(inner_radius+wall_thickness),$fn=fn);
                for (i=[0:3]){
                    if (connected[i]){
                        rotate(90*i,[0,0,1])
                        translate([0,-connector_thickness/2.0,0])

                        cube([i%2==0 ? grid_x_spacing : grid_y_spacing ,connector_thickness,min_length]);
                        }
                }
            }
            translate([0,0,hole_depth+bottom-hole_depth])
            cylinder(h=hole_depth,r=(inner_radius),$fn=fn);
            }
    }
    
    
    
    
    for (i=[0:m-1]){
        for (j=[0:n-1]){
            if (diameter[n*i+j] != undef){
                translate([grid_x[i],grid_y[j],0])     
                connected_cylinder(diameter[n*i+j]/2.0,length[n*i+j],wall_thickness,
                grid_x_spacing[i],grid_y_spacing[j],
                [diameter[n*(i+1)+j]!=undef && (i<m-1), // Make sure +x neighbor exists and the we aren't off the grid
                 diameter[n*i+j+1]!=undef && (j<n-1),   // Make sure +y neighbor exists and the we aren't off the grid
                 diameter[n*(i-1)+j]!=undef && (i>0), // Make sure -x neighbor exists and the we aren't off the grid
                 diameter[n*i+j-1]!=undef && (j>0)]); // Make sure -y neighbor exists and the we aren't off the grid 
            }
        }
    }
}

// Test Code, only runs when not using use
cylinder_grid(meas_dia,meas_length);
echo(my_max([undef,3,undef]));


