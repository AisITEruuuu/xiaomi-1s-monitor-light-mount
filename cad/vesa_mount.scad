// Xiaomi 1S VESA monitor-light adapter
// Units: millimeters
// The original Xiaomi magnetic/power base must stay assembled.

/* [USER PARAMETERS] */

// 75 or 100
vesa_pattern = 100;

// Distance from the top edge of the display to the center of the VESA holes.
monitor_top_to_vesa_center = 150;

// Front-to-back thickness of the mock monitor top edge.
// Xiaomi recommends a stable support for panels thinner than 10 mm.
top_tab_thickness = 15;

// Width and vertical height of the mock monitor top edge.
top_tab_width = 90;
top_tab_height = 40;

// Distance from the VESA back plane to the rear face of the mock top edge.
top_tab_back_z = 25;

// Space between the display top edge and the underside of the bridge.
top_clearance = 10;

// Main structures.
vesa_plate_width = 110;
vesa_plate_height = 110;
vesa_plate_thickness = 6;
riser_width = 60;
riser_thickness = 8;
bridge_width = 60;
bridge_height = 18;

/* [HARDWARE] */

vesa_hole_diameter = 4.5;
vesa_screw_head_diameter = 9.0;
vesa_screw_head_depth = 2.0;
cable_tie_hole_diameter = 4.0;

/* [QUALITY] */

$fn = 64;

assert(vesa_pattern == 75 || vesa_pattern == 100,
       "vesa_pattern must be 75 or 100");
assert(monitor_top_to_vesa_center > vesa_plate_height / 2,
       "VESA plate would overlap the top clearance zone");
assert(top_tab_thickness >= 12,
       "top_tab_thickness below 12 mm may not hold the Xiaomi base securely");

module vesa_plate() {
    difference() {
        translate([
            -vesa_plate_width / 2,
            -monitor_top_to_vesa_center - vesa_plate_height / 2,
            0
        ])
            cube([
                vesa_plate_width,
                vesa_plate_height,
                vesa_plate_thickness
            ]);

        for (x = [-vesa_pattern / 2, vesa_pattern / 2])
            for (y = [
                -monitor_top_to_vesa_center - vesa_pattern / 2,
                -monitor_top_to_vesa_center + vesa_pattern / 2
            ]) {
                translate([x, y, -1])
                    cylinder(
                        h = vesa_plate_thickness + 2,
                        d = vesa_hole_diameter
                    );

                // Rear countersink for the screw head.
                translate([x, y, -0.01])
                    cylinder(
                        h = vesa_screw_head_depth,
                        d1 = vesa_screw_head_diameter,
                        d2 = vesa_hole_diameter
                    );
            }
    }
}

module vertical_riser() {
    translate([
        -riser_width / 2,
        -monitor_top_to_vesa_center - vesa_plate_height / 2 + 6,
        0
    ])
        cube([
            riser_width,
            monitor_top_to_vesa_center + vesa_plate_height / 2
                + top_clearance + bridge_height,
            riser_thickness
        ]);
}

module forward_bridge() {
    translate([
        -bridge_width / 2,
        top_clearance,
        0
    ])
        cube([
            bridge_width,
            bridge_height,
            top_tab_back_z + top_tab_thickness
        ]);
}

module mock_monitor_top() {
    translate([
        -top_tab_width / 2,
        top_clearance,
        top_tab_back_z
    ])
        cube([
            top_tab_width,
            top_tab_height,
            top_tab_thickness
        ]);
}

module stiffening_gussets() {
    // Two side ribs between the rear riser and the forward bridge.
    for (x = [-bridge_width / 2 + 4, bridge_width / 2 - 8])
        hull() {
            translate([x, top_clearance - 24, riser_thickness - 1])
                cube([4, 24, 4]);
            translate([x, top_clearance + bridge_height - 4,
                       top_tab_back_z - 4])
                cube([4, 4, 4]);
        }
}

module cable_tie_tabs() {
    for (x = [-35, 25])
        difference() {
            translate([x, top_clearance + 2, 1])
                cube([10, 8, 5]);
            translate([x + 5, top_clearance + 6, -1])
                cylinder(
                    h = 7,
                    d = cable_tie_hole_diameter,
                    center = false
                );
        }
}

module complete_mount() {
    vesa_plate();
    vertical_riser();
    forward_bridge();
    stiffening_gussets();
    mock_monitor_top();
    cable_tie_tabs();
}

complete_mount();

