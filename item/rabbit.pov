#include"colors.inc"
#include"shapes.inc"
#include"metals.inc"
#include"textures.inc"

camera {
  location <0, 20, -60>
  look_at  <0, 10, 0>
}

background{color White}

light_source { < -50, 80, -50 > color White }
light_source { < 50, 40, -30 > color White }

#declare FurTex = texture {
  pigment { color rgb <0.95, 0.5, 0.45> }
  finish { ambient 0.2 diffuse 0.8 phong 0.1 }
}
#declare DarkTex = texture {
  pigment { color rgb <0.05,0.05,0.05> }
  finish { ambient 0.1 diffuse 0.6 phong 0.7 phong_size 80 }
}

// --- �{�� ---                                  
sphere { <0,6,0>, 6 texture { FurTex } scale<1,1.2,1>}        // ����
sphere { <0,17,0>, 6.4 texture { FurTex } }       // ��
sphere { <-5.5,14,0>, 2.5 texture { FurTex } scale<0.7,1.8,0.8>}    // �E��
sphere { < 5.5,14,0>, 2.5 texture { FurTex } scale<0.7,1.8,0.8>}    // ����
sphere { <-8,3,0>, 2.3 texture { FurTex } scale<1,2,1> rotate<0,0,-18>}      // �E�r
sphere { < 8,3,0>, 2.3 texture { FurTex } scale<1,2,1> rotate<0,0,18>}      // ���r
sphere { <-4,2,-2>, 3 texture { FurTex } scale<1,1,1.5>}       // �E�r
sphere { < 4,2,-2>, 3 texture { FurTex } scale<1,1,1.5>}       // ���r 
sphere { <-4,3,-10>, 3 texture { FurTex } scale<1,1.2,0.8>}       // �E��
sphere { < 4,3,-10>, 3 texture { FurTex } scale<1,1.2,0.8>}       // ����

// --- �� ---
sphere { <-2.5,16.7,-5.8>, 0.5 texture { DarkTex } }    // �E��
sphere { < 2.5,16.7,-5.8>, 0.5 texture { DarkTex } }    // ����
// �@
sphere { <0,16,-6.5>, 0.5 texture { DarkTex } }
// ��
sphere { <0,15,-11>, 2.4 pigment{color White} scale<1,1,0.5>}

// --- ���{���i�ȈՔŁj ---
sphere { <2.3,17.3,-2.4>, 0.8 pigment{color MediumTurquoise} scale<1,1.3,1> rotate<0,0,15>}
sphere { <-5,22,-3>, 1.4 pigment{color MediumTurquoise} scale<1,1,0.5>}
sphere { <-2.5,23,-3>, 1.4 pigment{color MediumTurquoise} scale<1,1,0.5>}