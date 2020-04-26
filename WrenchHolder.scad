wrench_length=[80,130];
handle_depth=[15,25];
n_wrench = 4;
minimum_thickness = 5;

// Useful Functions that don't appear to be available in OpenSCAD
// Sum a Vector
function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;


module wrench_block(wrench_length,handle_depth,n_wrench,minimum_thickness,height){    
    linear_extrude(height,
    scale=[wrench_length[1]/wrench_length[0],handle_depth[1]/handle_depth[0]])
    square([wrench_length[0],handle_depth[0]], center=true);
}


module wrench_holder(wrench_length,handle_depth,n_wrench,minimum_thickness,height){
    difference(){
        wrench_block(wrench_length,handle_depth,n_wrench,minimum_thickness,height);
        inside_width = wrench_length - [for (d=wrench_length) 2*minimum_thickness];
        difference(){
            wrench_block(inside_width,handle_depth,n_wrench,minimum_thickness,height-minimum_thickness);
            translate([-wrench_length[1]/2,-handle_depth[1]/2,0])
            cube([wrench_length[1],handle_depth[1],minimum_thickness]);
            }
        for (i=[1:n_wrench]){
            translate([-wrench_length[1]/2,-handle_depth[1]/2,3*i*minimum_thickness])
            cube([wrench_length[1],handle_depth[1],handle_depth[1]]);
            
            }
        for (i=[1:n_wrench]){
            translate([-wrench_length[1]/2,-handle_depth[1]/2,3*i*minimum_thickness])
            cube([wrench_length[1],handle_depth[1],handle_depth[1]]);
            
            }
    }

}

height=(n_wrench+1)*minimum_thickness+n_wrench*sum(handle_depth)/2.0;
wrench_holder(wrench_length,handle_depth,n_wrench,minimum_thickness,height);