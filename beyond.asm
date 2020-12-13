arch md.cpu
endian msb

output "beyond_br.md",create

include "asm/constants.asm"
include "asm/macros.asm"

origin $00000000
insert "beyond.md"

constant translation_ptbr(1)

// New ROM size
origin $1A4
  dl    rom_end

// Disable Checksum
origin $34E
  bra   $3C6

// Patch font
// origin $3342
//   jmp   new_font_1

origin $C394
  jmp     new_font_2    // Patch dialog font (rendered)

origin $3A7FE
  jmp     new_font_3    // Patch intro font

// Patch Logo
origin $3360
  jmp     new_logo

// Patch Menus
origin $443E
  jmp     new_menus_1

origin $470C
  jmp     new_menus_2

origin $5078
  jmp     new_menus_3

origin $4994
  jmp     new_menus_4

origin $05B2
  jmp     new_save_screen

origin $19EC
  jmp     new_name_screen

origin $6096
  jmp     new_game_over

// Patch clear buffer on dialogue
origin $C374
  lea     ($FFD400).l,a0 

// Patch clear buffer on dialogue (DMA SRC)
origin $C73E
  move.l  #($FFD400>>1),(a0)+

// Patch weapon and item name length from 8 to 16
origin $41D0
  jmp   new_weapon_name

origin $41AC
  jmp   new_item_name

origin $4212
  moveq   #3,d0
  move.b  #$80,d4
  move.w  #(item_counter_column),d5  


// Game Resources / Translation
include "asm/pointers.asm"
if (translation_ptbr) {
  include "scripts_br/text.asm"
  include "scripts_br/title.asm"
  include "scripts_br/menu.asm"
  include "scripts_br/items.asm"
  include "scripts_br/save_screen.asm"
  include "scripts_br/results.asm"
} else {
  include "scripts/text.asm"
  include "scripts/title.asm"
  include "scripts/menu.asm"
  include "scripts/items.asm"
  include "scripts/save_screen.asm"
  include "scripts/results.asm"
}

origin $003C0000

new_text_title_1:
  lea     (text_title_1).l,a6
  move.w  ($FF1654).l,d6
  andi.w  #$7F,d6
  cmpi.w  #$60,d6
  bcs     new_text_title_2
  lea     (text_title_2).l,a6
new_text_title_2:                      
  move.l  #$4A160003,d5 
  move.w  #$61C1,d6
  jmp     $00002CE4

new_text_title_3:
if (!original_title_screen) {
  // TRANSLATED
  lea     (text_title_3).l,a6
  move.l  #$4B880003,d5
  move.w  #$61C1,d6
  jsr     $00002CE4
  lea     (text_title_4).l,a6
  move.l  #$4C080003,d5
  move.w  #$61C1,d6
  jsr     $00002CE4
  lea     (text_title_5).l,a6
  move.l  #$4D080003,d5
  move.w  #$61C1,d6
  jsr     $00002CE4
} else {
  lea     (text_title_3).l,a6
  move.l  #$4C980003,d5
  move.w  #$61C1,d6
  jsr     $00002CE4
  lea     (text_title_4).l,a6
  move.l  #$4D100003,d5
  move.w  #$61C1,d6
  jsr     $00002CE4
}

  jmp     $000033D2

new_vars_status_menu:
  movea.l d7,a5
  lea     ($5CBF8).l,a5
  lea     (status_menu_vars).l,a3
  jmp     $0000514E

// new_font_1:
//   jsr   ($0003C956).l
//   tilecopy_to_ram(gfx_new_font, gfx_new_font_end-gfx_new_font, $FF2FA8)
//   jmp   $00003348

new_font_2:
  jsr     ($00003820).l
  tilecopy_to_ram(gfx_new_font, (gfx_new_font_end-gfx_new_font), $FF2FA8)
  jmp     $0000C39A

new_font_3:
  jsr     (decompress_gfx).l
  tilecopy_to_ram(gfx_new_font, (gfx_new_font_end-gfx_new_font), $FF316C)
  tilecopy_to_vram(gfx_new_font, (gfx_new_font_end-gfx_new_font), $6000)
  jmp     $0003A804

new_logo:
  tilecopy_to_ram(gfx_new_logo, (gfx_new_logo_end-gfx_new_logo), $FF492E)
  tilecopy_to_vram(gfx_new_font, (gfx_new_font_end-gfx_new_font), $F020)
  movea.l a3,a6
  move.w  #0,d0
  jmp     $00003366

new_menus_1:
  tilecopy_to_ram(gfx_new_menu_weapons, (gfx_new_menu_weapons_end-gfx_new_menu_weapons), $FF2FA8)
  tilecopy_to_ram(gfx_new_menu_items, (gfx_new_menu_items_end-gfx_new_menu_items), $FF31A8)
  tilecopy_to_ram(gfx_new_menu_map, (gfx_new_menu_map_end-gfx_new_menu_map), $FF35E8)
  tilecopy_to_ram(gfx_new_menu_status, (gfx_new_menu_status_end-gfx_new_menu_status), $FF37E8)
  jsr     $00004158
  jsr     $00004250
  jmp     $00004446

