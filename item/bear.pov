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
  pigment { color rgb <0.6, 0.35, 0.2> }
  finish { ambient 0.2 diffuse 0.8 phong 0.1 }
}
#declare DarkTex = texture {
  pigment { color rgb <0.05,0.05,0.05> }
  finish { ambient 0.1 diffuse 0.6 phong 0.7 phong_size 80 }
}

// --- 本体 ---                                  
sphere { <0,6,0>, 6 texture { FurTex } scale<1,1.2,1>}        // 胴体
sphere { <0,17,0>, 6.4 texture { FurTex } }       // 頭
sphere { <-5,22,0>, 2.5 texture { FurTex } scale<1,1,0.8>}    // 右耳
sphere { < 5,22,0>, 2.5 texture { FurTex } scale<1,1,0.8>}    // 左耳
sphere { <-8,3,0>, 2.3 texture { FurTex } scale<1,2,1> rotate<0,0,-18>}      // 右腕
sphere { < 8,3,0>, 2.3 texture { FurTex } scale<1,2,1> rotate<0,0,18>}      // 左腕
sphere { <-4,2,-2>, 3 texture { FurTex } scale<1,1,1.5>}       // 右脚
sphere { < 4,2,-2>, 3 texture { FurTex } scale<1,1,1.5>}       // 左脚 
sphere { <-4,3,-10>, 3 texture { FurTex } scale<1,1.2,0.8>}       // 右足
sphere { < 4,3,-10>, 3 texture { FurTex } scale<1,1.2,0.8>}       // 左足

// --- 顔 ---
sphere { <-2.5,16.7,-5.8>, 0.5 texture { DarkTex } }    // 右目
sphere { < 2.5,16.7,-5.8>, 0.5 texture { DarkTex } }    // 左目
// 鼻
sphere { <0,16,-6.5>, 0.5 texture { DarkTex } }
// 口
sphere { <0,15,-11>, 2.4 pigment{color NewTan} scale<1,1,0.5>}

// --- リボン（簡易版） ---
sphere { <0,9.1,-5.4>, 0.8 pigment{color Red} scale<1,1.3,1>}
sphere { <-1.5,12,-5.2>, 1.4 pigment{color Red} }
sphere { < 1.5,12,-5.2>, 1.4 pigment{color Red} }