if place_meeting(x - 1,y,obj_player) or place_meeting(x+1,y,obj_player){
    if global.chaves > 0 {
        instance_destroy();
    }else{
        show_debug_message("Tá faltando chave!")
    }
}