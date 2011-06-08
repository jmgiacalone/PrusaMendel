include <configuration.scad>

variant=0;
type=4;

use <bar-clamp.scad>
use <belt-clamp.scad>
use <coupling.scad>
use <frame-vertex-open.scad>
use <pulley.scad>
use <rod-clamp.scad>
use <x-end.scad>
use <bushing.scad>
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
for(i=[0:7]){
translate([88,i*12,5]) rotate([0,90,90]) rodclamp();
translate([-12,i*12,5]) rotate([0,90,90]) rodclamp();
}
translate([10,95,0]) rotate([0,0,0]) beltclamp();
translate([40,95,0]) rotate([0,0,0]) beltclamp();
translate([30,28,0]) rotate([0,0,0]) beltclamp();
translate([30,40,0]) rotate([0,0,0]) beltclamp();
//translate([101,47,30]) rotate([0,90,0]) zmotormount();
//translate([83,47,30]) rotate([0,90,180]) zmotormount();
//translate([90,5,0]) rotate([0,0,90]) coupling();
//translate([90,5,31.6]) rotate([0,0,90]) coupling();
//for(i=[0:3])
//{
//	translate([100,96,i*12.6]) rotate([0,0,135]) bushing();
//}
//translate([43,40,0]) rotate([0,0,-33]) pulley();
//translate([80,102,0]) rotate([0,0,-25]) pulley();
}
}

module upplate2(){
translate([0,0,0]) rotate([0,0,0]) union(){
	translate([56,68,0]) rotate([0,0,90]) xendmotor();
	translate([6,77,0]) rotate([0,0,-90]) xendidler();

//	translate([90,8,0]) rotate([0,0,108]) vertex(true);
//	translate([41,20,0]) mirror([0,1,0]) for(i=[0,1,2])
//	{
//		translate([-2,-45,i*12]) rotate([0,0,90])mirror()  endstop();
//	}
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
		translate([67+j*20,62+k*30,i*18]) rotate([0,0,90]) barclamp();
	}
}
}
		translate([-5,10,0]) rotate([0,0,-95]) mirror() vertex(false);
		translate([66,87,0]) rotate([0,0,100]) mirror() vertex(false);
		translate([-40,60,0]) rotate([0,0,-30]) vertex(true);
	}
}

platenum=2;
%translate([0,0,0]) color([1,0,0]) cube(size=[140,140,0.01],center=true);
if(platenum==1)
	translate([-43,-49,0]) upplate1();
if(platenum==2)
	translate([-24,-79,0]) upplate2();
if(platenum==3)
	translate([-44,-49,0]) upplate3();
if(platenum==4)
	translate([-30,-60,0]) upplate4();
