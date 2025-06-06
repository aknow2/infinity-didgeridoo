include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <threads.scad>
top_r=65;
bottom_r=85-2;

module body() {
  b_h=9;
  difference() {
    cylinder(h=b_h, r=bottom_r);
    translate([0,0,3])cylinder(h=b_h, r=bottom_r-5);
    cylinder(h=3, r=bottom_r-10);
  }
  translate([0, 0, b_h]) {
    body_h=50;
    translate([0, 0, body_h]) female_thread(dm=top_r*2);
  }
  difference() {
    translate([0,0,3])side_weave();// 棒を円柱形状でトリム（切り抜き）する
    cylinder(h=200, r=top_r+2);
  }
}

$fn     = 100;
outerR  = bottom_r-3;
height  = 40;
bar_w   = 5;
angle   = 31;     // 棒の傾き
count   = 55;     // 周方向の本数

module side_weave() {
  for (i = [0 : 360/count : 360-360/count]) {
    // 周回位置に回転
    rotate([0,0,i])
      // 外周に移動
      translate([outerR,0,0])
        // 棒を斜めに倒す
        rotate([angle,-24,0])
          // 棒を中心に Z 高さ分伸ばす
          translate([0, -bar_w/2, 0])
            cube([bar_w, bar_w, height / sin(angle)], center = false);
    // 逆方向の傾きをもう１セット
    rotate([0,0,i])
      translate([outerR,0,0])
        rotate([-angle,-24,0])
          translate([0, -bar_w/2, 0])
            cube([bar_w, bar_w, height / sin(angle)], center = false);
  }
}

difference() {
body();// 本体
translate([50, 0, 0])
rotate([90,0,90])
cylinder(r=6, h=70, center=false);
}

