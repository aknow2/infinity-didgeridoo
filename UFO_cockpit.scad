include <BOSL2/std.scad>
include <BOSL2/threading.scad>

$fn = 100; // 滑らかにする
body_size = 80; // UFO本体の直径
cockpit_size = 65; // コックピットの半径

d_major = (cockpit_size-2.4) * 2;
pitch   = 5;     // ピッチ 5 mm
length  = 20;    // ネジ長さ 20 mm
thick   = 5;    // 雌ネジ穴の肉厚
cockpit_height = 60;
roof_height = 30;
module ufo_cockpit() {

    difference() {
        // UFO cockpit
        cylinder(h = cockpit_height, r = cockpit_size+5);
        cylinder(h = 200, r= d_major/2, center=true);
        translate([0, 0, cockpit_height/2+10])
            rotate([90, 0, 0])
                cylinder(r = 12, h=200, center=true);

        translate([0, 0, cockpit_height/2+10])
            rotate([90, 0, 90])
                cylinder(r = 12, h=200, center=true);
    }

    // UFO cockpit roof
    translate([0, 0, cockpit_height])
        difference() {
            cylinder(h = roof_height, r1=cockpit_size+5, r2=cockpit_size/2);
            cylinder(h = roof_height-5, r1=cockpit_size, r2=cockpit_size/2-5);
        }
    difference() {
        cylinder(h = length, d = d_major + 2*thick);
        translate([0, 0, length/2])
            threaded_rod(
                d        = d_major,
                pitch    = pitch,
                length   = length,
                internal = true
            );
    }
}

translate([0, 0, cockpit_height + roof_height]) {
    difference() {
        rotate([90, 0, 0])
            torus(d_maj=20, d_min=10);
        translate([0, 0, -22])
            cylinder(h = 20, d = d_major + 2*thick);
    }
}

ufo_cockpit();
