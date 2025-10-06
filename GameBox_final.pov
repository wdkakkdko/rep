#version 3.7;
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"

// �J����
camera {
    location <1.6, 120, -200>
    look_at  <0, 100, 0>
    angle 60
}

// ���C�g
light_source { <200, 300, -400> color White }
light_source { <-200, 100, -150> color Gray50 }

// --- A. ��{�}�`��` ---
#declare UnitBox = box { <-0.5, -0.5, -0.5>, <0.5, 0.5, 0.5> }
#declare UnitCylinder = cylinder { <0, -0.5, 0>, <0, 0.5, 0>, 0.5 }

// --- B.➑̂̃e�N�X�`�� ---
#declare Red_Paint_Texture = texture { pigment { color Red } finish { specular 0.6 roughness 0.03 reflection { 0.2 fresnel on } } normal { bumps 0.1 scale 0.005 } }
#declare Gray_Metal_Texture = texture { pigment { color Gray70 } finish { specular 0.8 roughness 0.01 reflection { 0.4 metallic } } }
#declare Dark_Plastic_Texture = texture { pigment { color Gray30 } finish { specular 0.1 roughness 0.2 } }
#declare White_Button_Texture = texture { pigment { color White } finish { specular 0.8 roughness 0.01 } }
#declare Clear_Glass_Texture = texture { pigment { rgbt <1, 1, 1, 0.9> } finish { reflection 0.3 phong 0.8 specular 0.7 } }

// --- C. �A�[���̃e�N�X�`�� ---
#declare T_White_Metal = texture { pigment { color White } finish { specular 0.4 roughness 0.02 reflection { 0.1, 0.2 fresnel } conserve_energy } }
#declare T_Glass = texture { pigment { color rgbt <1, 1, 1, 0.95> } finish { ambient 0.01 diffuse 0.05 reflection { 0.05, 1.0 fresnel } specular 0.8 roughness 0.0001 } }
#declare T_Claw_Black = texture { pigment { color Black } finish { specular 0.6 roughness 0.01 reflection { 0.2, 0.5 fresnel } } }
#declare T_Claw_Pink_Ring = texture { pigment { color Magenta } finish { ambient 0.1 diffuse 0.8 emission 0.7 specular 0.5 } }

// --- D. �A�[���̃I�u�W�F�N�g��` ---
#declare Machine_Width    = 2.0;
#declare Machine_Height   = 2.0;
#declare Machine_Depth    = 2.0;
#declare Pillar_Thickness = 0.05;
#declare Top_Box_Height   = 0.2;
#declare Glass_Thickness  = 0.01;
#declare Y_Height = Machine_Height - Top_Box_Height;
#declare Frame_Pillars = union {
    #declare Pillar = box { <-Pillar_Thickness/2, 0, -Pillar_Thickness/2>, <Pillar_Thickness/2, Y_Height, Pillar_Thickness/2> }
    object { Pillar translate <-Machine_Width/2, 0, -Machine_Depth/2> }
    object { Pillar translate < Machine_Width/2, 0, -Machine_Depth/2> }
    object { Pillar translate <-Machine_Width/2, 0,  Machine_Depth/2> }
    object { Pillar translate < Machine_Width/2, 0,  Machine_Depth/2> }
}
#declare Top_Box = box { <-Machine_Width/2, Y_Height, -Machine_Depth/2>, <Machine_Width/2, Machine_Height, Machine_Depth/2> };
#declare Glass_Panels = union {
    box { <-Machine_Width/2, 0, -Machine_Depth/2-Glass_Thickness>, <Machine_Width/2, Y_Height, -Machine_Depth/2> }
    box { <-Machine_Width/2-Glass_Thickness, 0, -Machine_Depth/2>, <-Machine_Width/2, Y_Height, Machine_Depth/2> }
    box { <Machine_Width/2, 0, -Machine_Depth/2>, <Machine_Width/2+Glass_Thickness, Y_Height, Machine_Depth/2> }
    box { <-Machine_Width/2, 0, Machine_Depth/2>, <Machine_Width/2, Y_Height, Machine_Depth/2+Glass_Thickness> }
    texture { T_Glass }
    interior { ior 1.5 }
}
#declare Gantry_System = union {
    box { <-0.1, -0.05, -Machine_Depth/2>, <0.1, 0.05, Machine_Depth/2> }
    box { <-Machine_Width/2, -0.08, -0.1>, <Machine_Width/2, 0.02, 0.1> }
    translate <0, Y_Height, 0>
}

