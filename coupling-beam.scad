include <configuration.scad>

coupling_height=27.5;
coupling_dia=19;
m3_nut=2.5;
m3_af=5.8;
m3_dia_clr=3.4;

module coupling()
{
	difference()
	{
		//body
		cylinder(h=coupling_height, r=coupling_dia/2, $fn=12);
		//m8 hole
		translate([0,0,-coupling_height*0.1]) polyhole(coupling_height*0.6, m8_diameter);
		//5mm hole for motor shaft
		translate([0,0,coupling_height*0.5]) polyhole(coupling_height*0.6, motor_shaft);
		//grub screw pocket
		translate([-(m3_nut+3),0,coupling_height-m3_af/2-1]) rotate([0,-90,0]) union()
			{
				translate([0,0,-coupling_dia/4]) polyhole(coupling_dia*0.6, m3_dia_clr);
				cylinder(h=m3_nut, r=m3_af/sqrt(3), center=true, $fn=6);
				translate([coupling_height/4,0,0]) cube([coupling_height*0.5,m3_af,m3_nut], center=true);
			}
		translate([0,0,7.5]) rotate([0,0,90])
			linear_extrude(height = 10, convexity = 10, twist = 900)
			translate([0, 0, 0])
			square(size=10);//circle(r = 4);
	}
}

coupling();

