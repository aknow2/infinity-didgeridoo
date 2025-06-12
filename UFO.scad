$fn = 100; // 滑らかにする

body_size = 75;
body_scale=0.4;
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
        cylinder(h=60, r=35);
          translate([0,0, -body_size*(body_scale+0.1)])
        cylinder(h=30, r=50);
    }
}

module ufo_booster() {
    translate([0,0, -body_size*(body_scale)+7.8]) {
        difference() {
            
            cylinder(r=51, h=15);
              
            cylinder(r=47, h=10);
            
            translate([45,0,0])
               scale([1,1,2])
                cube(size=10);
            
        }
          
    }
    
}


ufo_body();
ufo_booster();