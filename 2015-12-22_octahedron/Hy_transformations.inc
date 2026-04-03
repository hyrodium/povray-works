//Hyrodium's POV-Ray format
//Hy_transformations.inc

//#include "Hy_transformations.inc"
#macro Matrix(e1,e2,e3,p0)
	matrix<
	vdot(e1,x), vdot(e1,y), vdot(e1,z),
	vdot(e2,x), vdot(e2,y), vdot(e2,z),
	vdot(e3,x), vdot(e3,y), vdot(e3,z),
	vdot(p0,x), vdot(p0,y), vdot(p0,z)>
#end

#macro RotateMatrix(n,w,p0)
	#local ex=vdot(vnormalize(n),x);
	#local ey=vdot(vnormalize(n),y);
	#local ez=vdot(vnormalize(n),z);
	translate -p0
	matrix<
	ex*ex*(1-cos(w))+cos(w),	ey*ex*(1-cos(w))+ez*sin(w),	ez*ex*(1-cos(w))-ey*sin(w),
	ex*ey*(1-cos(w))-ez*sin(w),	ey*ey*(1-cos(w))+cos(w),	ez*ey*(1-cos(w))+ex*sin(w),
	ex*ez*(1-cos(w))+ey*sin(w),	ey*ez*(1-cos(w))-ex*sin(w),	ez*ez*(1-cos(w))+cos(w),
	vdot(p0,x), vdot(p0,y), vdot(p0,z)>
#end

#macro RotateMatrix2(n,w,p0)
	translate -p0
	Matrix(vaxis_rotate(x,n,degrees(w)),vaxis_rotate(y,n,degrees(w)),vaxis_rotate(z,n,degrees(w)),p0)
#end

#macro Front(level)
	#if(Pers)
		translate -Loc
		scale 1/level
		translate Loc
	#else
		translate Z*level
	#end
#end
