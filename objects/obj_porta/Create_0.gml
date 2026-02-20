estado = "fechada";

//Criando a minha particula
ps = noone;



maquina_estados = function (){
    
    switch (estado) {
        
        case "fechada":
            
            break;
        
        
        case "abrindo":
            
            //Fazendo ela subir
            vspeed = -0.3;
            
            //Criando o sistema de particulas se ele ainda não existe
            if !part_system_exists(ps){
                
                //Colocando a particula aonde deve ficar
                ps = part_system_create(ps_porta_abrindo);
                //arrumando a posição da particula                
                part_system_position(ps,x ,y - 14);
                
            }
            
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
            part_system_destroy(ps);
             
            break;
        
        
        
    	
    }
    
    
}