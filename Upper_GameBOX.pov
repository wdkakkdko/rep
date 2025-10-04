#version 3.7;

#include "colors.inc"
#include "glass.inc"

camera {
    location <2.5, 2.4, -5>
    look_at  <0, 0.9, 0>
    angle 55
}

background { color Gray20 }

light_source { <10, 15, -15> color White*1.2 }
light_source { <0, -0.9, 0> color Pink*1.5 area_light <2, 0, 0>, <0, 0, 2>, 4, 4 adaptive 1 jitter }
light_source { <0, 2.2, 1.5> color Magenta*0.8 fade_distance 0.5 fade_power 2 }


#declare Machine_Width    = 2.0;
#declare Machine_Height   = 2.0;
#declare Machine_Depth    = 2.0;
#declare Pillar_Thickness = 0.05;
#declare Top_Box_Height   = 0.2;
#declare Glass_Thickness  = 0.01;


#declare T_White_Metal = texture {
    pigment { color White }
    finish { specular 0.4 roughness 0.02 reflection { 0.1, 0.2 fresnel } conserve_energy }
}

#declare T_Glass = texture {
    pigment { color rgbt <1, 1, 1, 0.95> }
    finish { ambient 0.01 diffuse 0.05 reflection { 0.05, 1.0 fresnel } specular 0.8 roughness 0.0001 }
}

#declare T_Claw_Black = texture {
    pigment { color Black }
    finish { specular 0.6 roughness 0.01 reflection { 0.2, 0.5 fresnel } }
}

#declare T_Claw_Pink_Ring = texture {
    pigment { color Magenta }
    finish { ambient 0.1 diffuse 0.8 emission 0.7 specular 0.5 }
}



#declare Frame_Pillars = union {
    #declare Pillar = box { <-Pillar_Thickness/2, 0, -Pillar_Thickness/2>, <Pillar_Thickness/2, Machine_Height - Top_Box_Height, Pillar_Thickness/2> }
    object { Pillar translate <-Machine_Width/2, 0, -Machine_Depth/2> }
    object { Pillar translate < Machine_Width/2, 0, -Machine_Depth/2> }
    object { Pillar translate <-Machine_Width/2, 0,  Machine_Depth/2> }
    object { Pillar translate < Machine_Width/2, 0,  Machine_Depth/2> }
}

#declare Top_Box = object {
    box { <-Machine_Width/2, Machine_Height - Top_Box_Height, -Machine_Depth/2>, <Machine_Width/2, Machine_Height, Machine_Depth/2> }
}

#declare Y_Height = Machine_Height - Top_Box_Height;

#declare Glass_Panels = union {
    box { <-Machine_Width/2, 0, -Machine_Depth/2-Glass_Thickness>, <Machine_Width/2, Y_Height, -Machine_Depth/2> }
    box { <-Machine_Width/2-Glass_Thickness, 0, -Machine_Depth/2>, <-Machine_Width/2, Y_Height, Machine_Depth/2> }
    box { <Machine_Width/2, 0, -Machine_Depth/2>, <Machine_Width/2+Glass_Thickness, Y_Height, Machine_Depth/2> }
    box { <-Machine_Width/2, 0, Machine_Depth/2>, <Machine_Width/2, Y_Height, Machine_Depth/2+Glass_Thickness> }
    texture { T_Glass }
    interior { ior 1.5 }
}


#declare Gantry_System = object {
    union {
        box { <-0.1, -0.05, -Machine_Depth/2>, <0.1, 0.05, Machine_Depth/2> }
        box { <-Machine_Width/2, -0.08, -0.1>, <Machine_Width/2, 0.02, 0.1> translate <0, 0, 1.5> }
    }
    translate <0, Machine_Height - Top_Box_Height, 0>
}

#declare Claw_Unit = union {
    #declare Claw_Arm = union {
        cylinder { <0,0,0>, <0,-0.2,0>, 0.04 } sphere { <0,-0.2,0>, 0.04 }
        cylinder { <0,-0.2,0>, <0.2, -0.4, 0>, 0.03 } sphere { <0.2, -0.4, 0>, 0.03 }
        cylinder { <0.2, -0.4, 0>, <0.1, -0.7, 0>, 0.02 }
        texture { T_White_Metal }
    }
    cylinder { <0,0,0>, <0, -0.3, 0>, 0.25 texture { T_Claw_Black } }
    torus { 0.25, 0.05 texture { T_Claw_Pink_Ring } translate <0, -0.05, 0> }
    cylinder {<0,-0.04, -0.01>, <0, -0.04, 0.01>, 0.1 texture { T_Claw_Pink_Ring }}
    cylinder { <0, -0.3, 0>, <0, -0.5, 0>, 0.05 texture { T_Claw_Black } }
    object { Claw_Arm rotate z*30 translate <0, -0.5, 0> rotate y*0 }
    object { Claw_Arm rotate z*30 translate <0, -0.5, 0> rotate y*120 }
    object { Claw_Arm rotate z*30 translate <0, -0.5, 0> rotate y*240 }
}
-
#declare Crane_Game_Upper = union {
    union {
        object { Frame_Pillars }
        object { Top_Box }
        texture { T_White_Metal }
    }
    object { Glass_Panels }
    object { Gantry_System texture { T_White_Metal } }
    object { Claw_Unit translate <0, Machine_Height - Top_Box_Height - 0.02, 1.5> }
}


object {
    Crane_Game_Upper
}