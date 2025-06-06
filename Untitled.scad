module helical_tube(
    coil_info = [ [50, 30, 0], [70, 16, 58],  [60, 15, 93], [65, 13, 130], [34, 13, 150], [10, 13, 180]  ],
    segments_per_section = 600
) {
    for (i = [0 : len(coil_info)-2]) {
        start = coil_info[i];
        end = coil_info[i+1];

        for (j = [0 : segments_per_section-1]) {
            frac = j / (segments_per_section-1);

            radius_i      = start[0] + (end[0] - start[0]) * frac;
            tube_radius_i = start[1] + (end[1] - start[1]) * frac;
            z_i           = start[2] + (end[2] - start[2]) * frac;

            next_frac = (j+1) / (segments_per_section-1);
            radius_next = start[0] + (end[0] - start[0]) * next_frac;
            z_next      = start[2] + (end[2] - start[2]) * next_frac;

            // 角度は「進行度」に応じて均等に進める
            total_angle = 360;  // 1セクションあたり360度回す
            angle_i = total_angle * (i + frac);
            angle_next = total_angle * (i + next_frac);

            dx = radius_next * cos(angle_next) - radius_i * cos(angle_i);
            dy = radius_next * sin(angle_next) - radius_i * sin(angle_i);
            dz = z_next - z_i;

            len = sqrt(dx*dx + dy*dy + dz*dz) * 10;

            horizontal_angle = atan2(dy, dx);
            vertical_angle = atan2(dz, sqrt(dx*dx + dy*dy));

            translate([
                radius_i * cos(angle_i),
                radius_i * sin(angle_i),
                z_i
            ])
            rotate([90, vertical_angle, horizontal_angle+90])
                cylinder(h = len, r = tube_radius_i, $fn = 32);
        }
    }
}



helical_tube();

