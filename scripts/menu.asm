origin $0005CBA6
text_menu:
    gameMenu($06, "WEAPON ")
    gameMenu($05, "ITEMS  ")
    gameMenu($06, "STATUS ")
    gameMenu($03, "MAP    ")
    gameMenu($04, "SAVE   ")
    gameMenu($03, "OK?    ")

status_menu:
    gameStatusMenu($04, $0E, $08, "RANK")
    gameStatusMenu($03, $0E, $0A, "H.P")
    gameStatusMenu($01, $16, $0A, "/")
    gameStatusMenu($03, $0E, $0C, "S.P")
    gameStatusMenu($01, $16, $0C, "/")
    gameStatusMenu($04, $0E, $0E, "KILL")

origin $5CC04
status_menu_vars:
    gameStatusMenuVar($03, $17, $08)
    gameStatusMenuVar($03, $13, $0A)
    gameStatusMenuVar($03, $17, $0A)
    gameStatusMenuVar($03, $13, $0C)
    gameStatusMenuVar($03, $17, $0C)
    gameStatusMenuVar($05, $15, $0E)

origin $3ED48
sound_menu:
    gameSoundMenu("TESTE SONORO")
sound_menu_bgm:
    gameSoundMenu("BGM")
sound_menu_sfx:
    gameSoundMenu("SFX")
sound_menu_pcm:
    gameSoundMenu("PCM")
sound_menu_exit:
    gameSoundMenu("SAIR")