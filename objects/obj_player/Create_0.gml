#region  Variaveis

//movimentação
velh     = 0;
max_velh = 1;
velv     = 0;
max_velv = 3;
grav     = .2;
chao     = false;


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

checa_chao = function ()
{ 
    chao = place_meeting(x,y + 1,obj_parede);  
}




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
    
}


#endregion


