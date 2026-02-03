
gpu_set_blendmode(bm_add);
//variando a escala da tocha
var _esq = random_range(0.2,0.21)
//desenhando o brilho
draw_sprite_ext(spr_tocha_brilho,0,x,y,_esq,_esq,0,c_white,.1);
gpu_set_blendmode(bm_normal);