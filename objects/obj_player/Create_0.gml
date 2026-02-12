//iniciando o efeito
inicia_efeito_squash();

#region  Variaveis

//movimentação
velh       = 0;
max_velh   = 1;
velv       = 0;
max_velv   = 3.8;
grav       = .2;
chao       = false;
chao_tinta = false;

//Checando quantas chaves o player tem
global.chaves = 0;
//mudando a mascara de colisao
mask_index = spr_player_idle;
//arrumando a direcao
dir = 1;

estado = noone;

lay_col  = layer_tilemap_get_id("tl_level");
tile_set_tinta = layer_tilemap_get_id("tl_tinta");
colisor      = [lay_col,obj_parede];

//avisando o player que ele pode usar o powerup
power_up = false;


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
    
    
    //aplicando os inputs no velh 
    velh = (right - left) * max_velh;
    
    //aplicando a gravidade
    if !chao 
    { 
        velv += grav;  
    }
    else
    {
        y = round(y);
        velv = 0;
        //pulando
        if (jump) 
        {
            velv = -max_velv;
            colisor[2] = noone; 
        }
    };

    //limitando a velocidade vertical
    velv = clamp(velv,-max_velv,max_velv);
    
}

movimentacao_vertical = function () {
    
    //aplicando a gravidade
    if !chao 
    { 
        velv += grav;  
    }
    else
    {
        y = round(y);
        velv = 0;
        //pulando
        if (jump) 
        {
            velv = -max_velv;
            colisor[2] = noone; 
        }
    };

    //limitando a velocidade vertical
    velv = clamp(velv,-max_velv,max_velv);
    
}

//colocando o move and colide 
movimento = function () { 
    //movimentação horizontal
    move_and_collide(velh,0,colisor,4);
    //movimentação vertical
    move_and_collide(0,velv,colisor,4); 
}

ajusta_xscale = function () {
    
    if (velh != 0) dir = sign(velh);
    
    
}

checa_chao = function ()
{ 
    chao = place_meeting(x,y + 1,colisor);  
    
    //Checando se tem tinta
    chao_tinta = place_meeting(x,y+1,tile_set_tinta);
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
    
};

//Pegando o power up 
pega_powerup = function () {
    
    estado = estado_powerup_inicio;
    
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
    
     
    if tinta and power_up and chao_tinta {
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
        
    //SE eu não estou no chão, então estou pulando
    if !chao {
        estado = estado_jump;
    }
}


//PULANDO
estado_jump = function ()
{
    checa_chao();
    movimentacao();
    
    
    
        //descendo
    if velv > 0 {
        troca_sprite(spr_player_fall);
        if !place_meeting(x,y,obj_parede_one_way) colisor[2] = obj_parede_one_way;
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
    //fazendo o player encostar a cabeça no teto e não deslizar
    if place_meeting(x,y-1,colisor){
        velv += 0.1;
    }
};

estado_powerup_inicio = function (){ 
    
    troca_sprite(spr_player_powerup_1); 
    
    acabou_animacao(estado_powerup_meio);
    
    //limitando o player
    velh = 0;
    
    checa_chao();
    movimentacao_vertical();
    
    //tirando o bug q ele cai ao pegar o item
    //se ele está caindo então o colisor aparece
    if velv >= 0 {
        colisor[2] = obj_parede_one_way;
    }
    
    
}

estado_powerup_meio = function () { 
    
    troca_sprite(spr_player_powerup_2);
    
    //saindo do modo de powerup
    if !instance_exists(obj_particula_powerup){
        acabou_animacao(estado_powerup_fim);
    }
    
    //acabou_animacao(estado_powerup_fim);
    
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
    
    mask_index = spr_player_loop;
    troca_sprite(spr_player_loop);
    jump = false;
    movimentacao();
    checa_chao();
    //var _chao = place_meeting(x,y+1,chao_tinta)
    //nao deixando o player cair
    var _parar = !place_meeting(x + (velh * 18),y + 1,tile_set_tinta);
    //var _parando_na_tinta = !place_meeting(x + (velh * 18),y + 1,_chao);
    //parando com a tinta
    
        
    if _parar
    {
       velh = 0;
    };
    
    //checando se tem coisa em cima
    var _teto = place_meeting(x,y-10,colisor);
    
    //saindo do modo de tinta
    if tinta and velh == 0 and !_teto{
        
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
    
    //trocando a mascara de colisao
    mask_index = spr_player_idle;
    
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



