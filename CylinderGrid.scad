// Useful Functions that don't appear to be available in OpenSCAD
// Sum a Vector
function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;
// Find the Cumulative Sum of the elements of a vector <= some index
function cumsum(v, i = 0, r = 0,ind) = i < end ? cumsum(v, i + 1, r + v[i],ind) : r;
// Concatenate to vectors together
function cat(L1, L2) = [for(L=[L1, L2], a=L) a];

// Parameters that every CylinderGrid
connector_thickness = 4;
wall_thickness = 2;
bottom = 2;
fn = 50;
fudge = 1/cos(180/fn); 


// Parameters for this Cylinder grid
dia1 = 18.0*1.02+0.4;
dia2 = 11.9*1.02+0.4;
len1 = 26.9;
len2 = 22.2;
diameter = cat([for (i=[0:22]) dia1],[for (i=[0:11]) dia2]);    
grid_radius = (max(diameter)+wall_thickness)/2.0;
length = cat([for (i=[0:22]) len1],[for (i=[0:11]) len2]);
 
max_length = max(length);
min_length = min(length);

assert(len(diameter)==len(length),"Must have equal length diameter and length vectors");
//n=ceil(sqrt(len(diameter)));
n=5;
m=7;



   

module connected_cylinder(inner_radius,height,hole_depth,wall_thickness,grid_radius,connected){
    difference(){
        union(){
            cylinder(h=hole_depth+bottom,r=(inner_radius+wall_thickness),$fn=fn);
            for (i=[0:3]){
                if (connected[i]){
                    rotate(90*i,[0,0,1])
                    translate([0,-connector_thickness/2.0,0])
                    cube([grid_radius,connector_thickness,height/2.0]);
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
            translate([2*i*grid_radius,2*j*grid_radius,0])
            connected_cylinder(diameter[n*i+j]/2.0,max_length,length[n*i+j],wall_thickness,grid_radius,
            [diameter[n*(i+1)+j]!=undef && (i<m-1), // Make sure +x neighbor exits and the we aren't off the grid
             diameter[n*i+j+1]!=undef && (j<n-1),   // Make sure +y neighbor exits and the we aren't off the grid
             diameter[n*(i-1)+j]!=undef && (i>0), // Make sure -x neighbor exits and the we aren't off the grid
             diameter[n*i+j-1]!=undef && (j>0)]); // Make sure -y neighbor exits and the we aren't off the grid 
        }
    }
}


    
