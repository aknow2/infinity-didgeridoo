include <BOSL2/std.scad>
include <BOSL2/threading.scad>

$fn = 100; // 滑らかにする
body_size = 90; // UFO本体の半径
body_scale=0.4;
cockpit_size = 65; // コックピットの半径

module ufo_body() {
    difference() {
        // UFO本体（スケーリングされた球体）
        union() {
            scale([1,1,body_scale])
                sphere(body_size, $fn=30);
        }
        cylinder(h=40, r=cockpit_size-8);
        translate([0,0, -45])
            cylinder(r=90, h=46);
    }
}
d_major = (cockpit_size-3) * 2;
pitch   = 5;     // ピッチ 5 mm
length  = 20;    // ネジ長さ 20 mm
thick   = 5;    // 雌ネジ穴の肉厚
translate([0,0, body_size*(body_scale)]) {
    difference() {
        union() {
            threaded_rod(
                d      = d_major-1.5,
                pitch  = pitch,
                length = length
            );
            translate([0,0, -length/2])
                cylinder(h = 3, d = d_major);
        }
        translate([0,0, -length])
            cylinder(r=(d_major-10)/2, h=length*5, center=true);
    }
}

module ufo_booster() {
    translate([0,0, -body_size*(body_scale) + 35]) {
        difference() {
            union() {
                // UFOのブースター部分
                cylinder(r=60, h=30);
                // UFOの足
                for (i = [0:5]) {
                    translate([0,0, 5])
                        rotate([0, 0, i*60])
                            translate([70, 0, 0])
                                sphere(r=13);
                }
            }
            cylinder(r=47, h=3);

            // レーザーポインタ射出部分
            cylinder(r=3, h=40);
            translate([0,0, 3+3])
                cylinder(r=7, h=40);

            translate([27,0, 0])
                scale([1,1.3,1])
                cylinder(r=7, h=140,center=true);
        }
    }
}

ufo_body();
ufo_booster();
