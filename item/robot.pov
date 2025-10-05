#include"colors.inc"
#include"shapes.inc"
#include"metals.inc"
#include"textures.inc"

camera {
  location <0, 15, -60>
  look_at  <0, 15, 0>
}
light_source { <50, 50, -50> color rgb <1,1,1> }
background { color rgb <1,1,1> }

// çﬁéøíËã`
#declare LightBlueMetal = texture {
  pigment { color rgb <0.1,0.5,0.9> }
  finish { phong 0.6 reflection 0.05 }
}

#declare RedPlastic = texture {
  pigment { color rgb <0.8,0.1,0.1> }
  finish { phong 0.5 }
}

#declare YellowPlastic = texture {
  pigment { color rgb <1,0.9,0.2> }
  finish { phong 0.5 }
}

#declare BluePlastic = texture {
  pigment { color rgb <0.2,0.5,0.9> }
  finish { phong 0.5 }
}

#declare GreyPlastic = texture {
  pigment { color rgb <0.6,0.6,0.65> }
  finish { phong 0.5 }
}

// ì™
box { <-7,22,-5>, <7,30,5> texture{LightBlueMetal} }
sphere { <-7,26,0>,2.5 texture{YellowPlastic} }
sphere { <7,26,0>,2.5 texture{YellowPlastic} }
cylinder { <0,29,0>, <0,34,0>, 0.3 texture{GreyPlastic} }
sphere { <0,34,0>,0.8 texture{YellowPlastic} }

// éÒ
cylinder { <0,15,0>, <0,27,0>, 1 texture{GreyPlastic} }

// ì∑ëÃ
box { <-6,8,-5>, <6,20,5> texture{LightBlueMetal} }

// ñ⁄
box { <-4,25.5,-5.2>, <-2,27.5,-5.4> texture{YellowPlastic} }
box { < 2,25.5,-5.2>, < 4,27.5,-5.4> texture{YellowPlastic} }

// å˚
box { <-3,23.5,-5.2>, <3,24.5,-5.4> texture{RedPlastic} }

// É{É^Éì
box { <-4,15,-5.2>, <-2,17,-5.4> texture{RedPlastic} }
box { <-1,15,-5.2>, <1,17,-5.4> texture{YellowPlastic} }
box { <2,15,-5.2>, <4,17,-5.4> texture{BluePlastic} }

// òr
cylinder { <-7,19,0>, <-9,11,0>, 1 texture{GreyPlastic} rotate<0,0,-3>}
cylinder { < 7,19,0>, < 9,11,0>, 1 texture{GreyPlastic} rotate<0,0,3>}

// éË
sphere { <-8.5,11,0> 1.7 texture{RedPlastic} }
sphere { <8.5,11,0>,1.7 texture{RedPlastic} }

// ãr
cylinder { <-3.5,1.5,0>, <-3.5,8,0>, 1.2 texture{GreyPlastic} }
cylinder { < 3.5,1.5,0>, < 3.5,8,0>, 1.2 texture{GreyPlastic} }

// ë´
box { <-5.5,0,-3>, <-1.5,1.5,3> texture{YellowPlastic} }
box { < 1.5,0,-3>, < 5.5,1.5,3> texture{YellowPlastic} }