new_menus_2:
  tilecopy_to_ram(gfx_new_menu_weapons, (gfx_new_menu_weapons_end-gfx_new_menu_weapons), $FF2FA8)
  tilecopy_to_ram(gfx_new_menu_items, (gfx_new_menu_items_end-gfx_new_menu_items), $FF31A8)
  tilecopy_to_ram(gfx_new_menu_map, (gfx_new_menu_map_end-gfx_new_menu_map), $FF35E8)
  tilecopy_to_ram(gfx_new_menu_status, (gfx_new_menu_status_end-gfx_new_menu_status), $FF37E8)
  jsr     $00004158
  jsr     $00004250
  jmp     $00004714

new_menus_3:
  tilecopy_to_ram(gfx_new_menu_weapons, (gfx_new_menu_weapons_end-gfx_new_menu_weapons), $FF2FA8)
  tilecopy_to_ram(gfx_new_menu_items, (gfx_new_menu_items_end-gfx_new_menu_items), $FF31A8)
  tilecopy_to_ram(gfx_new_menu_map, (gfx_new_menu_map_end-gfx_new_menu_map), $FF35E8)
  tilecopy_to_ram(gfx_new_menu_status, (gfx_new_menu_status_end-gfx_new_menu_status), $FF37E8)
  jsr     $00004158
  jsr     $00004250
  jmp     $00005080

new_menus_4:
  tilecopy_to_ram(gfx_new_menu_weapons, (gfx_new_menu_weapons_end-gfx_new_menu_weapons), $FF2FA8)
  tilecopy_to_ram(gfx_new_menu_items, (gfx_new_menu_items_end-gfx_new_menu_items), $FF31A8)
  tilecopy_to_ram(gfx_new_menu_map, (gfx_new_menu_map_end-gfx_new_menu_map), $FF35E8)
  tilecopy_to_ram(gfx_new_menu_status, (gfx_new_menu_status_end-gfx_new_menu_status), $FF37E8)
  jsr     $00004AD0
  tst.b   ($FF1996).l
  jmp     $0000499E

new_save_screen:
  jsr     $00007E2
  tilecopy_to_vram(gfx_new_save_screen_tilemap, (gfx_new_save_screen_tilemap_end-gfx_new_save_screen_tilemap), $E000)
  tilecopy_to_vram(gfx_new_save_screen, (gfx_new_save_screen_end-gfx_new_save_screen), $0000)
  jsr     $0000091C
  jmp     $000005BA

new_save_screen_text:
  lea     (text_savescreen).l,a0
  move.w  #$48C,d0
  jmp     $000009FC

new_name_screen:
  tilecopy_to_vram(gfx_new_name_screen, (gfx_new_name_screen_end-gfx_new_name_screen), $0000)
  tilecopy_to_vram(gfx_new_name_screen_tilemap, (gfx_new_name_screen_tilemap_end-gfx_new_name_screen_tilemap), $C000)
  jsr     $0002D84
  jmp     $00019F2

new_game_over:
  tilecopy_to_vram(gfx_new_gameover, (gfx_new_gameover_end-gfx_new_gameover), $0000)
  tilecopy_to_vram(gfx_new_gameover_tilemap, (gfx_new_gameover_tilemap_end-gfx_new_gameover_tilemap), $C000)
  jsr     $0002D84
  jmp     $00060A4 

new_weapon_name:
  clr     d0
  move.w  d5,d0
  muls.w  #(item_length/8),d0
  adda.l  d0,a0
  clr.l   d0
  moveq   #(item_length),d0
  move.b  #$80,d4
  clr.l   d5
  move.b  #(weapon_column),d5
  jmp     $000041DC

new_item_name:
  clr     d0
  move.w  d5,d0
  muls.w  #(item_length/8),d0
  adda.l  d0,a0
  clr.l   d0
new_item_name_end:
  moveq   #(item_length),d0
  move.b  #$80,d4
  clr.l   d5
  move.b  #(item_column),d5
  jmp     $000041B8

new_results:
  tilecopy_to_vram(gfx_new_font, (gfx_new_font_end-gfx_new_font), $A900)
  lea     (text_results).l,a0
  move.w  #$548,d1
  jmp     $0003DDA2

new_best_results:
  tilecopy_to_vram(gfx_new_font, (gfx_new_font_end-gfx_new_font), $A900)
  lea     (text_best_results).l,a0
  move.w  #$548,d1
  jmp     $0003E266

new_results_places:
  tilecopy_to_vram(gfx_new_font_results, (gfx_new_font_results_end-gfx_new_font_results), $F000)
  lea     (text_results_places).l,a0
  move.w  #$2780,d1
  jmp     $0003E2C4

new_sound_menu:
  lea     (sound_menu).l,a0
  move.w  #$8548,d1
  jmp     $0003E86C

new_sound_menu_exit:
  lea     (sound_menu_exit).l,a0
  move.w  (a1)+,d0
  jmp     $0003ED1E

include "asm/graphics.asm"

origin $00400000
rom_end:
  // EOF