// ### �A�[���J�A�j���[�V���� ###
#declare Claw_Rot = 30;
#if (clock >= 26 & clock < 36)
  #declare T = (clock - 26) / 10;
  #declare Claw_Rot = 30 - (20 * T);
#elseif (clock >= 36 & clock < 96) // �I���^�C�~���O: 76 -> 96
  #declare Claw_Rot = 10;
#elseif(clock >= 96 & clock < 106) // �J�n/�I��: 76,86 -> 96,106
  #declare T = (clock - 96) / 10;
  #declare Claw_Rot = 10 + (20 * T);
#elseif (clock >= 106) // �J�n�^�C�~���O: 86 -> 106
  #declare Claw_Rot = 30;
#end


#declare Claw_Unit = union {
    #declare Claw_Arm = union {
        cylinder { <0,0,0>, <0,-0.2,0>, 0.04 } sphere { <0,-0.2,0>, 0.04 }
        cylinder { <0,-0.2,0>, <0.2, -0.4, 0>, 0.03 } sphere { <0.2, -0.4, 0>, 0.03 }
        cylinder { <0.2, -0.4, 0>, <0.1, -0.7, 0>, 0.02 }
        texture { T_White_Metal }
    }
    #if(clock<14)
    cylinder {
        <0,0,0>, <0, -0.3, 0>, 0.25 texture { T_Claw_Black }
    }
    #else
    #if(clock>14 & clock<26)
    cylinder{
        <0,(clock-14)*0.025,0>, <0, -0.3-((clock-14)*0.01), 0>, 0.25 texture { T_Claw_Black }
    }
    #else
    #if(clock>26 & clock<36)
    cylinder{
        <0,(clock-14)*0.025,0>, <0, -0.3-((12)*0.01), 0>, 0.25 texture { T_Claw_Black }
    }
    #else
    #if(clock>36 & clock<46)
    cylinder{
        <0,((12*0.025)+(clock-36)*-0.025),0>, <0, (-0.3-(12*0.01)+(clock-36)*0.01), 0>, 0.25 texture { T_Claw_Black }
    }
    #else
    #if(clock>46)
    cylinder {
        <0,0,0>, <0, -0.3, 0>, 0.25 texture { T_Claw_Black }
    }
    #end
    #end
    #end
    #end
    #end

    torus { 0.25, 0.05 texture { T_Claw_Pink_Ring } translate <0, -0.05, 0> }
    cylinder {<0,-0.04, -0.01>, <0, -0.04, 0.01>, 0.1 texture { T_Claw_Pink_Ring }}
    cylinder { <0, -0.3, 0>, <0, -0.5, 0>, 0.05 texture { T_Claw_Black } }

    object { Claw_Arm rotate z*Claw_Rot translate <0, -0.5, 0> rotate y*0 }
    object { Claw_Arm rotate z*Claw_Rot translate <0, -0.5, 0> rotate y*120 }
    object { Claw_Arm rotate z*Claw_Rot translate <0, -0.5, 0> rotate y*240 }
}


// ### �A�[���S�̂̃A�j���[�V���� ###
#declare Crane_Game_Upper = union {
    union {
        object { Frame_Pillars }
        object { Top_Box }
        texture { T_White_Metal }
    }
    object { Glass_Panels }
    object { Gantry_System texture { T_White_Metal } }

    #if (clock < 14)
        object { Claw_Unit translate <clock * -0.05, Y_Height - 0.02, 0> }
    #elseif (clock < 26)
        object { Claw_Unit translate <-0.7, (Y_Height - ((clock-14) * 0.025)), 0> }
    #elseif (clock < 36)
        object { Claw_Unit translate <-0.7, (Y_Height - (12 * 0.025)), 0> }
    #elseif (clock < 46)
        object { Claw_Unit translate <-0.7, (Y_Height - (12*0.025) + ((clock-36)*0.025)), 0> }
    #elseif (clock < 96) // �I���^�C�~���O: 76 -> 96
        #declare Move_Progress = (clock-46) / (96-46); // ���Ԃ�����
        #declare Current_X = -0.7 + (1.325) * Move_Progress; // �ŏI�n�_�܂ł̋����Ōv�Z
        object { Claw_Unit translate <Current_X, (Y_Height - (12*0.025) + (10*0.025)), 0> }
    #else
        object { Claw_Unit translate <0.625, (Y_Height - (12*0.025) + (10*0.025)), 0> } // �ŏI�n�_(37.5/60)�ŐÎ~
    #end
}

