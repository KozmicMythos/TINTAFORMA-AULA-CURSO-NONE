#region  Variaveis

//movimentação
velh     = 0;
max_velh = 1;


#endregion

#region  Inputs

//variaveis dos comandos
right = 0;
left  = 0;
jump  = 0;

pega_input = function (){
    
    left  = keyboard_check(vk_left)//keyboard_set_map(ord("A"),vk_left);
    right = keyboard_check(vk_right)//keyboard_set_map(ord("D"),vk_right);
    jump  = keyboard_check(vk_space);
}


#endregion



#region Métodos

movimentacao = function () {
    
    
    //aplicando os inputs no velh 
    velh = (right - left) * max_velh;
    
    x += velh;
     
    
}

#endregion