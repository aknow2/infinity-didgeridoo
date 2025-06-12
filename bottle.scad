// bottle.scad - BOSL2を使ったネジ式水筒
include <BOSL2/std.scad>;
include <BOSL2/threading.scad>;

$fn = 100;

// パラメータ
bottle_outer_d = 70;      // 本体外径
bottle_inner_d = 60;      // 本体内径
bottle_height  = 150;     // 本体高さ
neck_height    = 18;      // ネジ部高さ
thread_pitch   = 2.5;     // ネジピッチ
cap_height     = 20;      // 蓋高さ
cap_thickness  = 4;       // 蓋の肉厚

// 本体
module bottle_body() {
    difference() {
        // 外側
        cylinder(d=bottle_outer_d, h=bottle_height);
        // 内側
        translate([0,0,4])
            cylinder(d=bottle_inner_d, h=bottle_height-4);
    }
    // ネジ部（外ネジ）
    translate([0,0,bottle_height])
        male_thread(dm=bottle_inner_d, pitch=thread_pitch, h=neck_height);
}

// 蓋
module bottle_cap() {
    // 蓋の外側
    cylinder(d=bottle_inner_d+cap_thickness*2, h=cap_height);
    // 内側をくり抜く
    difference() {
        // ネジ部（内ネジ）
        translate([0,0,cap_height-neck_height])
            female_thread(dm=bottle_inner_d, pitch=thread_pitch, h=neck_height);
        // 蓋の内側空間
        translate([0,0,neck_height])
            cylinder(d=bottle_inner_d, h=cap_height-neck_height);
    }
}

// 組み立て表示
bottle_body();
translate([0,0,bottle_height+neck_height+5]) bottle_cap();