// --- E. �i�i�I�u�W�F�N�g��` ---
#declare Bear = union {
  #declare FurTex_Bear = texture { pigment { color rgb <0.6, 0.35, 0.2> } finish { ambient 0.2 diffuse 0.8 phong 0.1 } }
  #declare DarkTex_Bear = texture { pigment { color rgb <0.05,0.05,0.05> } finish { ambient 0.1 diffuse 0.6 phong 0.7 phong_size 80 } }
  sphere { <0,6,0>, 6 texture { FurTex_Bear } scale<1,1.2,1>}
  sphere { <0,17,0>, 6.4 texture { FurTex_Bear } }
  sphere { <-5,22,0>, 2.5 texture { FurTex_Bear } scale<1,1,0.8>}
  sphere { < 5,22,0>, 2.5 texture { FurTex_Bear } scale<1,1,0.8>}
  sphere { <-8,3,0>, 2.3 texture { FurTex_Bear } scale<1,2,1> rotate<0,0,-18>}
  sphere { < 8,3,0>, 2.3 texture { FurTex_Bear } scale<1,2,1> rotate<0,0,18>}
  sphere { <-4,2,-2>, 3 texture { FurTex_Bear } scale<1,1,1.5>}
  sphere { < 4,2,-2>, 3 texture { FurTex_Bear } scale<1,1,1.5>}
  sphere { <-4,3,-10>, 3 texture { FurTex_Bear } scale<1,1.2,0.8>}
  sphere { < 4,3,-10>, 3 texture { FurTex_Bear } scale<1,1.2,0.8>}
  sphere { <-2.5,16.7,-5.8>, 0.5 texture { DarkTex_Bear } }
  sphere { < 2.5,16.7,-5.8>, 0.5 texture { DarkTex_Bear } }
  sphere { <0,16,-6.5>, 0.5 texture { DarkTex_Bear } }
  sphere { <0,15,-11>, 2.4 pigment{color NewTan} scale<1,1,0.5>}
  sphere { <0,9.1,-5.4>, 0.8 pigment{color Red} scale<1,1.3,1>}
  sphere { <-1.5,12,-5.2>, 1.4 pigment{color Red} }
  sphere { < 1.5,12,-5.2>, 1.4 pigment{color Red} }
}
#declare Rabbit = union {
  #declare FurTex_Rabbit = texture { pigment { color rgb <0.95, 0.5, 0.45> } finish { ambient 0.2 diffuse 0.8 phong 0.1 } }
  #declare DarkTex_Rabbit = texture { pigment { color rgb <0.05,0.05,0.05> } finish { ambient 0.1 diffuse 0.6 phong 0.7 phong_size 80 } }
  sphere { <0,6,0>, 6 texture { FurTex_Rabbit } scale<1,1.2,1>}
  sphere { <0,17,0>, 6.4 texture { FurTex_Rabbit } }
  sphere { <-5.5,14,0>, 2.5 texture { FurTex_Rabbit } scale<0.7,1.8,0.8>}
  sphere { < 5.5,14,0>, 2.5 texture { FurTex_Rabbit } scale<0.7,1.8,0.8>}
  sphere { <-8,3,0>, 2.3 texture { FurTex_Rabbit } scale<1,2,1> rotate<0,0,-18>}
  sphere { < 8,3,0>, 2.3 texture { FurTex_Rabbit } scale<1,2,1> rotate<0,0,18>}
  sphere { <-4,2,-2>, 3 texture { FurTex_Rabbit } scale<1,1,1.5>}
  sphere { < 4,2,-2>, 3 texture { FurTex_Rabbit } scale<1,1,1.5>}
  sphere { <-4,3,-10>, 3 texture { FurTex_Rabbit } scale<1,1.2,0.8>}
  sphere { < 4,3,-10>, 3 texture { FurTex_Rabbit } scale<1,1.2,0.8>}
  sphere { <-2.5,16.7,-5.8>, 0.5 texture { DarkTex_Rabbit } }
  sphere { < 2.5,16.7,-5.8>, 0.5 texture { DarkTex_Rabbit } }
  sphere { <0,16,-6.5>, 0.5 texture { DarkTex_Rabbit } }
  sphere { <0,15,-11>, 2.4 pigment{color White} scale<1,1,0.5>}
  sphere { <2.3,17.3,-2.4>, 0.8 pigment{color MediumTurquoise} scale<1,1.3,1> rotate<0,0,15>}
  sphere { <-5,22,-3>, 1.4 pigment{color MediumTurquoise} scale<1,1,0.5>}
  sphere { <-2.5,23,-3>, 1.4 pigment{color MediumTurquoise} scale<1,1,0.5>}
}
#declare Robot = union {
  #declare LightBlueMetal = texture { pigment { color rgb <0.1,0.5,0.9> } finish { phong 0.6 reflection 0.05 } }
  #declare RedPlastic = texture { pigment { color rgb <0.8,0.1,0.1> } finish { phong 0.5 } }
  #declare YellowPlastic = texture { pigment { color rgb <1,0.9,0.2> } finish { phong 0.5 } }
  #declare BluePlastic = texture { pigment { color rgb <0.2,0.5,0.9> } finish { phong 0.5 } }
  #declare GreyPlastic = texture { pigment { color rgb <0.6,0.6,0.65> } finish { phong 0.5 } }
  box { <-7,22,-5>, <7,30,5> texture{LightBlueMetal} }
  sphere { <-7,26,0>,2.5 texture{YellowPlastic} }
  sphere { <7,26,0>,2.5 texture{YellowPlastic} }
  cylinder { <0,29,0>, <0,34,0>, 0.3 texture{GreyPlastic} }
  sphere { <0,34,0>,0.8 texture{YellowPlastic} }
  cylinder { <0,15,0>, <0,27,0>, 1 texture{GreyPlastic} }
  box { <-6,8,-5>, <6,20,5> texture{LightBlueMetal} }
  box { <-4,25.5,-5.2>, <-2,27.5,-5.4> texture{YellowPlastic} }
  box { < 2,25.5,-5.2>, < 4,27.5,-5.4> texture{YellowPlastic} }
  box { <-3,23.5,-5.2>, <3,24.5,-5.4> texture{RedPlastic} }
  box { <-4,15,-5.2>, <-2,17,-5.4> texture{RedPlastic} }
  box { <-1,15,-5.2>, <1,17,-5.4> texture{YellowPlastic} }
  box { <2,15,-5.2>, <4,17,-5.4> texture{BluePlastic} }
  cylinder { <-7,19,0>, <-9,11,0>, 1 texture{GreyPlastic} rotate<0,0,-3>}
  cylinder { < 7,19,0>, < 9,11,0>, 1 texture{GreyPlastic} rotate<0,0,3>}
  sphere { <-8.5,11,0> 1.7 texture{RedPlastic} }
  sphere { <8.5,11,0>,1.7 texture{RedPlastic} }
  cylinder { <-3.5,1.5,0>, <-3.5,8,0>, 1.2 texture{GreyPlastic} }
  cylinder { < 3.5,1.5,0>, < 3.5,8,0>, 1.2 texture{GreyPlastic} }
  box { <-5.5,0,-3>, <-1.5,1.5,3> texture{YellowPlastic} }
  box { < 1.5,0,-3>, < 5.5,1.5,3> texture{YellowPlastic} }
}


