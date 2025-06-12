include <BOSL2/std.scad>
include <BOSL2/threading.scad>

$fn = 100; // 滑らかにする
body_size = 80; // UFO本体の直径
body_scale=0.4;
cockpit_size = 50; // コックピットの直径

module ufo_body() {
    difference() {
        // UFO本体（スケーリングされた球体）
        union() {
            scale([1,1,body_scale])
                sphere(body_size); // 直径150mmの扁平円盤

            // 上部ドーム
            //translate([0, 0, 22.5])
                //scale([1,1,0.5])
                    //sphere(50);
        }
        scale([1,1,body_scale])
                sphere(body_size-8); // 直径150mmの扁平円盤
        cylinder(h=60, r=cockpit_size-5);
          translate([0,0, -body_size*(body_scale+0.1)])
        cylinder(h=30, r=50);
    }
}
d_major = (cockpit_size-3) * 2;
pitch   = 5;     // ピッチ 5 mm
length  = 20;    // ネジ長さ 20 mm
thick   = 5;    // 雌ネジ穴の肉厚

translate([0,0, body_size*(body_scale)]) {
    difference() {
        threaded_rod(
            d      = d_major-1.5,
            pitch  = pitch,
            length = length,
            thick  = thick
        );
        translate([0,0, -length])
        cylinder(r=(d_major-10)/2, h=length*4);
    }

}


module ufo_booster() {
    translate([0,0, -body_size*(body_scale)+7.8]) {
        difference() {
            cylinder(r=51, h=15);
            cylinder(r=47, h=10);
        }
    }
}


ufo_body();
ufo_booster();