include <coupling.scad>
n=2;
m=1;
for(i=[0:n-1])
{
	for(j=[0:m-1])
	{
		translate([i*20,j*25,0]) coupling();
	}
}