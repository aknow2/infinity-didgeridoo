include <BOSL2/std.scad>
function calc_joint_angle(angle) = [-90,0, 90-(180-angle)/2];

module didgeridoo(scale=0) {
// mouse
translate([45,0,158]){
 mouse_h = 25;
 mouse_r = 16.5;
 if (scale>0) {
   cylinder(h=mouse_h,r1=14+scale+1, r2=mouse_r+scale+1, $fn=128);
 } else {
   cylinder(h=mouse_h*2,r1=14, r2=mouse_r, $fn=128);
 }
 sphere(r=14+scale*2);
 translate([0,0,-1.2])
 rotate([0,90,0])
  cylinder(h=10, r=13+scale, $fn=32);
}

// bottom bell pipe
b_r2=26+scale*11;
b_r1=30+scale*11;
b_h=125;
cylinder(h=b_h, r1=b_r1, r2=b_r2, $fn=64);
translate([0,0,b_h]) {
   if (scale>0) {
     scale([1,1,0.55])
     sphere(r=b_r2+1, $fn=64);  
   }else{
     sphere(r=b_r2+1, $fn=32);
   }
} 

r=60;
small_r_offset = 0;
small_r=14+scale;
small_h=137;
small_joint_h=34;
translate([0,0,19]) {
  // small vertical pipes
  s_angle=33;
  for(start = [0: s_angle: 100]) {
      rotate([0,0,start])
      translate([r+small_r_offset,0,0])
         cylinder(h=small_h, r=small_r, $fn=32);
      
      rotate([0,0,start])
          translate([r+small_r_offset,0,0])
             sphere(r=small_r);
             translate([0,0,small_h]) {
                    rotate([0,0,start])
                      translate([r+small_r_offset,0,0]) {
                            sphere(r=small_r);
                            
                      }
                      
            }
  }
  
  //small_joints
  // bottom joint
  for(start = [0: s_angle*2: 100]) {
          rotate([0,0,start])
            translate([r+small_r_offset,0,0])
                rotate(calc_joint_angle(s_angle))
                cylinder(h=small_joint_h, r=small_r, $fn=32);
  }
  // top joint
  translate([0,0,small_h]) {
      step = s_angle * 2;   
      for(start = [s_angle: step: 100]) {
          rotate([0,0,start])
            translate([r+small_r_offset,0,0]) {
                 
                    rotate(calc_joint_angle(s_angle))
                    cylinder(h=small_joint_h, r=small_r, $fn=32);    

            }
     }
  }

  //middle vertical pipe
  mid_r_offset=0;
  mid_r=18+scale;
  mid_h=130;
  mid_angle=60;
  mid_start=135;
  mid_joint_h = 57;
  translate([0,0,3]) {
      for(start = [mid_start: mid_angle: 310]) {
          rotate([0,0,start])
          translate([r+mid_r_offset,0,0])
             cylinder(h=mid_h, r=mid_r, $fn=128);
          rotate([0,0,start])
              translate([r+mid_r_offset,0,0])
                 sphere(r=mid_r);
          rotate([0,0,start])
              translate([r+mid_r_offset,0,0])
                 sphere(r=mid_r);
          translate([0,0,mid_h]) {
                    rotate([0,0,start])
                    translate([r+mid_r_offset,0,0]) {
                        
                          sphere(r=mid_r);
       
                        }
                 
              
          }
          
          if((start-mid_start)/mid_angle%2 == 0){
                rotate([0,0,start])
                translate([r+mid_r_offset,0,0]) {
                        rotate(calc_joint_angle(mid_angle))
                        cylinder(h=mid_joint_h, r=mid_r, $fn=32);                
                }           
          }else{
              translate([0,0,mid_h])
              rotate([0,0,start])
                translate([r+mid_r_offset,0,0]) {
                      rotate(calc_joint_angle(mid_angle))
                          cylinder(h=mid_joint_h, r=mid_r, $fn=32);
                }
                 
         }

      }
  }
  // large pipe
  l_h=117;
  l_r=23+scale;
  translate([0,0,4]) {
  rotate([0,0,310])
      translate([r-2,0,4]) {
         cylinder(h=l_h, r=l_r, $fn=128);
         sphere(r=l_r); 
         translate([0,0,l_h]){
            sphere(r=l_r);
            rotate([0,-106,0]) cylinder(h=61, r=l_r); 
         }  
      }
  }       
}
}

module skelton() {
  cylinder(r1=69,r2=50, h=55);
  translate([-40,0,145])
    rotate([90,0,90])
    torus(d_maj=55, d_min=20);
  difference() {
    rotate([0,0,60])
    translate([-57, 15, 0])
      torus(d_maj=50, d_min=20);
    rotate([0,0,60])
      translate([-60, 15, -10])
      cylinder(h=10, r=40, $fn=32);
  }
  didgeridoo(scale=3.8);
}

difference() {
 skelton();
 didgeridoo();
 sphere(r=33);
}
    
  

  