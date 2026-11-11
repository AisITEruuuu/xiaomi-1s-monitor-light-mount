// TX02 / Xiaomi 1S monitor-light one-piece VESA adapter
// Units: millimeters
// This is the printable counterpart of docs/tx02-vesa-cradle-r2.html.

/* [Output] */

part = "mount"; // [mount, fit_test]

/* [VESA adapter] */

vesa_plate_width = 120;
vesa_plate_height = 120;
vesa_plate_thickness = 6;
vesa_plate_center_z = 44;
vesa_hole_diameter = 4.5;

include_vesa_75 = true;
include_vesa_100 = true;

// 0 = plain through holes; -1 / 1 = countersink the front / rear face.
vesa_countersink_side = 0;
vesa_countersink_diameter = 9.0;
vesa_countersink_depth = 2.0;

/* [Integrated support] */

support_width = 63;
clamp_pad_height = 14;
clamp_pad_depth = 30;
clamp_pad_center_z = 34;
clamp_pad_top_y = 101.5;

guide_inner_gap = 55;
guide_tab_width = 4;
guide_tab_height = 12;

support_web_width = 48;
support_web_bottom_y = -50;
support_web_shoulder_y = 50;

/* [Quality] */

$fn = 64;

assert(include_vesa_75 || include_vesa_100,
       "At least one VESA pattern must be enabled");
assert(vesa_plate_width >= 110 && vesa_plate_height >= 110,
       "The VESA plate must leave material around the 100 mm holes");
assert(support_width == guide_inner_gap + 2 * guide_tab_width,
       "support_width must equal the guide inner gap plus two tab widths");

vesa_plate_left_face = vesa_plate_center_z - vesa_plate_thickness / 2;
vesa_plate_right_face = vesa_plate_center_z + vesa_plate_thickness / 2;
clamp_pad_center_y = clamp_pad_top_y - clamp_pad_height / 2;
guide_tab_x = guide_inner_gap / 2 + guide_tab_width / 2;

function support_profile() = [
    [clamp_pad_center_z - clamp_pad_depth / 2, clamp_pad_top_y],
    [clamp_pad_center_z - clamp_pad_depth / 2 + 10, clamp_pad_top_y],
    [vesa_plate_right_face, support_web_shoulder_y],
    [vesa_plate_right_face, support_web_bottom_y],
    [vesa_plate_right_face - 10, support_web_bottom_y]
];

module extrude_profile_x(width, points) {
    rotate([0, -90, 0])
        linear_extrude(height = width, center = true, convexity = 16)
            polygon(points = points);
}

module vesa_plate() {
    translate([0, 0, vesa_plate_center_z])
        cube([
            vesa_plate_width,
            vesa_plate_height,
            vesa_plate_thickness
        ], center = true);
}

module integrated_support() {
    extrude_profile_x(support_web_width, support_profile());

    translate([0, clamp_pad_center_y, clamp_pad_center_z])
        cube([
            support_width,
            clamp_pad_height,
            clamp_pad_depth
        ], center = true);

    for (x = [-guide_tab_x, guide_tab_x])
        translate([
            x,
            clamp_pad_top_y + guide_tab_height / 2,
            clamp_pad_center_z
        ])
            cube([
                guide_tab_width,
                guide_tab_height,
                clamp_pad_depth
            ], center = true);
}

module vesa_holes(pattern) {
    for (x = [-pattern / 2, pattern / 2])
        for (y = [-pattern / 2, pattern / 2]) {
            translate([x, y, vesa_plate_center_z])
                cylinder(
                    h = vesa_plate_thickness + 2,
                    d = vesa_hole_diameter,
                    center = true
                );

            if (vesa_countersink_side == -1)
                translate([x, y, vesa_plate_left_face - 0.01])
                    cylinder(
                        h = vesa_countersink_depth + 0.01,
                        d1 = vesa_countersink_diameter,
                        d2 = vesa_hole_diameter
                    );

            if (vesa_countersink_side == 1)
                translate([x, y, vesa_plate_right_face + 0.01])
                    mirror([0, 0, 1])
                        cylinder(
                            h = vesa_countersink_depth + 0.01,
                            d1 = vesa_countersink_diameter,
                            d2 = vesa_hole_diameter
                        );
        }
}

module fit_test() {
    // Print this first to verify the Xiaomi base fits the 55 mm guide gap.
    translate([0, 0, clamp_pad_height / 2])
        cube([
            support_width,
            clamp_pad_depth,
            clamp_pad_height
        ], center = true);

    for (x = [-guide_tab_x, guide_tab_x])
        translate([
            x,
            0,
            clamp_pad_height + guide_tab_height / 2
        ])
            cube([
                guide_tab_width,
                clamp_pad_depth,
                guide_tab_height
            ], center = true);
}

module mount() {
    difference() {
        union() {
            vesa_plate();
            integrated_support();
        }

        if (include_vesa_75)
            vesa_holes(75);
        if (include_vesa_100)
            vesa_holes(100);
    }
}

if (part == "fit_test")
    fit_test();
else
    mount();
