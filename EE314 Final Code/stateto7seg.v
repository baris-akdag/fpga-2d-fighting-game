module stateto7seg
(
 input[3:0] char_state,
 input[3:0] char2_state,
 input[1:0] cd,
 
 input hitdetect,
 input hitdetect1,

 output[6:0] hex0,
 output[6:0] hex1,
 output[6:0] hex2,
 output[6:0] hex4,
 output[6:0] hex5

);

hexto7seg hexagon
(
.hex(char_state),
.hexn(hex0)
);

hexto7seg isthebestagon
(
.hex(char2_state),
.hexn(hex1)
);


hexto7seg welovehexagons
(
.hex({2'b00, cd}),
.hexn(hex2)
);

hexto7seg hexagons
(
.hex({3'b00, hitdetect}),
.hexn(hex4)
);

hexto7seg xagons
(
.hex({3'b00, hitdetect1}),
.hexn(hex5)
);

endmodule