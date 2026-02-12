movendo();
//estado();

if alvo == noone {
    
    other.pega_powerup();
    alvo = other.id;
    explosao(); 
    
}
alvo = other;


//ativando a destruição o powerup


//me destruindo
if alvo {
    
    image_alpha -= 0.01;
    //avisando o player que ele pode usar o power up
    with(obj_player) {
        power_up = true;
    }
    
    if image_alpha <= 0 { 
        instance_destroy();
        
    }
}

/*
if !instance_exists(obj_particula_powerup){
    
    efeito = true;
    
}

if efeito {
    
    y -= 0.1;
    image_alpha -= 0.02;
    if image_alpha <= 0 {
        instance_destroy();
    }
    
}

