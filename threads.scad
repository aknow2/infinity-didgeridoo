// ──────────────────────────────────────────────────────
// ネジ穴（threaded_rod）
// ──────────────────────────────────────────────────────
include <BOSL2/threading.scad>;
$fn = 200;  // 滑らかさ

// --- パラメータ --- 
d_major = 160;  
pitch   = 5;     // ピッチ 5 mm
length  = 20;    // ネジ長さ 20 mm
thick   = 5;    // 雌ネジ穴の肉厚

// ── 雄ネジモジュール ──
module male_thread(bt=1, dm=d_major, p=pitch, l=length, th=thick) {
  translate([0,0,10])
  cylinder(h=bt, r=bottom_r);
  threaded_rod(
    d      = dm-1.5,
    pitch  = p,
    length = l
  );
}

// ── 雌ネジ穴モジュール ──
module female_thread(dm=d_major, p=pitch, l=length, th=thick) {
  difference() {
    // 外筒：雌ネジ穴用に肉厚を持たせる
    cylinder(h = l, d = dm + 2*thick);
    // 内部に雌ネジを切る
    translate([0, 0, l/2])
    threaded_rod(
      d        = dm,
      pitch    = p,
      length   = l,
      internal = true
    );
  }
}
