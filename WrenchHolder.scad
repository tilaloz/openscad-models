wrench_length=[80,130];
handle_depth=[15,25];
handle_thickness=[5.5,7.5];
n_wrench = 4;
minimum_thickness = 5;

// Useful Functions that don't appear to be available in OpenSCAD
// Sum a Vector
function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;


module wrench_block(wrench_length,handle_depth,n_wrench,minimum_thickness,height,handle_thickness){
    linear_extrude(height,
    scale=[wrench_length[1]/wrench_length[0],1])
    square([wrench_length[0],handle_depth[0]+minimum_thickness], center=true);
}

module wrench_block_1(wrench_length,handle_depth,n_wrench,minimum_thickness,height,handle_thickness){
        translate([0,(handle_depth[0]+minimum_thickness)*.5,0])
        rotate([90,0,0])
        linear_extrude(handle_depth[0]+minimum_thickness)
        polygon([[wrench_length[0]/2,0],[-wrench_length[0]/2,0],[-wrench_length[1]/2,height],[wrench_length[1]/2,height]]);
    }

module wrench_holder(wrench_length,handle_depth,n_wrench,minimum_thickness,height,handle_thickness){
    difference(){
        wrench_block(wrench_length,handle_depth,n_wrench,minimum_thickness,height);
        inside_width = wrench_length - [for (d=wrench_length) 2*minimum_thickness];
        difference(){
            wrench_block(inside_width,handle_depth,n_wrench,minimum_thickness,height-minimum_thickness);
            translate([-wrench_length[1]/2,-handle_depth[1]/2,0])
            cube([wrench_length[1],handle_depth[1],minimum_thickness]);
            }
        for (i=[1:n_wrench]){
            translate([-wrench_length[1]/2,-handle_depth[1]/2,2*i*minimum_thickness])
            rotate([-30,0,0])
            cube([wrench_length[1],handle_depth[1],5.0]);

            }
    }
  }


height=(n_wrench+1)*minimum_thickness+n_wrench*sum(handle_thickness)/2.0;
wrench_holder(wrench_length,handle_depth,n_wrench,minimum_thickness,height);
