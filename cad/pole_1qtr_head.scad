// SPDX-License-Identifier: CERN-OHL-S-2.0
// Xiaomi 1S pole-mount head
// Units: millimeters
// Use with a locking 1/4-inch friction arm, not a soft unloaded ball head.

/* [USER PARAMETERS] */

top_tab_thickness = 15;
top_tab_width = 90;
top_tab_height = 40;
base_width = 55;
base_depth = 35;
base_height = 24;

// Heat-set threaded insert for a 1/4-20 screw.
insert_diameter = 6.4;
insert_depth = 8.0;

/* [QUALITY] */

$fn = 64;

assert(top_tab_thickness >= 12,
       "top_tab_thickness below 12 mm may not hold the Xiaomi base securely");

module quarter_twenty_boss() {
    difference() {
        union() {
            translate([-base_width / 2, 0, 0])
                cube([base_width, base_height, base_depth]);

            translate([0, 0, base_depth / 2])
                rotate([90, 0, 0])
                    cylinder(
                        h = base_height,
                        d = 22,
                        center = false
                    );
        }

        // Vertical heat-set insert opening.
        translate([0, -1, base_depth / 2])
            rotate([-90, 0, 0])
                cylinder(
                    h = insert_depth,
                    d = insert_diameter
                );
    }
}

module top_tab() {
    translate([
        -top_tab_width / 2,
        base_height - 2,
        (base_depth - top_tab_thickness) / 2
    ])
        cube([
            top_tab_width,
            top_tab_height,
            top_tab_thickness
        ]);
}

module rear_gusset() {
    hull() {
        translate([-base_width / 2 + 4, base_height - 2, 2])
            cube([base_width - 8, 6, 6]);
        translate([-top_tab_width / 2 + 8, base_height + 18,
                   (base_depth - top_tab_thickness) / 2])
            cube([top_tab_width - 16, 6, 6]);
    }
}

union() {
    quarter_twenty_boss();
    top_tab();
    rear_gusset();
}

