use <wade.scad>
use <wadebits.scad>

module SmallGear(x,y,z){
	translate ([x,y,z]) WadesS();
}
module LargeGear(x,y,z){
	translate ([x,y,z]) WadesL();
}
module IdlerBlock(x,y,z){
	translate ([x,y,z]) wadeidler();
}
module M8Block(x,y,z){
	//translate ([x,y,z]) import_stl("M8_Extruder_Block_3.stl", convexity=3);
	translate ([x,y,z]) rotate([0,0,0]) wadeblock(false);
}


SmallGear(20,32,0);
LargeGear(45,85,0);
IdlerBlock(92,30,0);
M8Block(-10,0,0);
