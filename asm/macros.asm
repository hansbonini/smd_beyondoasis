macro gameScript(TEXT) {
  table "tbl/scripts.tbl"
  db    {TEXT}
  db    ENDSTRING
}

macro gameMenu(LENGTH, TEXT) {
    table "tbl/menus_items.tbl"
    db {LENGTH}
    db {TEXT}
}

macro gameStatusMenu(LENGTH, COLUMN, LINE, TEXT) {
    table "tbl/menus_items.tbl"
    db {LENGTH}
    db {COLUMN}
    db {LINE}
    db {TEXT}
}

macro gameStatusMenuVar(LENGTH, COLUMN, LINE) {
    db {LENGTH}
    db {COLUMN}
    db {LINE}
}

macro gameResults(TEXT) {
    table "tbl/scripts.tbl"
    db {TEXT}
    db ENDSTRING
}

macro gameTitle(TEXT) {
    table "tbl/scripts.tbl"
    db {TEXT}
    db ENDSTRING
}

macro gameSoundMenu(TEXT) {
    table "tbl/scripts.tbl"
    db {TEXT}
    db ENDSTRING
}

macro gameItem(TEXT) {
    table "tbl/menus_items.tbl"
    db {TEXT}
}

macro save_registers_to_sp() {
    movem.l #$FFFF,-(a7)
}
macro load_registers_from_sp() {
    movem.l (a7)+,#$FFFF
}

macro tilecopy_to_ram(SRC, LENGTH, DEST) {
    save_registers_to_sp()

    movea.l #({DEST}),a1
    movea.l #({SRC}),a0
    clr.l   d0
    move.l  #(({LENGTH}/32)-3),d0
-
    move.l  (a0)+,(a1)+ //; TILE LINE #1
    move.l  (a0)+,(a1)+ //; TILE LINE #2
    move.l  (a0)+,(a1)+ //; TILE LINE #3
    move.l  (a0)+,(a1)+ //; TILE LINE #4
    move.l  (a0)+,(a1)+ //; TILE LINE #5
    move.l  (a0)+,(a1)+ //; TILE LINE #6
    move.l  (a0)+,(a1)+ //; TILE LINE #7
    move.l  (a0)+,(a1)+ //; TILE LINE #8
    dbf     d0,-

    load_registers_from_sp()
}

macro tilecopy_to_vram(SRC, LENGTH, DEST) {
    save_registers_to_sp()

    move.l  #($40000000+(({DEST}&$3FFF)<<16)+(({DEST}&$C000)>>14)),(VDP_CTRL).l
    movea.l #({SRC}),a0
    clr.l   d0
    move.l  #(({LENGTH}/32)-3),d0
-
    move.l  (a0)+,(VDP_DATA).l //; TILE LINE #1
    move.l  (a0)+,(VDP_DATA).l //; TILE LINE #2
    move.l  (a0)+,(VDP_DATA).l //; TILE LINE #3
    move.l  (a0)+,(VDP_DATA).l //; TILE LINE #4
    move.l  (a0)+,(VDP_DATA).l //; TILE LINE #5
    move.l  (a0)+,(VDP_DATA).l //; TILE LINE #6
    move.l  (a0)+,(VDP_DATA).l //; TILE LINE #7
    move.l  (a0)+,(VDP_DATA).l //; TILE LINE #8
    dbf     d0,-

    load_registers_from_sp()
}