// --- �I�u�W�F�N�g�̔z�u ---
// --- 1. �N���[���Q�[��➑� ---
union{
    union {
        difference {
            object { UnitBox scale <120, 75, 70> translate <0, 42.5, 0> }
            object { UnitBox scale <35, 76, 39> translate <37.5, 43.5, -14.5> }
            object { UnitBox scale <35, 25, 4> translate <37.5, 17.5, -34> }
            texture { Red_Paint_Texture }
        }
        union {
            object { UnitBox scale <70, 10, 15> translate <0, 65, -37.5> }
            object { UnitBox scale <70, 10, 5> translate <0, 55, -42.5> }
            object { UnitCylinder scale<6, 1, 6> translate<-20, 70.5, -37.5> texture{White_Button_Texture}}
            object { UnitCylinder scale<6, 1, 6> translate<0,   70.5, -37.5> texture{White_Button_Texture}}
            object { UnitCylinder scale<6, 1, 6> translate<20,  70.5, -37.5> texture{White_Button_Texture}}
            texture { Gray_Metal_Texture }
        }
        union {
            object { UnitCylinder scale <10, 5, 10> translate <-55, 2.5, -25> }
            object { UnitCylinder scale <10, 5, 10> translate <-55, 2.5,  25> }
            object { UnitCylinder scale <10, 5, 10> translate < 55, 2.5, -25> }
            object { UnitCylinder scale <10, 5, 10> translate < 55, 2.5,  25> }
            texture { Dark_Plastic_Texture }
        }
        union {
            object { UnitBox scale <0.2, 20, 34> translate <20.5, 80, -15> }
            object { UnitBox scale <0.2, 20, 34> rotate <0, 90, 0> translate <37.5, 80, 0> }
            texture { Clear_Glass_Texture }
        }
    }
    object {
        Crane_Game_Upper
        scale <60, 50, 35>
        translate <0, 80, 0>
    }
}


