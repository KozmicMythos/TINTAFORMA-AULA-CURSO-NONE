movendo();
if alvo == noone {
    
    other.pega_powerup();
    alvo = other.id;
    explosao();
    
}
alvo = other;

//me destruindo

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

