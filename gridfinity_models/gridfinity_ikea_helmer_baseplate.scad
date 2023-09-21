use <../gridfinity_rebuilt_openscad/gridfinity-rebuilt-baseplate.scad>
include <../gridfinity_rebuilt_openscad/standard.scad>

// ===== INFORMATION ===== //
/*
Baseplate for Ikea Helmer. This model is split into 4 parts, so it fits
on smaller printers. Use the customizer to select the part to render.
*/

// ===== PARAMETERS ===== //
// Select the section to render
part = 2; // [0: Top, 1: Bottom, 2: All]

// ===== IMPLEMENTATION ===== //

/* [Hidden] */
$fa = 8;
$fs = 0.25;
gridx = 0; // Automatic, fit distance
gridy = 8; // Reduced, so the top row is not under the edge
distancex = 225; // Ikea Helmer
distancey = 380; // Ikea Helmer
style_plate = 0; // Thin
enable_magnet = false; 
style_hole = 0; // None
screw_together = false;
fitx = 0; // Equally distribute the padding on both sides
fity = 0.5; // Equally distribute the padding on both sides

module baseplate() {
    gridfinityBaseplate(gridx, gridy, l_grid, distancex, distancey, style_plate, enable_magnet, style_hole, fitx, fity);
}

module connector() {
    translate([0, 0, 2])
    rotate([0, 90, 0])
    cylinder(80, 1, 1, center = true);
}

module connectors() { 
    translate([-0.5 * l_grid, 0, 0]) rotate([0, 0, 90]) connector();
    translate([-1.5 * l_grid, 0, 0]) rotate([0, 0, 90]) connector();
    translate([-2.5 * l_grid - 3, 0, 0]) rotate([0, 0, 90]) connector();
        
    for (i = [0.5 : 1 : 1.5]) {
        translate([i * l_grid, 0, 0]) rotate([0, 0, 90]) connector();    
    }
    translate([2.5 * l_grid + 3, 0, 0]) rotate([0, 0, 90]) connector();
}

center = [-4 * l_grid, 0, -0.5 * l_grid];
dimensions = [10 * l_grid, 10 * l_grid, l_grid];

if (part > 1) {
    baseplate();
} else {
    difference() {
        intersection() {
            translate(center) rotate([0, 0, -90 * part]) cube(dimensions);
            baseplate();
        };
        connectors();
    }
}