// --- 2. �i�i�̔z�u ---
union {
    // �N�}�̔z�u
    object {
        Bear
        scale 0.8
        rotate <0, -20, 0>
        translate <-25, 80, 10>
    }

    // �E�T�M�̔z�u
    object {
        Rabbit
        scale 0.7
        rotate <0, 15, 0>
        translate <0, 80, 20>
    }

    // ### ���{�b�g�̃A�j���[�V���� ###
    #if(clock < 36)
        // �͂ޑO�F���̈ʒu�ɕ\��
        object {
            Robot
            scale 0.9
            rotate <0, 45, 0>
            translate <-40, 80, -10>
        }
    #else
        // �͂񂾌�F�A�[���̓����ɍ��킹�ă��{�b�g��������
        #declare Claw_Base_X = -42;
        #declare Claw_Base_Z = 0;
        #declare Hold_Y = 80 + (10 * 0.025) * 50;
        #declare Hole_X = 37.5;

        object {
            Robot
            scale 0.9
            rotate <0, 45, 0>

            #if (clock < 46)
                // 1. �㏸
                #declare Lift_Y = 80 + ((clock-36) * 0.025) * 50;
                translate <Claw_Base_X, Lift_Y, Claw_Base_Z>

            #elseif (clock < 90) // �I���^�C�~���O: 70 -> 90
                // 2. ���̏�܂ŉ��ړ�
                #declare Move_Progress = (clock - 46) / (90 - 46); // ����: 24 -> 44
                #declare Current_X = Claw_Base_X + (Hole_X - Claw_Base_X) * Move_Progress;
                translate <Current_X, Hold_Y, Claw_Base_Z>

            #elseif (clock < 100) // �J�n/�I��: 70,80 -> 90,100
                // 3. ���̏�ŏ����ҋ@
                translate <Hole_X, Hold_Y, Claw_Base_Z>

            #else
                // 4. ����
                #declare Drop_Start_Time = 100; // �J�n�^�C�~���O: 80 -> 100
                #declare Drop_Speed = 4;
                #declare Time_Since_Drop = clock - Drop_Start_Time;
                translate <Hole_X, Hold_Y - Time_Since_Drop * Drop_Speed, Claw_Base_Z>
            #end
        }
    #end
}


// ���Ƌ�
plane{ y, 0 pigment{checker color White color Gray80}}
sky_sphere{ pigment{ gradient y color_map{[0 color SkyBlue][1 color White]} } }