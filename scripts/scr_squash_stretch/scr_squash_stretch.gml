//o efeito começa aqui, no create, criando o xscale e o yscale
function inicia_efeito_squash()
{
    //iniciando o efeito
    xscale = 1;
    yscale = 1;    

}

//Aqui é aonde o efeito será aplicado, por exemplo: o exato momento em que o personagem cai no chao;
function efeito_squash(_xscale = 1, _yscale = 1)
{
    xscale = _xscale;
    yscale = _yscale;
    
}

//Aqui é para normalizar o efeito
function retorna_squash(_qtd = .1)
{
    
    xscale = lerp(xscale,1,_qtd);
    yscale = lerp(yscale,1,_qtd); 
    
}

//Temos que colocar esse aqui no draw do jogador
function desenha_efeito_squash()
{
    
    draw_sprite_ext(sprite_index,image_index,x,y,xscale,yscale,image_angle,image_blend,image_alpha);

}