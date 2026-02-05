//rodando apenas se tiver um alvo
if (!alvo) exit;
    
//caso tenha um alvo diminui a velocidade
speed -= 0.09;

//se a velocidade chegar a zero, começa o processo para voltar
if speed <= 0 {
    //voltando vai receber verdadeiro
    voltar = true;
};


//Voltando
if voltar {
    
    direction = point_direction(x,y,alvo.x,alvo.y - 12);    
    speed = 2.5;
    if instance_exists(obj_player){
             
        if place_meeting(x,y,obj_player){
            instance_destroy();
        } 
    } 
    
}