include <configuration.scad>

variant=0;
type=4;

use <bar-clamp.scad>
use <belt-clamp.scad>
use <coupling.scad>
use <frame-vertex-open.scad>
use <pulley.scad>
use <rod-clamp.scad>
use <x-carriage.scad>
use <x-end-idler.scad>
use <x-end-motor.scad>
use <ybrac-t.scad>
use <z-motor-mount.scad>
use <endstop-holder.scad>
use <ptfe-bushing.scad>


module grid(x,y){
union(){
for(i = [0:x]){
	translate([2*i,0,0.5]) cube([0.75,y,1],center=true);
	translate([-2*i,0,0.5]) cube([0.75,y,1],center=true);
	translate([0,3.5*i,1.5]) cube([y,0.75,1],center=true);
	translate([0,-3.5*i,1.5]) cube([y,0.75,1],center=true);
}
}
}
module interface(x){
translate([30,25,0])union(){
translate([-30,-25,2]) vertex(x);
intersection(){
translate([-30,-25,0]) vertex(x);
grid(16,100);
}
}
}


module upplate1(){
translate([0,0,0]) rotate([0,0,0]) union(){
translate([38,38,0]) rotate([0,0,90]) xcarriage();
translate([40,78,0]) rotate([0,0,90]) beltclamp();
translate([40,78,6]) rotate([0,0,90]) beltclamp();
translate([40,78,12]) rotate([0,0,90]) beltclamp();
translate([40,78,18]) rotate([0,0,90]) beltclamp();
translate([105,47,30]) rotate([0,90,180]) zmotormount();
translate([85,52,30]) rotate([0,90,180]) zmotormount();
translate([90,5,0]) rotate([0,0,90]) coupling();
translate([90,5,31.6]) rotate([0,0,90]) coupling();
//for(i=[0:3])
//{
//	translate([100,96,i*12.6]) rotate([0,0,135]) bushing();
//}
translate([43,40,0]) rotate([0,0,-33]) pulley();
translate([80,102,0]) rotate([0,0,-25]) pulley();
}
}

module upplate2(){
translate([0,0,0]) rotate([0,0,0]) union(){
	difference()
	{
		translate([48,78,0]) rotate([0,0,90]) xendmotor();
		translate([86,78,0]) cylinder(h=100,r=m8_diameter/2);
	}
	difference()
	{
		translate([10,65,0]) rotate([0,0,180]) xendidler();
		translate([10,85,0]) cylinder(h=100,r=m8_diameter/2);
	}
translate([-10,15,0]) rotate([0,0,300]) vertex(true);
mirror([0,1,0]) for(i=[0,1,2])
{
	translate([-2,-45,i*12]) rotate([0,0,0])mirror()  endstop();
}
//for(k=[0,1,2,3])
//{
//	translate([-15,15,k*12.6]) rotate([0,0,90])  bushing();
//}
//for(k=[0,1,2,3])
//{
//	translate([-15,105,k*12.6]) rotate([0,0,90])  bushing();
//}
}
}

module upplate3(){
translate([0,0,0]) rotate([0,0,0]) union(){
translate([120,0,0]) rotate([0,0,90]) vertex(true);
mirror([0,1,0]) translate([120,-120,0]) rotate([0,0,90]) vertex(true);
translate([110,55,0]) rotate([0,0,95]) ybract();
}
}
module upplate4(){
	translate([0,0,0]) rotate([0,0,0]) union()
	{
for(k=[0,1])
{
for(j=[0,1])
{
	for(i=[0,1])
	{
		translate([70+j*20,65+k*30,i*18]) rotate([0,0,90]) barclamp();
	}
}
}
translate([40,107,5]) rotate([0,90,0]) rodclamp();
translate([40,77,5]) rotate([0,90,0]) rodclamp();
	}
}

platenum=4;
%cube(size=[85,98,0.01],center=true);
if(platenum==1)
	translate([-43,-49,0]) upplate1();
if(platenum==2)
	translate([-44,-49,0]) upplate2();
if(platenum==3)
	translate([-44,-49,0]) upplate3();
if(platenum==4)
	translate([-44,-49,0]) upplate4();
