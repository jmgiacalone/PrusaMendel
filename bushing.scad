// PRUSA Mendel  
// Bushings
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

/**
 * @name Bushing
 * @category Printed
 * @link bushing
 */ 

rodsize = bushing_rodsize+0.1;
outerDiameter = bushing_outerDiameter;
lenght = bushing_lenght;
type = bushing_type;


module bushing(stiff, lenght=11){
	difference(){
		union(){
			translate(v=[-7,-8,0])cube(size = [14,8,lenght]);
			cylinder(h = lenght, r=7);
		}
	//cutout inside
	//Opening
	rotate(a=[0,0,45]) translate(v=[1,1,-1]) cube(size = [16,16,lenght+2]);
	//Cutouts to make it more bendy
	if(stiff){
		translate(v=[-4.8,-6,-1]) cube(size = [0.8,6,lenght+2]);
		translate(v=[4,-6,-1]) cube(size = [0.8,6,lenght+2]);
	}else{
		translate(v=[-4.8,-8,-1]) cube(size = [0.8,8,lenght+2]);
		translate(v=[4,-8,-1]) cube(size = [0.8,8,lenght+2]);
	}
	translate(v=[0,5,(lenght+2)/2]) cube(size = [7,8,lenght+2], center=true);
	translate(v=[0,0,-1]) cylinder(h = lenght+2, r=(rodsize+2)/2);
	}
}
module do_bushing(base_depth){
translate([0,0,8+base_depth]) rotate([90,0,0])
difference(){
	union(){
		bushing(false, 11);
		translate(v=[-7,-8-base_depth,0])cube(size = [14,base_depth,15]);
		translate(v=[-7,-8-base_depth,13])cube(size = [14,base_depth+3,2]);
	}
	translate([0,-6-base_depth,5.5]) rotate([90,0,0]) cylinder(h=base_depth+2,r=2.7/2,center=true, $fn=12);
}
}

do_bushing(4);