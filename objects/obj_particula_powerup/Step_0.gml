//rodando apenas se tiver um alvo
if (!alvo) exit;

//Alternando o alpha com base na velocidade
image_alpha  = speed / 8;    

image_xscale = lerp(image_xscale,speed * 2,0.2);
image_angle  = direction;


if voltar == false {
    
    //caso tenha um alvo diminui a velocidade
    speed -= 0.09;    
    
    //se a velocidade chegar a zero, começa o processo para voltar
    if speed <= 0 {
        //voltando vai receber verdadeiro
        voltar = true;
    };

}else{ 
    //Agora o voltar é verdadeiro
    direction = point_direction(x,y,alvo.x,alvo.y - 12);    
    speed += 0.1; 
    
    var _player = instance_place(x,y,obj_player);
    
    if instance_exists(obj_player){ 
        if _player { 
            
            with(_player){
                var _xscale = random_range(-0.1,0.3);
                var _yscale = random_range(-0.1,0.3);
                efeito_squash(1 + _xscale,1 + _yscale);
            }
            screenshake(2)
            instance_destroy();  
        }; 
    };
}

