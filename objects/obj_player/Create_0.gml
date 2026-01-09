#region  Variaveis

//movimentação
velh     = 0;
max_velh = 1;
velv     = 0;
max_velv = 3.8;
grav     = .2;
chao     = false;

xscale = image_xscale;
yscale = image_yscale;

estado = noone;


#endregion

#region  Inputs

//variaveis dos comandos
right = 0;
left  = 0;
jump  = 0;

//Setando as teclas
keyboard_set_map(ord("A"),vk_left);
keyboard_set_map(ord("D"),vk_right);

pega_input = function (){
    
    left  = keyboard_check(vk_left);
    right = keyboard_check(vk_right);
    jump  = keyboard_check_pressed(vk_space);
    
};

#endregion



#region Métodos

movimentacao = function () {
      
    y = round(y);
    //aplicando os inputs no velh 
    velh = (right - left) * max_velh;
    
    //aplicando a gravidade
    if !chao 
    { 
        velv += grav;
        
        if velv >= max_velv {
            velv = max_velv;
        }
    }
    else
    {
        velv = 0;
        //pulando
        if (jump) 
        {
            velv = -max_velv;
        }
    };
    
    //movimentação horizontal
    move_and_collide(velh,0,obj_parede,4);
    //movimentação vertical
    move_and_collide(0,velv,obj_parede,4);
    
    
}

ajusta_xscale = function () {
    
    if velh != 0 {
        xscale = sign(velh);
    }
    
}

checa_chao = function ()
{ 
    chao = place_meeting(x,y + 1,obj_parede);  
}

//estados

troca_sprite = function (_sprite) {
    
    if sprite_index != _sprite {
        sprite_index = _sprite;
        image_index = 0;
    }
    
}

estado_parado = function ()
{
    troca_sprite(spr_player_idle)
    
    //sprite_index = spr_player_idle
    if left xor right {
        estado = estado_run;
    }
        
    if jump {
        estado = estado_jump;
    }
}


estado_run = function () 
{ 
    troca_sprite(spr_player_run);
    
    if !left and !right or velh == 0 {
        estado = estado_parado
    }
        
    if jump {
        estado = estado_jump;
    }
    
        
}

estado_jump = function ()
{
    troca_sprite(spr_player_jump);
    
    if chao {
      estado = estado_parado;
    }
}
#endregion

#region debug

/*
roda_debug = function () { 
        
    
    //se o global.debug nao for verdadeiro, ele sai do código
    
    //if !global.debug return;
        
    show_debug_overlay(global.debug);
    dbg_watch(ref_create(id,"velv"),"Velocidade Vertical"); 
    dbg_slider(ref_create(id,"max_velv"),0,10,"Maxima velocidade vertical", .1);
    dbg_slider(ref_create(id,"grav"),0,10,"Gravidade",.1);    

}


//ativando o debug
ativa_debug = function () {
    
    if keyboard_check_pressed(vk_tab)  {
        show_message("DESATIVEI")
        global.debug = !global.debug;
        
        if global.debug {
            //rodando o debug
            roda_debug();
        }
    }
    
}*/


debug_criado = false;

ativa_debug = function () {
    if (keyboard_check_pressed(vk_tab)) {
        global.debug = !global.debug;
    }
}

roda_debug = function () {

    
    // Liga / desliga o overlay
    // Se desligado, reseta o estado e sai
    if (!DEBUG_MODE) {
        debug_criado = false;
        return;
    }

    // Cria os controles UMA VEZ
    if (!debug_criado) {

        dbg_watch(ref_create(id, "velv"), "Velocidade Vertical"); 
        dbg_slider(ref_create(id, "max_velv"), 0, 10, "Máxima velocidade vertical", 0.1);
        dbg_slider(ref_create(id, "grav"), 0, 10, "Gravidade", 0.1);

        debug_criado = true;
    }
};

#endregion

//Definindo o o estado inicial do player
estado = estado_parado;



