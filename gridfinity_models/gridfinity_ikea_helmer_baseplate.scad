use <../gridfinity_rebuilt_openscad/gridfinity-rebuilt-baseplate.scad>
include <../gridfinity_rebuilt_openscad/standard.scad>

// ===== INFORMATION ===== //
/*
Baseplate for Ikea Helmer. This model is split into 4 parts, so it fits
on smaller printers. Use the customizer to select the part to render.
*/

// ===== PARAMETERS ===== //
// Select the section to render
part = 4; // [0: Top right, 1: Top left, 2: Bottom left, 3: Bottom right, 4: All]

// ===== IMPLEMENTATION ===== //

/* [Hidden] */
$fa = 8;
$fs = 0.25;
gridx = 0; // Automatic, fit distance
gridy = 0; // Automatic, fit distance
distancex = 230; // Ikea Helmer
distancey = 400; // Ikea Helmer
style_plate = 0; // Thin
enable_magnet = false; 
style_hole = 0; // None
screw_together = false;
fitx = 0; // Equally distribute the padding on both sides
fity = 0; // Equally distribute the padding on both sides

module baseplate() {
    // TODO: Add a way to connect the parts
    // TODO: Measure the cabinet and use the actual dimensions
    gridfinityBaseplate(gridx, gridy, l_grid, distancex, distancey, style_plate, enable_magnet, style_hole, fitx, fity);
}

module connector() {
    translate([0, 0, 2])
    rotate([0, 90, 0])
    cylinder(80, 1, 1, center = true);
}

module connectors() {
    translate([-0.5 * l_grid, -4.5 * l_grid - 5, 0])
        connector();
    translate([-0.5 * l_grid, 4.5 * l_grid + 5, 0])
        connector();
    translate([-2.5 * l_grid - 5, -0.5 * l_grid, 0]) rotate([0, 0, 90])
        connector();
    translate([2.5 * l_grid + 5, -0.5 * l_grid, 0]) rotate([0, 0, 90])
        connector();
}

center = [-0.5 * l_grid, -0.5 * l_grid, -0.5 * l_grid];
dimensions = [10 * l_grid, 10 * l_grid, l_grid];

if (part > 3) {
    baseplate();
} else {
    difference() {
        intersection() {
            translate(center) rotate([0, 0, 90 * part]) cube(dimensions);
            baseplate();
        };
        connectors();
    }
}


