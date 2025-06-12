include <BOSL2/std.scad>
include <BOSL2/screws.scad>

translate([-15, 0, 0])
nut("1/4-20,.5", shape="square", $slope=0.2, $fn=100, thickness=8);

nut("1/4-20,.5", shape="square", $slope=0.25, $fn=100, thickness=10);
translate([15, 0, 0])
nut("1/4-20,.5", shape="square", $slope=0.3, $fn=100, thickness=12);

translate([30, 0, 0])
nut("1/4-20,.5", shape="square", $slope=0.4, $fn=100, thickness=14);