// Parameters that define the Socket Tray
diameter = [28, 26, 24, 21,19]; // Diameter of each of the Sockets
length = [64,64,64,62,62]; // Length of each of the Sockets
n_sockets = len(diameter); //assert len(diameter)==len(length)
spacing = 1; // Intersocket Spacing
bottom = 2; // Minimum bottom Spacing

// Useful Functions that don't appear to be available in OpenSCAD
    // Sum a Vector
    function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;
    // Find the Cumulative Sum of the elements of a vector <= some index
    function cumsum(v, i = 0, r = 0,ind) = i < end ? cumsum(v, i + 1, r + v[i],ind) : r;
    // Cylinder with Circumscribed Flats instead of inscribed
     module cylinder_outer(height,radius,fn){
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
        cube([diameter,length,diameter/2]);
        translate([diameter/2,0,0]) 
        rotate(-90,[1,0,0])
        translate([0,-diameter/2,0])
        cylinder(h=length, r=diameter/2,$fn=50);
        }  
    }

module socket_holder(diameter,next_diameter,length,spacing=0,bottom=0) {

    difference(){
        sloped_block(diameter+2*spacing,length+2*spacing,bottom+diameter/2,bottom+(next_diameter==undef ? diameter/2 :next_diameter/2));
        //translate([diameter/2,0,0]) 
        rotate(-90,[1,0,0])
        translate([diameter/2+spacing,-diameter/2-bottom,spacing])
        cylinder(h=length, r=diameter/2,$fn=50);
        }  
    }


    for (i=[0:n_sockets-1]){
        translate([spacing*(i+1) + left_edges[i],0,0])
        socket_holder(diameter[i],diameter[i+1],length[i],spacing,bottom); 
        }
