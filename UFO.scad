$fn = 100; // 滑らかにする

module ufo() {
    difference() {
        // UFO本体（スケーリングされた球体）
        union() {
            scale([1,1,0.3])
                sphere(75); // 直径150mmの扁平円盤

            // 上部ドーム
            translate([0, 0, 22.5])
                scale([1,1,0.5])
                    sphere(50);
        }

    }
}

ufo();
