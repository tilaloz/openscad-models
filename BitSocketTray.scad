// Parameters that define the Bit Socket Tray
dia1 = 18.0*1.02+0.4;
dia2 = 11.9*1.02+0.4;
len1 = 26.9;
len2 = 22.2;

function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
diameter = cat([for (i=[0:22]) dia1],[for (i=[0:11]) dia2]);    
max_diameter = max(diameter);
length = cat([for (i=[0:22]) len1],[for (i=[0:11]) len2]); 

max_length = max(length);
min_length = min(length);

assert(len(diameter)==len(length),"Must have equal length diameter and length vectors");
n=ceil(sqrt(len(diameter)));
echo(n);

spacing = 2; // Intersocket Spacing
fn = 40;
fudge = 1/cos(180/fn); 

// Useful Functions that don't appear to be available in OpenSCAD
    // Sum a Vector
    function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;
    // Find the Cumulative Sum of the elements of a vector <= some index
    function cumsum(v, i = 0, r = 0,ind) = i < end ? cumsum(v, i + 1, r + v[i],ind) : r;
    // Cylinder with Circumscribed Flats instead of inscribed
   

//left_edges = [for (i = [0:n_sockets]) cumsum(diameter,end=i)];
//echo(left_edges);
//

module socket_slot(i,j,diameter,max_diameter,length,max_length,min_length,spacing) {
    difference(){
        // First the core cube
        cube([max_diameter+2*spacing,max_diameter+2*spacing,max_length+2*spacing-min_length/2.]); 

        // Subtract the cylinder for the socket
        if (length != undef) {
            translate([max_diameter/2.+spacing,max_diameter/2.+spacing,max_length+2*spacing-length])
            cylinder(h=length, r=diameter/2.*fudge,$fn=50);
        }

        }


    }


    for (i=[0:n-1]){
        if (diameter[n*i] != undef){
            for (j=[0:n-1]){
                translate([i*(max_diameter+2*spacing),j*(max_diameter+2*spacing),0])
                socket_slot(i,j,diameter[n*i+j],max_diameter,length[n*i+j],max_length,min_length,spacing); 
            }
        }
    }
