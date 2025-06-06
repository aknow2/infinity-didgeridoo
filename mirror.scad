include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <threads.scad>
mid_r=83;
top_r=69;
bottom_r=85;

module body() {
  translate([0,0, -7])cylinder(h=5, r=top_r);
  difference() {
    translate([0,0, -13]) male_thread();
    translate([0,0,-30])cylinder(h=70, r=top_r);
  }
   translate([0,0, -2])cylinder(h=2, r=bottom_r);
}

difference( ) {
  body();
  translate([63, 0, -30])cube(size=[17,10,70], center=false);
}
