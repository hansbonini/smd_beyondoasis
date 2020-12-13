origin $003F0000
text_menu:
    gameMenu($05, "ARMAS  ")
    gameMenu($05, "ITENS  ")
    gameMenu($05, "HERÓI  ")
    gameMenu($04, "MAPA   ")
    gameMenu($06, "SALVAR ")
    gameMenu($03, "OK?    ")

status_menu:
    gameStatusMenu($05, $0D, $08, "NÍVEL")
    gameStatusMenu($05, $0D, $0A, "SAÚDE")
    gameStatusMenu($01, $17, $0A, "/")
    gameStatusMenu($05, $0D, $0C, "MAGIA")
    gameStatusMenu($01, $17, $0C, "/")
    gameStatusMenu($06, $0D, $0E, "ABATES")

origin $5CC04
status_menu_vars:
    gameStatusMenuVar($03, $18, $08)
    gameStatusMenuVar($03, $14, $0A)
    gameStatusMenuVar($03, $18, $0A)
    gameStatusMenuVar($03, $14, $0C)
    gameStatusMenuVar($03, $18, $0C)
    gameStatusMenuVar($05, $16, $0E)


origin $00384500
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