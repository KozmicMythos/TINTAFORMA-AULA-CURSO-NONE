estado = "fechada";

//Criando a minha particula
//ps_porta_abrindo
ps = part_system_create();
part_system_draw_order(ps, true);

//destruindo a particula
timer_destroi = 45;

//Emitter // Criando na memória do jogo
ptype1 = part_type_create();
part_type_shape(ptype1, pt_shape_cloud);
part_type_size(ptype1, 1, 1, 0, 0);
part_type_scale(ptype1, 0.2, 0.2);
part_type_speed(ptype1, -0.9, 0.3, 0, 0);
part_type_direction(ptype1, 80, 100, 0, 0);
part_type_gravity(ptype1, 0, 270);
part_type_orientation(ptype1, 0, 0, 0, 0, false);
part_type_colour3(ptype1, $E5E5E5, $999999, $4C4C4C);
part_type_alpha3(ptype1, 0.29, 0.337, 0.412);
part_type_blend(ptype1, false);
part_type_life(ptype1, 20, 30);

/*
pemit1 = part_emitter_create(ps);
part_emitter_region(ps, pemit1, -9.941174, 9.941174, -18.569519, -15.430481, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(ps, pemit1, ptype1, -2);

part_system_position(ps, room_width/2, room_height/2);*/




maquina_estados = function (){
    
    switch (estado) {
        
        case "fechada":
            
            break;
        
        
        case "abrindo":
            
            //Fazendo ela subir
            vspeed = -0.3;
            
            //Criando o sistema de particulas se ele ainda não existe
            //if !part_system_exists(ps){
                //
                ////Colocando a particula aonde deve ficar
                //ps = part_system_create(ps_porta_abrindo);
                ////arrumando a posição da particula                
                //part_system_position(ps,x ,y - 14);
                //
            //}
            
            //arrumando o x
            var _x = x + random_range(-sprite_width / 2,sprite_width / 2);
            //Criando a particula manualmente
            part_particles_create(ps, _x, ystart -  sprite_height, ptype1, 1);
            
            //adicionando screenshake
            screenshake(2);
            //fazendo a porta mexer para os lados
            x = xstart + random_range(-0.5,0.5);
            
            //Se o Y dela for maior que o ystart ( que é o começo de onde o objeto começou) - 33 (tamanho da sprite)
            //então ela fica aberta
            if y  < ystart - 32{
                estado = "aberta";
            }
            
            break;
        
        case "aberta":
            
            //zerando a velocidade
            vspeed = 0;
            
            //Normalizando o X
            x = xstart;
            
            //destruindo a particula
            timer_destroi--;
            if timer_destroi <= 0 {
                part_system_destroy(ps);  
            }
            //
            //teste_alpha-= 0.01;
             
            break;
        
        
        
    	
    }
    
    
}