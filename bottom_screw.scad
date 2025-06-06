
include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <threads.scad>
top_r=65;
bottom_r=69;

difference() {
    male_thread(dm=top_r*2);
    translate([0,0,-30])cylinder(h=70, r=top_r-10);
 }