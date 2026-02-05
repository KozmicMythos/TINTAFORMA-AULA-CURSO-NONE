
alvo = noone;
//fazendo um efeito no power_up
efeito = false;
//rodando eu tiver um alvo
movendo = function () {
    
    if (!alvo) return;
        
    //mexendo a imagem do power up
     x = lerp(x,other.x,0.1);
     y = lerp(y,other.y - sprite_height * 1.7,0.1);    
    
    //other.pega_powerup();
    
}

explosao = function () {
    
    repeat (120) 
    { 
        var part = instance_create_layer(x,y,"efeitos",obj_particula_powerup);
        part.speed = random_range(3,5);
        part.direction = random_range(0,359);
        //falando pra particula que o player é o alvo
        
        part.alvo = alvo;
        
    }
    
}