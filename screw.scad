// 分割数を上げて滑らかに
$fn = 64;

// ──────────────
// 2Dねじ山断面プロファイル（台形に近い形）
// pitch に合わせて柔軟に設定できます
// ──────────────
module thread_profile(D, pitch) {
    polygon(
        points=[
            [0,     D/2],
            [pitch/2,  0],
            [pitch, D/2]
        ],
        paths=[[0,1,2]]
    );
}

// ──────────────
// オスねじモジュール
// d1: 底部径（大径）
// d2: 先端径（小径）
// pitch: ピッチ
// length: ねじ長さ
// ──────────────
module male_thread(d1=16, d2=12, pitch=1.5, length=20) {
    turns = length / pitch;
    difference() {
        // ねじ軸
        cylinder(h=length, d1=d1, d2=d2);
        // ねじ山
        linear_extrude(
            height=length,
            twist=360 * turns,
            scale=d2 / d1
        )
            thread_profile(d1, pitch);
    }
}

// ──────────────
// メスねじモジュール
// body_d1/body_d2: 外径の大径・小径
// thread_d1/thread_d2: 内ねじ大径・小径
// pitch: ピッチ
// thickness: ネジ部分の厚み
// ──────────────
module female_thread(body_d1=18, body_d2=14,
                     thread_d1=16, thread_d2=12,
                     pitch=1.5, thickness=10) {
    turns = thickness / pitch;
    difference() {
        // ボディ本体
        cylinder(h=thickness, d1=body_d1, d2=body_d2);
        // 穴あけ（シンプルにシリンダーで）
        translate([0,0,-0.1])
            cylinder(h=thickness+0.2, d1=thread_d1, d2=thread_d2);
        // ねじ山（上下反転して内ねじにする）
        translate([0,0,0])
            rotate([180,0,0])
                linear_extrude(
                    height=thickness + pitch*2,
                    twist=360 * turns,
                    scale=thread_d2 / thread_d1
                )
                    thread_profile(thread_d1, pitch);
    }
}

// ──────────────
// プレビュー
// ──────────────
translate([-25, 0, 0])
    male_thread();

translate([ 25, 0, 0])
    female_thread();
