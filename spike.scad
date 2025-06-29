$fn = 100;

// spiky sphere: cylinders radiating from center to form a spherical shape
module spiky_sphere(radius = 15, cyl_r = 0.5, step_deg = 30, rotate_step = 20) {

    for (rotate_deg = [0 : rotate_step : 360 - rotate_step]) {
        rotate([0, 0, rotate_deg]) {
            for(lat_deg = [30 : step_deg : 120]) {
                for(lon_deg = [0 : step_deg : 360 - step_deg]) {
                    lat = lat_deg * PI / 180;
                    lon = lon_deg * PI / 180;
                    dir = [sin(lat)*cos(lon), sin(lat)*sin(lon), cos(lat)];
                    // rotation axis and angle to align cylinder along dir
                    angle = acos(dir[2]) * 180 / PI;
                    axis = [-dir[1], dir[0], 0];
                    rotate(angle, axis)
                        cylinder(h = radius, r = cyl_r, center = false);
                }
            }
        }
    }

}

