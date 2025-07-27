// パラメータ
thickness = 5;      // 線の太さ
segments = 30;       // 曲線の分割数
diamond_size = 20;   // ダイヤのサイズ

// Bézier曲線の計算（3次）
function bezier3(p0, p1, p2, p3, t) =
    let(
        u  = 1 - t,
        b0 = u*u*u,
        b1 = 3 * u*u * t,
        b2 = 3 * u * t*t,
        b3 = t*t*t
    )
    [ 
        p0[0]*b0 + p1[0]*b1 + p2[0]*b2 + p3[0]*b3,
        p0[1]*b0 + p1[1]*b1 + p2[1]*b2 + p3[1]*b3
    ];

// 曲線モジュール（厚み付き）
module thick_curve(p0, p1, p2, p3) {
    // 各点に円を置き、隣り合う円をhull()して太い線を表現
    pts = [ for (i = [0 : segments]) bezier3(p0, p1, p2, p3, i/segments) ];
    for (i = [0 : len(pts)-2]) {
        linear_extrude(3)
        hull() {
            translate([ pts[i][0], pts[i][1], 0 ])
                circle(d = thickness);
            translate([ pts[i+1][0], pts[i+1][1], 0 ])
                circle(d = thickness);
        }
    }
}

p0_left = [ 20,   0];
p1_left = [ 4, 20];
p2_left = [ 4, 35];
p3_left = [ 23, 60];

// 左右対称に描画
thick_curve(p0_left, p1_left, p2_left, p3_left);
mirror([1, 0, 0]) 
    thick_curve(p0_left, p1_left, p2_left, p3_left);

// 中央上部のダイヤ
module diamond(center=[100,220], size=diamond_size) {
    linear_extrude(3)
    polygon(points = [
        [ center[0]    , center[1] + size/4 ],
        [ center[0] - size/2, center[1] ],
        [ center[0]    , center[1] - size/2 ],
        [ center[0] + size/2, center[1] ]
    ]);
}

// ダイヤを少し持ち上げて配置
    diamond([0, 55], diamond_size);