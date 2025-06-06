
include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <threads.scad>
mid_r=83;
top_r=69;
bottom_r=85;

module body() {
    translate([0, 0, 3]) female_thread();
}

difference() {
cylinder(h=3, r=85);
cylinder(h=3, r=top_r);
}
body();
