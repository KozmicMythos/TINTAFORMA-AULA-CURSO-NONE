//Destruindo o poder se encostar no player
if destroi_poder == true {
    
    image_alpha -= 0.01;
    
    if image_alpha <= 0 { 
        instance_destroy(); 
    }
}