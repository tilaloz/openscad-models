// Parameters that define the Socket Tray
diameter = [29.8,27.8,25.6,24.0,22.0,19.9,18.6,16.8,16.6]*1.02; // Diameter of each of the Sockets
length = [64,64,64,64,64,60,60,58,56]; // Length of each of the Sockets
n_sockets = len(diameter); //assert len(diameter)==len(length)
spacing = 2; // Intersocket Spacing
  magnet_diameter = 9.525;
magnet_height = 3.175;
bottom = magnet_height+spacing; // Minimum bottom Spacing
fn = 40;
fudge = 1/cos(180/fn); 

// Useful Functions that don't appear to be available in OpenSCAD
    // Sum a Vector
    function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;
    // Find the Cumulative Sum of the elements of a vector <= some index
    function cumsum(v, i = 0, r = 0,ind) = i < end ? cumsum(v, i + 1, r + v[i],ind) : r;
    // Cylinder with Circumscribed Flats instead of inscribed
     module cylinder_outer(height,radius,fn=fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}

S = sum(diameter);

left_edges = [for (i = [0:n_sockets]) cumsum(diameter,end=i)];
echo(left_edges);

module sloped_block(width,depth,height1,height2){
    points = [  [0,0,0],
                [width,0,0],
                [0,depth,0],
                [width,depth,0],
                [0,0,height1],
                [0,depth,height1],
                [width,0,height2],
                [width,depth,height2]
    ];
    faces = [[0,1,3,2],
             [0,2,5,4],
             [3,1,6,7],
             [4,5,7,6],
             [2,3,7,5],
             [1,0,4,6]];
polyhedron(points,faces); 
    
    }
module socket_holder(diameter,length) {
    difference(){
        cube([diameter,length,diameter/2.]);
        translate([diameter/2.,0,0]) 
        rotate(-90,[1,0,0])
        translate([0,-diameter/2.,0])
        cylinder(h=length, r=diameter/2.*fudge,$fn=50);
        }  
    }

module socket(h,r) {
    difference(){
        cylinder(h=h, r=r*fudge,$fn=50);
        cylinder(h=spacing, r=3.0,$fn=50);
        }
    }
     
module socket_holder(diameter,next_diameter,length,spacing=0,bottom=0,magnets=false) {

    difference(){
        sloped_block(diameter+2*spacing,length+spacing,bottom+diameter/2,bottom+(next_diameter==undef ? diameter/2 :next_diameter/2)); 
        rotate([-90,0,0])
        // I don't understand why the second term needs minus sign. Translation must happen before rotation
        translate([diameter/2+spacing,-diameter/2-bottom,spacing])
        socket(h=length, r=diameter/2.*fudge);
        if (magnets) 
        translate([diameter/2.*fudge+spacing,length/2+spacing,spacing])
        cylinder(h=magnet_height*1.5, r=magnet_diameter/2.*fudge,$fn=40);
        }  
    }

module socket_holder_v2(diameter,max_diameter,length,max_length,spacing=0,bottom=0) {
    difference(){
        // First the core cube
        cube([diameter+2*spacing,max_diameter+2*spacing+magnet_height,max_length/2.0]); 

        // Subtract the cylinder for the socket
        translate([diameter/2.+spacing,diameter/2.+spacing,max_length-length+2*spacing])
        cylinder(h=length, r=diameter/2.*fudge,$fn=50);
        // Subtract a viewing window for the socket
        translate([0,0,max_length-length+2*spacing])
        rotate(45,[1,0,0])
        cube([diameter+2*spacing,10,10]);
        //Make room for magnets in the back. 
        translate([diameter/2.+spacing,max_diameter+2*spacing+magnet_height,max_length/4.0])
        rotate(90,[1,0,0])
        cylinder(h=magnet_height*1.1, r=magnet_diameter/2.*fudge+0.2,$fn=40);
        }


    }


    for (i=[0:n_sockets-1]){
        echo(i,diameter[i],max(diameter),length[i],max(length),spacing);
        translate([spacing*(i) + left_edges[i],0,0])
        socket_holder_v2(diameter[i],max(diameter),length[i],max(length),spacing,bottom); 
        }
        
        
        //I got the Magnet holes working. Can't figure out why Cylinder_outer doesn't work when doing differences. Need to just put in some realistic sizes and try one now. 
        
