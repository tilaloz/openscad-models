wrench_length=[80,130];
handle_depth=[15,25];
n_wrench = 4;
mininum_thickness = 5;

// Useful Functions that don't appear to be available in OpenSCAD
// Sum a Vector
function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;


module wrench_holder(wrench_length,handle_depth,n_wrench,minimum_thickness){
    difference(){
        linear_extrude((n_wrench+1)*mininum_thickness+n_wrench*sum(handle_depth)/2.0,
        scale=[wrench_length[1]/wrench_length[0],handle_depth[1]/handle_depth[0]])
        square([wrench_length[0],handle_depth[0]], center=true);
        translate([0,0,mininum_thickness])
        linear_extrude((n_wrench-1)*mininum_thickness+n_wrench*sum(handle_depth)/2.0,
        scale=[wrench_length[1]/wrench_length[0],handle_depth[1]/handle_depth[0]])
        square([wrench_length[0],handle_depth[0]], center=true);
    }
}
wrench_holder(wrench_length,handle_depth,n_wrench,minimum_thickness);