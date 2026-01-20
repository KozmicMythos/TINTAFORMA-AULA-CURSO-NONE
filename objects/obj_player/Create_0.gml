//iniciando o efeito
inicia_efeito_squash();

#region  Variaveis

//movimentação
velh     = 0;
max_velh = 1;
velv     = 0;
max_velv = 3.8;
grav     = .2;
chao     = false;

//arrumando a direcao
dir = 1;

estado = noone;

lay_col  = layer_tilemap_get_id("tl_level");
colisor      = [lay_col];


#endregion

#region  Inputs

//variaveis dos comandos
right = 0;
left  = 0;
jump  = 0;
tinta = 0;

//Setando as teclas
keyboard_set_map(ord("A"),vk_left);
keyboard_set_map(ord("D"),vk_right);

pega_input = function (){
    
    left  = keyboard_check(vk_left);
    right = keyboard_check(vk_right);
    jump  = keyboard_check_pressed(vk_space);
    tinta = keyboard_check_pressed(ord("E"));
    
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

    
}

//colocando o move and colide 
movimento = function () { 
    //movimentação horizontal
    move_and_collide(velh,0,lay_col,4);
    //movimentação vertical
    move_and_collide(0,velv,lay_col,4); 
}

ajusta_xscale = function () {
    
    if (velh != 0) dir = sign(velh);
    
    
}

checa_chao = function ()
{ 
    chao = place_meeting(x,y + 1,lay_col);  
}

//estados

troca_sprite = function (_sprite) {
     
    if sprite_index != _sprite {
        sprite_index = _sprite;
        image_index  = 0;
    }; 
    
};
//chgecando se acabou a animacao
acabou_animacao = function (_estado) {
    
    if image_index > image_number - 1 {
        estado = _estado;
    };
    
}


estado_parado = function ()
{
    troca_sprite(spr_player_idle);
    movimentacao();
    checa_chao();
    
    //sprite_index = spr_player_idle
    if left xor right {
        estado = estado_run;
    }
        
    if jump {
        estado = estado_jump;
        instance_create_depth(x,y + 4,depth - 1,obj_particula);
        //aplicando o efeito
        efeito_squash(.6,1.3);
    }
    
    //se eu nao estou no chão eu caio
    if !chao {
        estado = estado_jump; 
    }
    
    if tinta {
        estado = estado_entrando_tinta;
    }
    
}


estado_run = function () 
{ 
    troca_sprite(spr_player_run);
    movimentacao();
    checa_chao();
      
    if !left and !right or velh == 0 {
        estado = estado_parado
    }
        
    if jump { 
        estado = estado_jump; 
        instance_create_depth(x,y + 4,depth - 1,obj_particula); 
        
        //aplicando o efeito
        efeito_squash(.6,1.3);
    }; 
        
}


//PULANDO
estado_jump = function ()
{
    checa_chao();
    movimentacao();
    
        //descendo
    if velv > 0 {
        troca_sprite(spr_player_fall)
    }else{
        //subindo
        troca_sprite(spr_player_jump);
    };
    
    //encostando no chão
    if chao {  
        //Volto para o estado parado
        estado = estado_parado;
        //criando as particulas
        instance_create_depth(x,y,depth - 1,obj_particula);
        //aplicando o efeito
        efeito_squash(1.2,0.7);
    }
};

estado_powerup_inicio = function (){ 
    
    troca_sprite(spr_player_powerup_1); 
    
    acabou_animacao(estado_powerup_meio);
    
}

estado_powerup_meio = function () { 
    
    troca_sprite(spr_player_powerup_2);
    
    acabou_animacao(estado_powerup_fim);
    
}

estado_powerup_fim = function () { 
    
    troca_sprite(spr_player_powerup_3);
    
    acabou_animacao(estado_parado);
    
};

estado_entrando_tinta = function (){
    
    //trocando de sprite
    troca_sprite(spr_player_entrando_tinta);
    //Saindo da animação
    acabou_animacao(estado_tinta_loop);
    
    if !instance_exists(obj_particula_tinta){
        instance_create_depth(x,y,depth - 1,obj_particula_tinta);
    }
    
};

//ficando no loop da tinta
estado_tinta_loop = function () {
    
    troca_sprite(spr_player_loop);
    jump = false;
    movimentacao();
    
    //nao deixando o player cair
    var _parar= !place_meeting(x + (velh * 18),y + 1,lay_col);
    
    if _parar 
    {
       velh = 0;
    };
    
    if tinta and velh == 0 {
        estado = estado_saindo_tinta;
    };
    
}

estado_saindo_tinta = function () {
    
    //trocando de sprite
    troca_sprite(spr_player_saindo_tinta);
    //Saindo da animação
    acabou_animacao(estado_parado);
    
    if !instance_exists(obj_particula_sair){
        instance_create_depth(x ,y , depth - 1,obj_particula_sair);
    }
    
};

#endregion

#region debug

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



