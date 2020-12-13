origin $0000350E
  jmp     new_text_title_1

origin $000033AE
  jmp     new_text_title_3

origin $00003F8E
  lea     (text_menu).l,a0

origin $00005120
  lea     (status_menu).l,a0

origin $00005148
  jmp     new_vars_status_menu

origin $000041A6
  lea     (item_names).l,a0 

origin $000041CA
  lea     (item_names).l,a0 

origin $0000C3FE
  lea     (text_dialogues).l,a0

origin $0003B5FA
  lea     (text_dialogues).l,a0

origin $000040EE
  lea     (gfx_new_font_item).l,a3

origin $000009F4
  jmp     new_save_screen_text

origin $0003DD9A
  jmp     new_results

origin $0003E25E
  jmp     new_best_results

origin $0003E2BC
  jmp     new_results_places

origin $0003E864
  jmp     new_sound_menu
origin $0003ED18
  jmp     new_sound_menu_exit