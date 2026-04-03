//Hyrodium's POV-Ray format
//20151221

//Bezier surface
//Axis inc
//Conplex func

#version 3.7;
global_settings{assumed_gamma 1.0}

#declare Step=1/pow(2,5);
#declare NDStep=1/512;
#include "Hy_constants.inc"
#include "Hy_functions.inc"
#include "Hy_colors.inc"
#include "Hy_objects.inc"

#include "Hy_clock.inc"

#declare AspectRatio=1;
#declare Lng=30;
#declare Lat=30;
#declare Pers=0.01;
#declare Zoom=1.0;
#declare LookAt=<0,0,0>;
#include "Hy_camera.inc"

//Coordinate Axis
#if(0)
	#declare r_axis=0.01;
	#declare I=1.2;
	#declare fontsize=0.5;
	#declare axis_color=Black;
	//Axis
	#declare x_min=-I;
	#declare y_min=-I;
	#declare z_min=-I;
	#declare x_max=I;
	#declare y_max=I;
	#declare z_max=I;
	object{Arrow(<x_min,0,0>,<x_max,0,0>,r_axis)pigment{axis_color}}
	object{Arrow(<0,y_min,0>,<0,y_max,0>,r_axis)pigment{axis_color}}
	object{Arrow(<0,0,z_min>,<0,0,z_max>,r_axis)pigment{axis_color}}
	//Coordinate Label
	#if(1)
		//x
		object{Textit("x",fontsize,<-0.6,-0.8,0>,1)translate<x_max,0,0>}
		//y
		object{Textit("y",fontsize,<0.2,-0.3,0>,1)translate<0,y_max,0>}
		//z
		object{Textit("z",fontsize,<-0.2,0.2,0>,1)translate<0,0,z_max>}
		//Re
		//object{Textrm("Re",fontsize,0,<-0.6,0.1,0>,1)translate<x_max,0,0>}
		//Im
		//object{Textrm("Im",fontsize,0,<0.1,-0.4,0>,1)translate<0,y_max,0>}
		//O
		//object{Textrm("O",fontsize,<-0.75,-0.8,0>,1)}
	#end
#end

//Unit Sphere
//object{sphere{0,1}pigment{rgbft<0.5,0.5,0.5,0,0.7>}}

//Unit Circle
#if(0)
	//x
    object{Torus(<0,0,0>,<1,0,0>,1,r_axis)pigment{Black}}
    //y
    object{Torus(<0,0,0>,<0,1,0>,1,r_axis)pigment{Black}}
	//z
	object{Torus(<0,0,0>,<0,0,1>,1,r_axis)pigment{Black}}
#end

//Rotate Arrows around Axises
#declare i=0;
#while(i<0)
    object{ArcArrow3((Sym3d(1.5*Exp(<0,tau/6>)/3+<0,0,I*0.75>,i)),(Sym3d(1.5*Exp(<0,tau/2>)/3+<0,0,I*0.75>,i)),(Sym3d(1.5*Exp(<0,tau/12>)/3+<0,0,I*0.75>,i)),0.03)}
    #declare i=i+1;
#end

///////////////////////////////////////////////////////////////
#debug "\nHeader Completed\n\n"
///////////////////////////////////////////////////////////////

#debug concat(str(123,0,0),"\n")

#declare p_keys = array[5] {0.0001, 1/(1+phi), 1/2, 1-1/(1+phi), 0.9999};
#declare p_idx = min(floor(Time*4), 3);
#declare p_frac = (1 - cos(pi*(Time*4 - p_idx))) / 2;
#declare p = p_keys[p_idx]*(1-p_frac) + p_keys[p_idx+1]*p_frac;
#declare r0=0.01;
#declare r1=0.012;
#declare r2=0.012;

#declare c=pow(8*Mod(Time,1/4)-1,4);
#declare dt=0.05;

#declare col0=rgb<0.5,0.5,0.5>;
#declare col2=rgb<0.1,0.1,0.1>;
#declare col1=rgbft<c,0,0,0.2,0.3>;
#declare col3=rgbft<1,0,0,0.2,0.3>;

#declare i=0;
#while(i<3)
	#declare j=-1;
	#while(j<2)
		#declare k=-1;
		#while(k<2)
			object{cylinder{Sym3d(<j,0,0>,i),Sym3d(<0,k,0>,i),r0}pigment{col2}}
			object{sphere{Sym3d(<j*p,k*(1-p),0>,i),r2}pigment{col0}}
			#declare k=k+2;
		#end
		#if(Time<0.5-dt)
			object{Cylinder(Sym3d(<p,j*(1-p),0>,i),Sym3d(<-p,j*(1-p),0>,i),r1) pigment{col0}}
			object{triangle{Sym3d(<p,j*(1-p),0>,i),Sym3d(<-p,j*(1-p),0>,i),Sym3d(<j*p,p-1,0>,i+1)} pigment{col1}}
			object{triangle{Sym3d(<p,j*(1-p),0>,i),Sym3d(<-p,j*(1-p),0>,i),Sym3d(<j*p,1-p,0>,i+1)} pigment{col1}}
		#end
		#if(Time>0.5+dt)
			object{Cylinder(Sym3d(<j*p,1-p,0>,i),Sym3d(<j*p,p-1,0>,i),r1) pigment{col0}}
			object{triangle{Sym3d(<j*p,1-p,0>,i),Sym3d(<j*p,p-1,0>,i),Sym3d(<p,j*(1-p),0>,i+2)} pigment{col1}}
			object{triangle{Sym3d(<j*p,1-p,0>,i),Sym3d(<j*p,p-1,0>,i),Sym3d(<-p,j*(1-p),0>,i+2)} pigment{col1}}
		#end
		#if(Time<=0.5+dt&Time>=0.5-dt)
			object{polygon{4,Sym3d(<1/2,0,j/2>,i),Sym3d(<0,1/2,j/2>,i),Sym3d(<-1/2,0,j/2>,i),Sym3d(<0,-1/2,j/2>,i)}pigment{col1}}
		#end
		#declare j=j+2;
	#end
	#declare i=i+1;
#end

#declare i=-1;
#while(i<2)
	#declare j=-1;
	#while(j<2)
		#declare k=-1;
		#while(k<2)
			object{triangle{<i,j,k>*<p,(1-p),0>,<i,j,k>*<0,p,(1-p)>,<i,j,k>*<(1-p),0,p>}pigment{col3}}
			#declare l=0;
			#while(l<3)
				object{cylinder{Sym3d(<i,j,k>*<p,(1-p),0>,l),Sym3d(<i,j,k>*<0,p,(1-p)>,l),r1}pigment{col0}}
				#declare l=l+1;
			#end
			#declare k=k+2;
		#end
		#declare j=j+2;
	#end
	#declare i=i+2;
#end



