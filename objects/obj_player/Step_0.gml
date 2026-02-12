//mask_index = spr_player_idle;
pega_input();
ajusta_xscale();
roda_debug();
ativa_debug();
movimento();
//retornando o efeito
retorna_squash();

abre_porta();
//Rodando o estado do player
estado();

//debug
if keyboard_check(vk_escape) game_restart();


