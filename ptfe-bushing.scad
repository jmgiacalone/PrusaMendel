// PRUSA Mendel  
// Bushings
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// Print them in PLA and glue them to place
// if they are too tight, define bigger rodsize
// or you can try to sand a bt off


// TYPE Can generate three versions
// 1 - regular old ones
// 2 - helical ones
// 3 - holders for brass or any other bought bushings


include <configuration.scad>

rodsize = bushing_rodsize;
outerDiameter = bushing_outerDiameter;
innerDiameter = 10.6;
length = bushing_lenght;
//type = bushing_type;
type=4;


module bushing_core_straight(){
union(){
	rotate(a=[0,0,45])
	difference(){
		union(){
			//outer ring
			difference(){
				union(){
					cylinder(h = length, r=outerDiameter/2); //1mm lemování
					//cylinder(h = 1, r=outerDiameter/2+2);
				}
				translate(v=[0,0,-1]) cylinder(h = length+2, r=(outerDiameter/2)-2);
			}

			//nipples inside touching the rod
			difference(){
				union(){
					translate(v=[0,0,length/2]) cube(size = [outerDiameter-1,2,length], center = true);
					translate(v=[0,0,length/2]) cube(size = [2,outerDiameter-1,length], center = true);
				}
				translate(v=[0,0,-1]) cylinder(h = length+2, r=rodsize/2, $fn=20);
			}
		}
		//opening cutout
		translate(v=[(outerDiameter/2)+1,(outerDiameter/2)+1,(length)/2]) cube(size = [outerDiameter,outerDiameter,length+2], center = true);
		
		}
	}
}
module bushing_core_holder(){
union(){
	rotate(a=[0,0,45])
	difference(){
		union(){
			//outer ring
			difference(){
				union(){
					cylinder(h = length, r=outerDiameter/2); //1mm lemování
					//cylinder(h = 1, r=outerDiameter/2+2);
				}
				translate(v=[0,0,-1]) cylinder(h = length+2, r=(rodsize/2));
			}
		}
		//opening cutout
		translate(v=[(outerDiameter/2)+1,(outerDiameter/2)+1,(length)/2]) cube(size = [outerDiameter,outerDiameter,length+2], center = true);
		
		}
	}
}

module bushing_core_helical(){
	difference(){
		rotate(a=[0,0,44]) translate(v=[0,0,(length)/2]) linear_extrude(center = true, height = length, twist = 90,convexity = 20) projection(cut = true) bushing_core_straight();
		translate(v=[0,-2.3,0]) rotate(a=[0,0,45]) translate(v=[(outerDiameter/2)+1,(outerDiameter/2)+1,(length)/2]) cube(size = [outerDiameter,outerDiameter,length+2], center = true);
		// hack for easier cleanup
		translate(v=[0,0,-0.5]) cylinder(h = 1, r=rodsize/2+1, $fn=20);
	}
}

module bushing(){
	difference(){
		translate(v=[0,-outerDiameter/4,length/2]) cube(size = [outerDiameter, outerDiameter/2,length], center = true);
		translate(v=[0,0,-1]) cylinder(h = length+2, r=outerDiameter/2-2);//
		if(type == 4){
			translate([0,0,length/2]) cube([outerDiameter, 4,length], center=true);
			for(i=[1,-1])
			{
				translate([i*outerDiameter*0.66,0,length/2]) rotate([0,0,i*30]) cube([outerDiameter*0.6,outerDiameter*0.8,length], center=true);
			}
		}

	}
	if(type == 1){
		bushing_core_straight();
	}
	if(type == 2){
		bushing_core_helical();
	}
	if(type == 3){
		bushing_core_holder();
	}
	if(type == 4){
		bushing_core_ptfe();
	}
}
module bushing_core_ptfe(){
union(){
	difference(){
		union(){
			//outer ring
			difference(){
				union(){
					cylinder(h = length, r=outerDiameter/2-1.5); //1mm lemování
					//cylinder(h = 1, r=outerDiameter/2+2);
				}
				translate(v=[0,0,-1]) cylinder(h = length+2, r=innerDiameter/2);
			}

			//nipples inside touching the rod
			rotate([0,0,90])
			difference(){
				union(){
					translate(v=[0,0,length/2]) cube(size = [outerDiameter-1,2,length], center = true);
					//translate(v=[0,0,length/2]) cube(size = [2,outerDiameter-1,length], center = true);
					translate([0,0,0]) cylinder(h=3,r=outerDiameter/2-1.6);
					difference()
					{
						translate([0,0,length-4]) cylinder(h=4,r=outerDiameter/2-1.6);
						translate([0,0,length-6]) cylinder(h=4,r1=outerDiameter/2-1.6,r2=outerDiameter/2-4);
					}
				}
				translate(v=[0,0,-1]) cylinder(h = length+2, r=rodsize/2+0.5, $fn=20);
			}
		}
		//opening cutout
		rotate([0,0,45])
		translate(v=[(outerDiameter/2)+1,(outerDiameter/2)+1,(length)/2]) cube(size = [outerDiameter,outerDiameter,length+2], center = true);
		
		}
	}
}
union(){
translate(v=[(rodsize+1),(rodsize+1),0]) bushing();
translate(v=[-(rodsize+1),(rodsize+1),0]) bushing();
//translate(v=[(rodsize+1),-(rodsize+1),0]) mirror([ 0, 1, 0 ]) bushing();
//translate(v=[-(rodsize+1),-(rodsize+1),0]) mirror([ 0, 1, 0 ]) bushing();
//translate(v=[3*(rodsize+1),(rodsize+1),0]) bushing();
//translate(v=[-3*(rodsize+1),(rodsize+1),0]) bushing();
//translate(v=[3*(rodsize+1),-(rodsize+1),0]) mirror([ 0, 1, 0 ]) bushing();
//translate(v=[-3*(rodsize+1),-(rodsize+1),0]) mirror([ 0, 1, 0 ]) bushing();
//translate(v=[(rodsize+1),3*(rodsize+1),0]) bushing();
//translate(v=[-(rodsize+1),3*(rodsize+1),0]) bushing();
//translate(v=[(rodsize+1),-3*(rodsize+1),0]) mirror([ 0, 1, 0 ]) bushing();
//translate(v=[-(rodsize+1),-3*(rodsize+1),0]) mirror([ 0, 1, 0 ]) bushing();
}
%cube([100,100,0.01],true);

//bushing();
