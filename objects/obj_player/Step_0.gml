pega_input();
checa_chao();
movimentacao();
if keyboard_check_pressed(vk_enter)  {
    show_message("DESATIVEI")
    global.debug = !global.debug;
}
show_debug_message(global.debug);