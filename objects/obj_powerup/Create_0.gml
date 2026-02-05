alvo = noone;

//rodando eu tiver um alvo
movendo = function () {
    
    if (!alvo) return;
        
    //mexendo a imagem do power up
     x = lerp(x,other.x,0.1);
     y = lerp(y,other.y - sprite_height * 1.7,0.1);    
    
    //other.pega_powerup();
    
}