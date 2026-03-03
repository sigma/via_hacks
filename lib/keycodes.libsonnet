// Keycode converter for Keychron Launcher format.
// Converts VIA string keycodes to raw 16-bit QMK keycode numbers.
//
// Sources:
//   quantum/keycodes.h             - all KC_* and QK_* enum values
//   quantum/modifiers.h            - MOD_* bit values
//   quantum/quantum_keycodes.h     - macro definitions (MO, LT, MT, LCTL, ...)
//   data/constants/keycodes/       - authoritative hjson registry
//
// QMK 16-bit keycode range map:
//   0-255  Basic keycodes (USB HID usage 7 + consumer/system/mouse)
//   256-8191  QK_MODS: modifier+key combos
//                    LCTL(kc)=256|kc, LSFT=512, LALT=1024, LGUI=2048
//                    RCTL(kc)=4352|kc, RSFT=4608, RALT=5120, RGUI=6144
//                    Combos OR the bases: LCA=1280, LSA=1536, MEH=1792,
//                    LSG=2560, LAG=3072, LCAG=3328, HYPR=3840
//   8192-16383  QK_MOD_TAP: MT(mod,kc) = 8192|(mod<<8)|kc
//   16384-20479  QK_LAYER_TAP: LT(layer,kc) = 16384|((layer&15)<<8)|kc
//   20480-20991  QK_LAYER_MOD: LM(layer,mods) = 20480|((layer&15)<<5)|mods
//   20992-21023  QK_TO:              TO(n)  = 20992|(n&31)
//   21024-21055  QK_MOMENTARY:       MO(n)  = 21024|(n&31)
//   21056-21087  QK_DEF_LAYER:       DF(n)  = 21056|(n&31)
//   21088-21119  QK_TOGGLE_LAYER:    TG(n)  = 21088|(n&31)
//   21120-21151  QK_ONE_SHOT_LAYER:  OSL(n) = 21120|(n&31)
//   21152-21183  QK_ONE_SHOT_MOD:    OSM(m) = 21152|(m&31)
//   21184-21215  QK_LAYER_TAP_TOGGLE: TT(n) = 21184|(n&31)
//   22256-22262  Swap Hands
//   28672-28706  QK_MAGIC
//   28928-29183  QK_MIDI
//   29824-29845  QK_AUDIO
//   29936-29948  QK_STENO
//   30464-30495  QK_MACRO_0..31
//   30720-30726  QK_BACKLIGHT
//   30752-30772  RGB
//   31744-31864  QK_QUANTUM (boot, auto-shift, space cadet, unicode, haptic, ...)
//   32256-32319  QK_KB (keyboard-level custom, used by VIA CUSTOM(n))
//   32320-32767  QK_USER (user-level custom)

local simple = {
  // -----------------------------------------------------------------------
  // Internal
  // -----------------------------------------------------------------------
  'KC_NO': 0,         'XXXXXXX': 0,
  'KC_TRANSPARENT': 1, 'KC_TRNS': 1, '______': 1,

  // -----------------------------------------------------------------------
  // Letters  4-29
  // -----------------------------------------------------------------------
  'KC_A': 4, 'KC_B': 5, 'KC_C': 6, 'KC_D': 7,
  'KC_E': 8, 'KC_F': 9, 'KC_G': 10, 'KC_H': 11,
  'KC_I': 12, 'KC_J': 13, 'KC_K': 14, 'KC_L': 15,
  'KC_M': 16, 'KC_N': 17, 'KC_O': 18, 'KC_P': 19,
  'KC_Q': 20, 'KC_R': 21, 'KC_S': 22, 'KC_T': 23,
  'KC_U': 24, 'KC_V': 25, 'KC_W': 26, 'KC_X': 27,
  'KC_Y': 28, 'KC_Z': 29,

  // -----------------------------------------------------------------------
  // Numbers  30-39
  // -----------------------------------------------------------------------
  'KC_1': 30, 'KC_2': 31, 'KC_3': 32, 'KC_4': 33,
  'KC_5': 34, 'KC_6': 35, 'KC_7': 36, 'KC_8': 37,
  'KC_9': 38, 'KC_0': 39,

  // -----------------------------------------------------------------------
  // Editing  40-44
  // -----------------------------------------------------------------------
  'KC_ENTER': 40,    'KC_ENT': 40,
  'KC_ESCAPE': 41,   'KC_ESC': 41,
  'KC_BACKSPACE': 42, 'KC_BSPC': 42,
  'KC_TAB': 43,
  'KC_SPACE': 44,    'KC_SPC': 44,

  // -----------------------------------------------------------------------
  // Punctuation  45-56
  // -----------------------------------------------------------------------
  'KC_MINUS': 45,         'KC_MINS': 45,
  'KC_EQUAL': 46,         'KC_EQL': 46,
  'KC_LEFT_BRACKET': 47,  'KC_LBRC': 47,
  'KC_RIGHT_BRACKET': 48, 'KC_RBRC': 48,
  'KC_BACKSLASH': 49,     'KC_BSLS': 49,
  'KC_NONUS_HASH': 50,    'KC_NUHS': 50,
  'KC_SEMICOLON': 51,     'KC_SCLN': 51,
  'KC_QUOTE': 52,         'KC_QUOT': 52,
  'KC_GRAVE': 53,         'KC_GRV': 53,
  'KC_COMMA': 54,         'KC_COMM': 54,
  'KC_DOT': 55,
  'KC_SLASH': 56,         'KC_SLSH': 56,

  // -----------------------------------------------------------------------
  // Locks  57
  // -----------------------------------------------------------------------
  'KC_CAPS_LOCK': 57, 'KC_CAPS': 57,

  // -----------------------------------------------------------------------
  // Function keys F1-F12  58-69
  // -----------------------------------------------------------------------
  'KC_F1':  58, 'KC_F2':  59, 'KC_F3':  60, 'KC_F4':  61,
  'KC_F5':  62, 'KC_F6':  63, 'KC_F7':  64, 'KC_F8':  65,
  'KC_F9':  66, 'KC_F10': 67, 'KC_F11': 68, 'KC_F12': 69,

  // -----------------------------------------------------------------------
  // Navigation cluster  70-82
  // -----------------------------------------------------------------------
  'KC_PRINT_SCREEN': 70, 'KC_PSCR': 70,
  'KC_SCROLL_LOCK': 71,  'KC_SCRL': 71, 'KC_BRMD': 71,
  'KC_PAUSE': 72,        'KC_PAUS': 72, 'KC_BRK': 72, 'KC_BRMU': 72,
  'KC_INSERT': 73,       'KC_INS': 73,
  'KC_HOME': 74,
  'KC_PAGE_UP': 75,      'KC_PGUP': 75,
  'KC_DELETE': 76,       'KC_DEL': 76,
  'KC_END': 77,
  'KC_PAGE_DOWN': 78,    'KC_PGDN': 78,
  'KC_RIGHT': 79,        'KC_RGHT': 79,
  'KC_LEFT': 80,
  'KC_DOWN': 81,
  'KC_UP': 82,

  // -----------------------------------------------------------------------
  // Numpad  83-99
  // -----------------------------------------------------------------------
  'KC_NUM_LOCK': 83,    'KC_NUM': 83,
  'KC_KP_SLASH': 84,    'KC_PSLS': 84,
  'KC_KP_ASTERISK': 85, 'KC_PAST': 85,
  'KC_KP_MINUS': 86,    'KC_PMNS': 86,
  'KC_KP_PLUS': 87,     'KC_PPLS': 87,
  'KC_KP_ENTER': 88,    'KC_PENT': 88,
  'KC_KP_1': 89,        'KC_P1': 89,
  'KC_KP_2': 90,        'KC_P2': 90,
  'KC_KP_3': 91,        'KC_P3': 91,
  'KC_KP_4': 92,        'KC_P4': 92,
  'KC_KP_5': 93,        'KC_P5': 93,
  'KC_KP_6': 94,        'KC_P6': 94,
  'KC_KP_7': 95,        'KC_P7': 95,
  'KC_KP_8': 96,        'KC_P8': 96,
  'KC_KP_9': 97,        'KC_P9': 97,
  'KC_KP_0': 98,        'KC_P0': 98,
  'KC_KP_DOT': 99,      'KC_PDOT': 99,

  // -----------------------------------------------------------------------
  // Extended HID keys  100-115
  // -----------------------------------------------------------------------
  'KC_NONUS_BACKSLASH': 100, 'KC_NUBS': 100,
  'KC_APPLICATION': 101,     'KC_APP': 101,
  'KC_KB_POWER': 102,
  'KC_KP_EQUAL': 103,        'KC_PEQL': 103,
  'KC_F13': 104, 'KC_F14': 105, 'KC_F15': 106, 'KC_F16': 107,
  'KC_F17': 108, 'KC_F18': 109, 'KC_F19': 110, 'KC_F20': 111,
  'KC_F21': 112, 'KC_F22': 113, 'KC_F23': 114, 'KC_F24': 115,

  // -----------------------------------------------------------------------
  // Execute / edit cluster  116-129
  // -----------------------------------------------------------------------
  'KC_EXECUTE': 116,       'KC_EXEC': 116,
  'KC_HELP': 117,
  'KC_MENU': 118,
  'KC_SELECT': 119,        'KC_SLCT': 119,
  'KC_STOP': 120,
  'KC_AGAIN': 121,         'KC_AGIN': 121,
  'KC_UNDO': 122,
  'KC_CUT': 123,
  'KC_COPY': 124,
  'KC_PASTE': 125,         'KC_PSTE': 125,
  'KC_FIND': 126,
  'KC_KB_MUTE': 127,
  'KC_KB_VOLUME_UP': 128,
  'KC_KB_VOLUME_DOWN': 129,

  // -----------------------------------------------------------------------
  // Locking keys  130-132
  // -----------------------------------------------------------------------
  'KC_LOCKING_CAPS_LOCK': 130,   'KC_LCAP': 130,
  'KC_LOCKING_NUM_LOCK': 131,    'KC_LNUM': 131,
  'KC_LOCKING_SCROLL_LOCK': 132, 'KC_LSCR': 132,

  // -----------------------------------------------------------------------
  // Numpad extensions  133-134
  // -----------------------------------------------------------------------
  'KC_KP_COMMA': 133,        'KC_PCMM': 133,
  'KC_KP_EQUAL_AS400': 134,

  // -----------------------------------------------------------------------
  // International keys  135-143
  // -----------------------------------------------------------------------
  'KC_INTERNATIONAL_1': 135, 'KC_INT1': 135,
  'KC_INTERNATIONAL_2': 136, 'KC_INT2': 136,
  'KC_INTERNATIONAL_3': 137, 'KC_INT3': 137,
  'KC_INTERNATIONAL_4': 138, 'KC_INT4': 138,
  'KC_INTERNATIONAL_5': 139, 'KC_INT5': 139,
  'KC_INTERNATIONAL_6': 140, 'KC_INT6': 140,
  'KC_INTERNATIONAL_7': 141, 'KC_INT7': 141,
  'KC_INTERNATIONAL_8': 142, 'KC_INT8': 142,
  'KC_INTERNATIONAL_9': 143, 'KC_INT9': 143,

  // -----------------------------------------------------------------------
  // Language keys  144-152
  // -----------------------------------------------------------------------
  'KC_LANGUAGE_1': 144, 'KC_LNG1': 144,
  'KC_LANGUAGE_2': 145, 'KC_LNG2': 145,
  'KC_LANGUAGE_3': 146, 'KC_LNG3': 146,
  'KC_LANGUAGE_4': 147, 'KC_LNG4': 147,
  'KC_LANGUAGE_5': 148, 'KC_LNG5': 148,
  'KC_LANGUAGE_6': 149, 'KC_LNG6': 149,
  'KC_LANGUAGE_7': 150, 'KC_LNG7': 150,
  'KC_LANGUAGE_8': 151, 'KC_LNG8': 151,
  'KC_LANGUAGE_9': 152, 'KC_LNG9': 152,

  // -----------------------------------------------------------------------
  // Obscure HID keys  153-164
  // -----------------------------------------------------------------------
  'KC_ALTERNATE_ERASE': 153, 'KC_ERAS': 153,
  'KC_SYSTEM_REQUEST': 154,  'KC_SYRQ': 154,
  'KC_CANCEL': 155,          'KC_CNCL': 155,
  'KC_CLEAR': 156,           'KC_CLR': 156,
  'KC_PRIOR': 157,
  'KC_RETURN': 158,
  'KC_SEPARATOR': 159,       'KC_SEPR': 159,
  'KC_OUT': 160,
  'KC_OPER': 161,
  'KC_CLEAR_AGAIN': 162,
  'KC_CRSEL': 163,
  'KC_EXSEL': 164,

  // -----------------------------------------------------------------------
  // System keycodes (consumer page)  165-167
  // -----------------------------------------------------------------------
  'KC_SYSTEM_POWER': 165, 'KC_PWR': 165,
  'KC_SYSTEM_SLEEP': 166, 'KC_SLEP': 166,
  'KC_SYSTEM_WAKE': 167,  'KC_WAKE': 167,

  // -----------------------------------------------------------------------
  // Consumer / media keycodes  168-194
  // -----------------------------------------------------------------------
  'KC_AUDIO_MUTE': 168,         'KC_MUTE': 168,
  'KC_AUDIO_VOL_UP': 169,       'KC_VOLU': 169,
  'KC_AUDIO_VOL_DOWN': 170,     'KC_VOLD': 170,
  'KC_MEDIA_NEXT_TRACK': 171,   'KC_MNXT': 171,
  'KC_MEDIA_PREV_TRACK': 172,   'KC_MPRV': 172,
  'KC_MEDIA_STOP': 173,         'KC_MSTP': 173,
  'KC_MEDIA_PLAY_PAUSE': 174,   'KC_MPLY': 174,
  'KC_MEDIA_SELECT': 175,       'KC_MSEL': 175,
  'KC_MEDIA_EJECT': 176,        'KC_EJCT': 176,
  'KC_MAIL': 177,
  'KC_CALCULATOR': 178,         'KC_CALC': 178,
  'KC_MY_COMPUTER': 179,        'KC_MYCM': 179,
  'KC_WWW_SEARCH': 180,         'KC_WSCH': 180,
  'KC_WWW_HOME': 181,           'KC_WHOM': 181,
  'KC_WWW_BACK': 182,           'KC_WBAK': 182,
  'KC_WWW_FORWARD': 183,        'KC_WFWD': 183,
  'KC_WWW_STOP': 184,           'KC_WSTP': 184,
  'KC_WWW_REFRESH': 185,        'KC_WREF': 185,
  'KC_WWW_FAVORITES': 186,      'KC_WFAV': 186,
  'KC_MEDIA_FAST_FORWARD': 187, 'KC_MFFD': 187,
  'KC_MEDIA_REWIND': 188,       'KC_MRWD': 188,
  'KC_BRIGHTNESS_UP': 189,      'KC_BRIU': 189,
  'KC_BRIGHTNESS_DOWN': 190,    'KC_BRID': 190,
  'KC_CONTROL_PANEL': 191,      'KC_CPNL': 191,
  'KC_ASSISTANT': 192,          'KC_ASST': 192,
  'KC_MISSION_CONTROL': 193,    'KC_MCTL': 193,
  'KC_LAUNCHPAD': 194,          'KC_LPAD': 194,

  // -----------------------------------------------------------------------
  // Mouse keycodes  205-223
  // -----------------------------------------------------------------------
  'QK_MOUSE_CURSOR_UP': 205,    'MS_UP': 205,
  'QK_MOUSE_CURSOR_DOWN': 206,  'MS_DOWN': 206,
  'QK_MOUSE_CURSOR_LEFT': 207,  'MS_LEFT': 207,
  'QK_MOUSE_CURSOR_RIGHT': 208, 'MS_RGHT': 208,
  'QK_MOUSE_BUTTON_1': 209,     'MS_BTN1': 209,
  'QK_MOUSE_BUTTON_2': 210,     'MS_BTN2': 210,
  'QK_MOUSE_BUTTON_3': 211,     'MS_BTN3': 211,
  'QK_MOUSE_BUTTON_4': 212,     'MS_BTN4': 212,
  'QK_MOUSE_BUTTON_5': 213,     'MS_BTN5': 213,
  'QK_MOUSE_BUTTON_6': 214,     'MS_BTN6': 214,
  'QK_MOUSE_BUTTON_7': 215,     'MS_BTN7': 215,
  'QK_MOUSE_BUTTON_8': 216,     'MS_BTN8': 216,
  'QK_MOUSE_WHEEL_UP': 217,     'MS_WHLU': 217,
  'QK_MOUSE_WHEEL_DOWN': 218,   'MS_WHLD': 218,
  'QK_MOUSE_WHEEL_LEFT': 219,   'MS_WHLL': 219,
  'QK_MOUSE_WHEEL_RIGHT': 220,  'MS_WHLR': 220,
  'QK_MOUSE_ACCELERATION_0': 221, 'MS_ACL0': 221,
  'QK_MOUSE_ACCELERATION_1': 222, 'MS_ACL1': 222,
  'QK_MOUSE_ACCELERATION_2': 223, 'MS_ACL2': 223,

  // -----------------------------------------------------------------------
  // Modifier keycodes  224-231  (USB HID modifier usage page)
  // -----------------------------------------------------------------------
  'KC_LEFT_CTRL': 224,  'KC_LCTL': 224, 'KC_LCTRL': 224,
  'KC_LEFT_SHIFT': 225, 'KC_LSFT': 225,
  'KC_LEFT_ALT': 226,   'KC_LALT': 226, 'KC_LOPT': 226,
  'KC_LEFT_GUI': 227,   'KC_LGUI': 227, 'KC_LCMD': 227, 'KC_LWIN': 227,
  'KC_RIGHT_CTRL': 228,  'KC_RCTL': 228, 'KC_RCTRL': 228,
  'KC_RIGHT_SHIFT': 229, 'KC_RSFT': 229,
  'KC_RIGHT_ALT': 230,   'KC_RALT': 230, 'KC_ROPT': 230, 'KC_ALGR': 230,
  'KC_RIGHT_GUI': 231,   'KC_RGUI': 231, 'KC_RCMD': 231, 'KC_RWIN': 231,

  // -----------------------------------------------------------------------
  // Swap Hands  22256-22262
  // -----------------------------------------------------------------------
  'SH_TG': 22256, 'SH_TT': 22257, 'SH_MON': 22258,
  'SH_MOFF': 22259, 'SH_OFF': 22260, 'SH_ON': 22261, 'SH_OS': 22262,

  // -----------------------------------------------------------------------
  // Magic keycodes  QK_MAGIC = 28672
  // -----------------------------------------------------------------------
  'MAGIC_SWAP_CONTROL_CAPSLOCK': 28672,
  'MAGIC_UNSWAP_CONTROL_CAPSLOCK': 28673,
  'MAGIC_TOGGLE_CONTROL_CAPSLOCK': 28674,
  'MAGIC_UNCAPSLOCK_TO_CONTROL': 28675,
  'MAGIC_CAPSLOCK_TO_CONTROL': 28676,
  'MAGIC_SWAP_LALT_LGUI': 28677,
  'MAGIC_UNSWAP_LALT_LGUI': 28678,
  'MAGIC_SWAP_RALT_RGUI': 28679,
  'MAGIC_UNSWAP_RALT_RGUI': 28680,
  'MAGIC_UNNO_GUI': 28681,
  'MAGIC_NO_GUI': 28682,
  'MAGIC_TOGGLE_GUI': 28683,
  'MAGIC_SWAP_GRAVE_ESC': 28684,
  'MAGIC_UNSWAP_GRAVE_ESC': 28685,
  'MAGIC_SWAP_BACKSLASH_BACKSPACE': 28686,
  'MAGIC_UNSWAP_BACKSLASH_BACKSPACE': 28687,
  'MAGIC_TOGGLE_BACKSLASH_BACKSPACE': 28688,
  'MAGIC_HOST_NKRO': 28689,
  'MAGIC_UNHOST_NKRO': 28690,
  'MAGIC_TOGGLE_NKRO': 28691,
  'MAGIC_SWAP_ALT_GUI': 28692,
  'MAGIC_UNSWAP_ALT_GUI': 28693,
  'MAGIC_TOGGLE_ALT_GUI': 28694,
  'MAGIC_SWAP_LCTL_LGUI': 28695,
  'MAGIC_UNSWAP_LCTL_LGUI': 28696,
  'MAGIC_SWAP_RCTL_RGUI': 28697,
  'MAGIC_UNSWAP_RCTL_RGUI': 28698,
  'MAGIC_SWAP_CTL_GUI': 28699,
  'MAGIC_UNSWAP_CTL_GUI': 28700,
  'MAGIC_TOGGLE_CTL_GUI': 28701,
  'MAGIC_EE_HANDS_LEFT': 28702,
  'MAGIC_EE_HANDS_RIGHT': 28703,
  'MAGIC_SWAP_ESCAPE_CAPSLOCK': 28704,
  'MAGIC_UNSWAP_ESCAPE_CAPSLOCK': 28705,
  'MAGIC_TOGGLE_ESCAPE_CAPSLOCK': 28706,

  // -----------------------------------------------------------------------
  // MIDI keycodes  QK_MIDI = 28928
  // -----------------------------------------------------------------------
  'QK_MIDI_ON': 28928,   'MI_ON': 28928,
  'QK_MIDI_OFF': 28929,  'MI_OFF': 28929,
  'QK_MIDI_TOGGLE': 28930, 'MI_TOGG': 28930,
  // Notes: C_0..B_0 = 28944..28955, C_1..B_1 = 28960..28971, etc. through octave 5
  'QK_MIDI_NOTE_C_0': 28944,  'MI_C': 28944,
  'QK_MIDI_NOTE_CS_0': 28945, 'MI_Cs': 28945, 'MI_Db': 28945,
  'QK_MIDI_NOTE_D_0': 28946,  'MI_D': 28946,
  'QK_MIDI_NOTE_DS_0': 28947, 'MI_Ds': 28947, 'MI_Eb': 28947,
  'QK_MIDI_NOTE_E_0': 28948,  'MI_E': 28948,
  'QK_MIDI_NOTE_F_0': 28949,  'MI_F': 28949,
  'QK_MIDI_NOTE_FS_0': 28950, 'MI_Fs': 28950, 'MI_Gb': 28950,
  'QK_MIDI_NOTE_G_0': 28951,  'MI_G': 28951,
  'QK_MIDI_NOTE_GS_0': 28952, 'MI_Gs': 28952, 'MI_Ab': 28952,
  'QK_MIDI_NOTE_A_0': 28953,  'MI_A': 28953,
  'QK_MIDI_NOTE_AS_0': 28954, 'MI_As': 28954, 'MI_Bb': 28954,
  'QK_MIDI_NOTE_B_0': 28955,  'MI_B': 28955,
  // Octave controls
  'QK_MIDI_OCTAVE_N2': 29040,
  'QK_MIDI_OCTAVE_N1': 29041,
  'QK_MIDI_OCTAVE_0': 29042,
  'QK_MIDI_OCTAVE_1': 29043,
  'QK_MIDI_OCTAVE_2': 29044,
  'QK_MIDI_OCTAVE_3': 29045,
  'QK_MIDI_OCTAVE_4': 29046,
  'QK_MIDI_OCTAVE_5': 29047,
  'QK_MIDI_OCTAVE_6': 29048,
  'QK_MIDI_OCTAVE_7': 29049,
  'QK_MIDI_OCTAVE_DOWN': 29050, 'MI_OCTD': 29050,
  'QK_MIDI_OCTAVE_UP': 29051,   'MI_OCTU': 29051,
  // Transpose
  'QK_MIDI_TRANSPOSE_N6': 29056,
  'QK_MIDI_TRANSPOSE_N5': 29057,
  'QK_MIDI_TRANSPOSE_N4': 29058,
  'QK_MIDI_TRANSPOSE_N3': 29059,
  'QK_MIDI_TRANSPOSE_N2': 29060,
  'QK_MIDI_TRANSPOSE_N1': 29061,
  'QK_MIDI_TRANSPOSE_0': 29062,
  'QK_MIDI_TRANSPOSE_1': 29063,
  'QK_MIDI_TRANSPOSE_2': 29064,
  'QK_MIDI_TRANSPOSE_3': 29065,
  'QK_MIDI_TRANSPOSE_4': 29066,
  'QK_MIDI_TRANSPOSE_5': 29067,
  'QK_MIDI_TRANSPOSE_6': 29068,
  'QK_MIDI_TRANSPOSE_DOWN': 29069, 'MI_TRSD': 29069,
  'QK_MIDI_TRANSPOSE_UP': 29070,   'MI_TRSU': 29070,
  // Velocity
  'QK_MIDI_VELOCITY_0': 29072,  'MI_VL0': 29072,
  'QK_MIDI_VELOCITY_1': 29073,  'MI_VL1': 29073,
  'QK_MIDI_VELOCITY_2': 29074,  'MI_VL2': 29074,
  'QK_MIDI_VELOCITY_3': 29075,  'MI_VL3': 29075,
  'QK_MIDI_VELOCITY_4': 29076,  'MI_VL4': 29076,
  'QK_MIDI_VELOCITY_5': 29077,  'MI_VL5': 29077,
  'QK_MIDI_VELOCITY_6': 29078,  'MI_VL6': 29078,
  'QK_MIDI_VELOCITY_7': 29079,  'MI_VL7': 29079,
  'QK_MIDI_VELOCITY_8': 29080,  'MI_VL8': 29080,
  'QK_MIDI_VELOCITY_9': 29081,  'MI_VL9': 29081,
  'QK_MIDI_VELOCITY_10': 29082, 'MI_VL10': 29082,
  'QK_MIDI_VELOCITY_DOWN': 29083, 'MI_VELD': 29083,
  'QK_MIDI_VELOCITY_UP': 29084,   'MI_VELU': 29084,
  // Channel
  'QK_MIDI_CHANNEL_1': 29088,   'MI_CH1': 29088,
  'QK_MIDI_CHANNEL_2': 29089,   'MI_CH2': 29089,
  'QK_MIDI_CHANNEL_3': 29090,   'MI_CH3': 29090,
  'QK_MIDI_CHANNEL_4': 29091,   'MI_CH4': 29091,
  'QK_MIDI_CHANNEL_5': 29092,   'MI_CH5': 29092,
  'QK_MIDI_CHANNEL_6': 29093,   'MI_CH6': 29093,
  'QK_MIDI_CHANNEL_7': 29094,   'MI_CH7': 29094,
  'QK_MIDI_CHANNEL_8': 29095,   'MI_CH8': 29095,
  'QK_MIDI_CHANNEL_9': 29096,   'MI_CH9': 29096,
  'QK_MIDI_CHANNEL_10': 29097,  'MI_CH10': 29097,
  'QK_MIDI_CHANNEL_11': 29098,  'MI_CH11': 29098,
  'QK_MIDI_CHANNEL_12': 29099,  'MI_CH12': 29099,
  'QK_MIDI_CHANNEL_13': 29100,  'MI_CH13': 29100,
  'QK_MIDI_CHANNEL_14': 29101,  'MI_CH14': 29101,
  'QK_MIDI_CHANNEL_15': 29102,  'MI_CH15': 29102,
  'QK_MIDI_CHANNEL_16': 29103,  'MI_CH16': 29103,
  'QK_MIDI_CHANNEL_DOWN': 29104, 'MI_CHND': 29104,
  'QK_MIDI_CHANNEL_UP': 29105,   'MI_CHNU': 29105,
  // Effects
  'QK_MIDI_ALL_NOTES_OFF': 29120, 'MI_AOFF': 29120,
  'QK_MIDI_SUSTAIN': 29121,       'MI_SUST': 29121,
  'QK_MIDI_PORTAMENTO': 29122,    'MI_PORT': 29122,
  'QK_MIDI_SOSTENUTO': 29123,     'MI_SOST': 29123,
  'QK_MIDI_SOFT': 29124,          'MI_SOFT': 29124,
  'QK_MIDI_LEGATO': 29125,        'MI_LEG': 29125,
  'QK_MIDI_MODULATION': 29126,    'MI_MOD': 29126,
  'QK_MIDI_MODULATION_SPEED_DOWN': 29127, 'MI_MODD': 29127,
  'QK_MIDI_MODULATION_SPEED_UP': 29128,   'MI_MODU': 29128,
  'QK_MIDI_PITCH_BEND_DOWN': 29129, 'MI_BNDD': 29129,
  'QK_MIDI_PITCH_BEND_UP': 29130,   'MI_BNDU': 29130,

  // -----------------------------------------------------------------------
  // Audio keycodes  QK_AUDIO = 29824
  // -----------------------------------------------------------------------
  'QK_AUDIO_ON': 29824,              'AU_ON': 29824,
  'QK_AUDIO_OFF': 29825,             'AU_OFF': 29825,
  'QK_AUDIO_TOGGLE': 29826,          'AU_TOGG': 29826,
  'QK_AUDIO_CLICKY_TOGGLE': 29834,   'CK_TOGG': 29834,
  'QK_AUDIO_CLICKY_ON': 29835,       'CK_ON': 29835,
  'QK_AUDIO_CLICKY_OFF': 29836,      'CK_OFF': 29836,
  'QK_AUDIO_CLICKY_UP': 29837,       'CK_UP': 29837,
  'QK_AUDIO_CLICKY_DOWN': 29838,     'CK_DOWN': 29838,
  'QK_AUDIO_CLICKY_RESET': 29839,    'CK_RST': 29839,
  'QK_MUSIC_ON': 29840,              'MU_ON': 29840,
  'QK_MUSIC_OFF': 29841,             'MU_OFF': 29841,
  'QK_MUSIC_TOGGLE': 29842,          'MU_TOGG': 29842,
  'QK_MUSIC_MODE_NEXT': 29843,       'MU_NEXT': 29843,
  'QK_AUDIO_VOICE_NEXT': 29844,      'AU_NEXT': 29844,
  'QK_AUDIO_VOICE_PREVIOUS': 29845,  'AU_PREV': 29845,

  // -----------------------------------------------------------------------
  // Steno  29936-29948
  // -----------------------------------------------------------------------
  'QK_STENO_BOLT': 29936,
  'QK_STENO_GEMINI': 29937,
  'QK_STENO_COMB': 29938,
  'QK_STENO_COMB_MAX': 29948,

  // -----------------------------------------------------------------------
  // Macros  QK_MACRO_n = 30464 + n  (n = 0..31)
  // -----------------------------------------------------------------------
  'QK_MACRO_0': 30464,  'MC_0': 30464,
  'QK_MACRO_1': 30465,  'MC_1': 30465,
  'QK_MACRO_2': 30466,  'MC_2': 30466,
  'QK_MACRO_3': 30467,  'MC_3': 30467,
  'QK_MACRO_4': 30468,  'MC_4': 30468,
  'QK_MACRO_5': 30469,  'MC_5': 30469,
  'QK_MACRO_6': 30470,  'MC_6': 30470,
  'QK_MACRO_7': 30471,  'MC_7': 30471,
  'QK_MACRO_8': 30472,  'MC_8': 30472,
  'QK_MACRO_9': 30473,  'MC_9': 30473,
  'QK_MACRO_10': 30474, 'MC_10': 30474,
  'QK_MACRO_11': 30475, 'MC_11': 30475,
  'QK_MACRO_12': 30476, 'MC_12': 30476,
  'QK_MACRO_13': 30477, 'MC_13': 30477,
  'QK_MACRO_14': 30478, 'MC_14': 30478,
  'QK_MACRO_15': 30479, 'MC_15': 30479,
  'QK_MACRO_16': 30480, 'MC_16': 30480,
  'QK_MACRO_17': 30481, 'MC_17': 30481,
  'QK_MACRO_18': 30482, 'MC_18': 30482,
  'QK_MACRO_19': 30483, 'MC_19': 30483,
  'QK_MACRO_20': 30484, 'MC_20': 30484,
  'QK_MACRO_21': 30485, 'MC_21': 30485,
  'QK_MACRO_22': 30486, 'MC_22': 30486,
  'QK_MACRO_23': 30487, 'MC_23': 30487,
  'QK_MACRO_24': 30488, 'MC_24': 30488,
  'QK_MACRO_25': 30489, 'MC_25': 30489,
  'QK_MACRO_26': 30490, 'MC_26': 30490,
  'QK_MACRO_27': 30491, 'MC_27': 30491,
  'QK_MACRO_28': 30492, 'MC_28': 30492,
  'QK_MACRO_29': 30493, 'MC_29': 30493,
  'QK_MACRO_30': 30494, 'MC_30': 30494,
  'QK_MACRO_31': 30495, 'MC_31': 30495,

  // -----------------------------------------------------------------------
  // Backlight  QK_BACKLIGHT = 30720
  // -----------------------------------------------------------------------
  'QK_BACKLIGHT_ON': 30720,               'BL_ON': 30720,
  'QK_BACKLIGHT_OFF': 30721,              'BL_OFF': 30721,
  'QK_BACKLIGHT_TOGGLE': 30722,           'BL_TOGG': 30722,
  'QK_BACKLIGHT_DOWN': 30723,             'BL_DOWN': 30723,
  'QK_BACKLIGHT_UP': 30724,               'BL_UP': 30724,
  'QK_BACKLIGHT_STEP': 30725,             'BL_STEP': 30725,
  'QK_BACKLIGHT_TOGGLE_BREATHING': 30726, 'BL_BRTG': 30726,

  // -----------------------------------------------------------------------
  // RGB lighting  30752-30772
  // -----------------------------------------------------------------------
  'RGB_TOG': 30752,
  'RGB_MODE_FORWARD': 30753,  'RGB_MOD': 30753,
  'RGB_MODE_REVERSE': 30754,  'RGB_RMOD': 30754,
  'RGB_HUI': 30755,
  'RGB_HUD': 30756,
  'RGB_SAI': 30757,
  'RGB_SAD': 30758,
  'RGB_VAI': 30759,
  'RGB_VAD': 30760,
  'RGB_SPI': 30761,
  'RGB_SPD': 30762,
  'RGB_MODE_PLAIN': 30763,    'RGB_M_P': 30763,
  'RGB_MODE_BREATHE': 30764,  'RGB_M_B': 30764,
  'RGB_MODE_RAINBOW': 30765,  'RGB_M_R': 30765,
  'RGB_MODE_SWIRL': 30766,    'RGB_M_SW': 30766,
  'RGB_MODE_SNAKE': 30767,    'RGB_M_SN': 30767,
  'RGB_MODE_KNIGHT': 30768,   'RGB_M_K': 30768,
  'RGB_MODE_XMAS': 30769,     'RGB_M_X': 30769,
  'RGB_MODE_GRADIENT': 30770, 'RGB_M_G': 30770,
  'RGB_MODE_RGBTEST': 30771,  'RGB_M_T': 30771,
  'RGB_MODE_TWINKLE': 30772,  'RGB_M_TW': 30772,

  // -----------------------------------------------------------------------
  // Quantum keycodes  QK_QUANTUM = 31744
  // -----------------------------------------------------------------------
  'QK_BOOTLOADER': 31744, 'QK_BOOT': 31744,
  'QK_REBOOT': 31745,     'QK_RBT': 31745,
  'QK_DEBUG_TOGGLE': 31746, 'DB_TOGG': 31746,
  'QK_CLEAR_EEPROM': 31747, 'EE_CLR': 31747,
  'QK_MAKE': 31748,
  // Auto Shift
  'QK_AUTO_SHIFT_DOWN': 31760,   'AS_DOWN': 31760,
  'QK_AUTO_SHIFT_UP': 31761,     'AS_UP': 31761,
  'QK_AUTO_SHIFT_REPORT': 31762, 'AS_RPT': 31762,
  'QK_AUTO_SHIFT_ON': 31763,     'AS_ON': 31763,
  'QK_AUTO_SHIFT_OFF': 31764,    'AS_OFF': 31764,
  'QK_AUTO_SHIFT_TOGGLE': 31765, 'AS_TOGG': 31765,
  // Grave Escape / VelociKey
  'QK_GRAVE_ESCAPE': 31766, 'QK_GESC': 31766,
  'QK_VELOCIKEY_TOGGLE': 31767, 'VK_TOGG': 31767,
  // Space Cadet
  'QK_SPACE_CADET_LEFT_CTRL_PARENTHESIS_OPEN': 31768,   'SC_LCPO': 31768,
  'QK_SPACE_CADET_RIGHT_CTRL_PARENTHESIS_CLOSE': 31769, 'SC_RCPC': 31769,
  'QK_SPACE_CADET_LEFT_SHIFT_PARENTHESIS_OPEN': 31770,  'SC_LSPO': 31770,
  'KC_LSPO': 31770,  // legacy alias
  'QK_SPACE_CADET_RIGHT_SHIFT_PARENTHESIS_CLOSE': 31771, 'SC_RSPC': 31771,
  'KC_RSPC': 31771,  // legacy alias
  'QK_SPACE_CADET_LEFT_ALT_PARENTHESIS_OPEN': 31772,   'SC_LAPO': 31772,
  'QK_SPACE_CADET_RIGHT_ALT_PARENTHESIS_CLOSE': 31773, 'SC_RAPC': 31773,
  'QK_SPACE_CADET_RIGHT_SHIFT_ENTER': 31774,           'SC_SENT': 31774,
  // Output selection
  'QK_OUTPUT_AUTO': 31776,      'OU_AUTO': 31776,
  'QK_OUTPUT_USB': 31777,       'OU_USB': 31777,
  'QK_OUTPUT_BLUETOOTH': 31778, 'OU_BT': 31778,
  // Unicode mode
  'QK_UNICODE_MODE_NEXT': 31792,       'UC_NEXT': 31792,
  'QK_UNICODE_MODE_PREVIOUS': 31793,   'UC_PREV': 31793,
  'QK_UNICODE_MODE_MACOS': 31794,      'UC_MAC': 31794,
  'QK_UNICODE_MODE_LINUX': 31795,      'UC_LINX': 31795,
  'QK_UNICODE_MODE_WINDOWS': 31796,    'UC_WIN': 31796,
  'QK_UNICODE_MODE_BSD': 31797,        'UC_BSD': 31797,
  'QK_UNICODE_MODE_WINCOMPOSE': 31798, 'UC_WINC': 31798,
  'QK_UNICODE_MODE_EMACS': 31799,      'UC_EMAC': 31799,
  // Haptic
  'QK_HAPTIC_ON': 31808,              'HF_ON': 31808,
  'QK_HAPTIC_OFF': 31809,             'HF_OFF': 31809,
  'QK_HAPTIC_TOGGLE': 31810,          'HF_TOGG': 31810,
  'QK_HAPTIC_RESET': 31811,           'HF_RST': 31811,
  'QK_HAPTIC_FEEDBACK_TOGGLE': 31812, 'HF_FDBK': 31812,
  'QK_HAPTIC_BUZZ_TOGGLE': 31813,     'HF_BUZZ': 31813,
  'QK_HAPTIC_MODE_NEXT': 31814,       'HF_NEXT': 31814,
  'QK_HAPTIC_MODE_PREVIOUS': 31815,   'HF_PREV': 31815,
  'QK_HAPTIC_CONTINUOUS_TOGGLE': 31816, 'HF_CONT': 31816,
  'QK_HAPTIC_CONTINUOUS_UP': 31817,   'HF_CONU': 31817,
  'QK_HAPTIC_CONTINUOUS_DOWN': 31818, 'HF_COND': 31818,
  'QK_HAPTIC_DWELL_UP': 31819,        'HF_DWLU': 31819,
  'QK_HAPTIC_DWELL_DOWN': 31820,      'HF_DWLD': 31820,
  // Combo
  'QK_COMBO_ON': 31824,     'CM_ON': 31824,
  'QK_COMBO_OFF': 31825,    'CM_OFF': 31825,
  'QK_COMBO_TOGGLE': 31826, 'CM_TOGG': 31826,
  // Dynamic Macro
  'QK_DYNAMIC_MACRO_RECORD_START_1': 31827, 'DM_REC1': 31827,
  'QK_DYNAMIC_MACRO_RECORD_START_2': 31828, 'DM_REC2': 31828,
  'QK_DYNAMIC_MACRO_RECORD_STOP': 31829,    'DM_RSTP': 31829,
  'QK_DYNAMIC_MACRO_PLAY_1': 31830,         'DM_PLY1': 31830,
  'QK_DYNAMIC_MACRO_PLAY_2': 31831,         'DM_PLY2': 31831,
  // Leader / Lock
  'QK_LEADER': 31832, 'QK_LEAD': 31832,
  'QK_LOCK': 31833,
  // One-Shot toggle controls
  'QK_ONE_SHOT_TOGGLE': 31834, 'OS_TOGG': 31834,
  'QK_ONE_SHOT_ON': 31835,     'OS_ON': 31835,
  'QK_ONE_SHOT_OFF': 31836,    'OS_OFF': 31836,
  // Key Override
  'QK_KEY_OVERRIDE_TOGGLE': 31837, 'KO_TOGG': 31837,
  'QK_KEY_OVERRIDE_ON': 31838,     'KO_ON': 31838,
  'QK_KEY_OVERRIDE_OFF': 31839,    'KO_OFF': 31839,
  // Secure
  'QK_SECURE_LOCK': 31840,    'SE_LOCK': 31840,
  'QK_SECURE_UNLOCK': 31841,  'SE_UNLK': 31841,
  'QK_SECURE_TOGGLE': 31842,  'SE_TOGG': 31842,
  'QK_SECURE_REQUEST': 31843, 'SE_REQ': 31843,
  // Dynamic Tapping Term
  'QK_DYNAMIC_TAPPING_TERM_PRINT': 31856, 'DT_PRNT': 31856,
  'QK_DYNAMIC_TAPPING_TERM_UP': 31857,    'DT_UP': 31857,
  'QK_DYNAMIC_TAPPING_TERM_DOWN': 31858,  'DT_DOWN': 31858,
  // Caps Word / Autocorrect
  'QK_CAPS_WORD_TOGGLE': 31859, 'CW_TOGG': 31859,
  'QK_AUTOCORRECT_ON': 31860,   'AC_ON': 31860,
  'QK_AUTOCORRECT_OFF': 31861,  'AC_OFF': 31861,
  'QK_AUTOCORRECT_TOGGLE': 31862, 'AC_TOGG': 31862,
  // Tri-Layer
  'QK_TRI_LAYER_LOWER': 31863, 'TL_LOWR': 31863,
  'QK_TRI_LAYER_UPPER': 31864, 'TL_UPPR': 31864,
};

// -------------------------------------------------------------------------
// 5-bit modifier values used by QK_MOD_TAP, QK_ONE_SHOT_MOD, QK_LAYER_MOD.
//
// Bit layout (5-bit packed form, from quantum/modifiers.h):
//   bit 0 = LCTL  (1)
//   bit 1 = LSFT  (2)
//   bit 2 = LALT  (4)
//   bit 3 = LGUI  (8)
//   bit 4 = right-side flag (16)
// Right-side mods set bit 4 plus the same lower bits as their left counterpart:
//   RCTL=17, RSFT=18, RALT=20, RGUI=24
//
// The QK_MODS range (256-8191) uses these same values shifted left 8:
//   QK_LCTL=256, QK_LSFT=512, QK_LALT=1024, QK_LGUI=2048
//   QK_RCTL=4352, QK_RSFT=4608, QK_RALT=5120, QK_RGUI=6144
// -------------------------------------------------------------------------
local mod_flags = {
  'MOD_LCTL': 1,
  'MOD_LSFT': 2,
  'MOD_LALT': 4,
  'MOD_LGUI': 8,
  'MOD_RCTL': 17,
  'MOD_RSFT': 18,
  'MOD_RALT': 20,
  'MOD_RGUI': 24,
  'MOD_HYPR': 15,  // LCTL|LSFT|LALT|LGUI
  'MOD_MEH':  7,  // LCTL|LSFT|LALT
};

// Parse combined modifier expression like "MOD_LGUI | MOD_LCTL | MOD_LALT"
local parse_mods(expr) =
  local parts = std.split(expr, '|');
  std.foldl(
    function(acc, part) acc + mod_flags[std.stripChars(part, ' ')],
    parts,
    0
  );

// Extract content between first '(' and last ')'
local extract_parens(str) =
  local open = std.findSubstr('(', str)[0];
  std.substr(str, open + 1, std.length(str) - open - 2);

// Split "a, b" on the FIRST comma only (mod args may contain " | ")
local split_first_comma(s) =
  local idx = std.findSubstr(',', s)[0];
  [std.stripChars(std.substr(s, 0, idx), ' '),
   std.stripChars(std.substr(s, idx + 1, std.length(s) - idx - 1), ' ')];

// -------------------------------------------------------------------------
// encode(str) - convert a VIA keycode string to a 16-bit QMK integer.
//
// Supported parametric forms (all from quantum/quantum_keycodes.h):
//
//   Layer functions:
//     MO(layer)          Momentary:       21024 | (layer & 31)
//     TG(layer)          Toggle:          21088 | (layer & 31)
//     TO(layer)          Go-to:           20992 | (layer & 31)
//     TT(layer)          Tap-toggle:      21184 | (layer & 31)
//     OSL(layer)         One-shot layer:  21120 | (layer & 31)
//     DF(layer)          Default layer:   21056 | (layer & 31)
//     LT(layer, kc)      Layer-tap:       16384 | ((layer&15)<<8) | kc
//     LM(layer, mods)    Layer+mods:      20480 | ((layer&15)<<5) | mods
//
//   Mod-tap:
//     MT(mod, kc)        8192 | ((mod&31)<<8) | kc
//     OSM(mod)           21152 | (mod & 31)
//
//   Modifier+key combos (LCTL(kc) = 256|kc, etc.):
//     LCTL LSFT LALT LGUI RCTL RSFT RALT RGUI
//     LCA LSA LSG LAG LCAG MEH HYPR RCA RSA RCG RCAG
//
//   Mod-tap convenience wrappers (LCTL_T(kc) = MT(MOD_LCTL, kc), etc.):
//     LCTL_T LSFT_T LALT_T LGUI_T RCTL_T RSFT_T RALT_T RGUI_T
//     LCA_T LSA_T LSG_T LAG_T LCAG_T MEH_T HYPR_T RCA_T RSA_T RCG_T RCAG_T
//
//   User keycodes:
//     CUSTOM(n)   32256 + n  (QK_KB range, used by VIA/Keychron)
//     USERnn      32320 + n  (QK_USER range)
// -------------------------------------------------------------------------
local encode(str) =
  if std.objectHas(simple, str) then
    simple[str]

  // -----------------------------------------------------------------------
  // Custom keycodes
  //   CUSTOM(n) -> QK_KB_0 + n = 0x7E00 + n  (keyboard-level, used by VIA)
  //   USERnn    -> QK_USER_0 + nn = 0x7E40 + nn (user-level)
  // -----------------------------------------------------------------------
  else if std.startsWith(str, 'CUSTOM(') then
    local n = std.parseInt(extract_parens(str));
    32256 + n
  else if std.startsWith(str, 'USER') then
    local nn = std.parseInt(std.substr(str, 4, std.length(str) - 4));
    32320 + nn

  // -----------------------------------------------------------------------
  // Layer functions
  // -----------------------------------------------------------------------
  else if std.startsWith(str, 'MO(') then
    local n = std.parseInt(extract_parens(str));
    21024 + (n % 32)
  else if std.startsWith(str, 'TG(') then
    local n = std.parseInt(extract_parens(str));
    21088 + (n % 32)
  else if std.startsWith(str, 'TO(') then
    local n = std.parseInt(extract_parens(str));
    20992 + (n % 32)
  else if std.startsWith(str, 'TT(') then
    local n = std.parseInt(extract_parens(str));
    21184 + (n % 32)
  else if std.startsWith(str, 'OSL(') then
    local n = std.parseInt(extract_parens(str));
    21120 + (n % 32)
  else if std.startsWith(str, 'DF(') then
    local n = std.parseInt(extract_parens(str));
    21056 + (n % 32)
  else if std.startsWith(str, 'LT(') then
    // LT(layer, kc) = 16384 | ((layer & 15) << 8) | (kc & 255)
    local inner = extract_parens(str);
    local parts = split_first_comma(inner);
    local layer = std.parseInt(parts[0]);
    local kc = encode(parts[1]);
    16384 + ((layer % 16) * 256) + (kc % 256)
  else if std.startsWith(str, 'LM(') then
    // LM(layer, mods) = 20480 | ((layer & 15) << 5) | (mods & 31)
    local inner = extract_parens(str);
    local parts = split_first_comma(inner);
    local layer = std.parseInt(parts[0]);
    local mods = parse_mods(parts[1]);
    20480 + ((layer % 16) * 32) + (mods % 32)

  // -----------------------------------------------------------------------
  // Mod-tap and one-shot mod
  // -----------------------------------------------------------------------
  else if std.startsWith(str, 'MT(') then
    // MT(mod, kc) = 8192 | ((mod & 31) << 8) | (kc & 255)
    local inner = extract_parens(str);
    local parts = split_first_comma(inner);
    local mod_val = parse_mods(parts[0]);
    local key_val = encode(parts[1]);
    8192 + ((mod_val % 32) * 256) + (key_val % 256)
  else if std.startsWith(str, 'OSM(') then
    // OSM(mod) = 21152 | (mod & 31)
    local mod_val = parse_mods(extract_parens(str));
    21152 + (mod_val % 32)

  // -----------------------------------------------------------------------
  // Single modifier + key: LCTL(kc)=256|kc, LSFT=512, LALT=1024,
  //   LGUI=2048, RCTL=4352, RSFT=4608, RALT=5120, RGUI=6144
  // -----------------------------------------------------------------------
  else if std.startsWith(str, 'LCTL(') then 256 + encode(extract_parens(str))
  else if std.startsWith(str, 'LSFT(') then 512 + encode(extract_parens(str))
  else if std.startsWith(str, 'LALT(') then 1024 + encode(extract_parens(str))
  else if std.startsWith(str, 'LGUI(') then 2048 + encode(extract_parens(str))
  else if std.startsWith(str, 'RCTL(') then 4352 + encode(extract_parens(str))
  else if std.startsWith(str, 'RSFT(') then 4608 + encode(extract_parens(str))
  else if std.startsWith(str, 'RALT(') then 5120 + encode(extract_parens(str))
  else if std.startsWith(str, 'RGUI(') then 6144 + encode(extract_parens(str))

  // -----------------------------------------------------------------------
  // Combination modifier + key macros.
  // Each is the bitwise-OR of the constituent QK_* bases, plus kc.
  //
  //   LCA   = LCTL|LALT      = 256|1024 = 1280
  //   LSA   = LSFT|LALT      = 512|1024 = 1536
  //   MEH   = LCTL|LSFT|LALT = 256|512|1024 = 1792
  //   LSG   = LSFT|LGUI      = 512|2048 = 2560
  //   LAG   = LALT|LGUI      = 1024|2048 = 3072
  //   LCAG  = LCTL|LALT|LGUI = 256|1024|2048 = 3328
  //   HYPR  = LCTL|LSFT|LALT|LGUI = 3840
  //   RCA   = RCTL|RALT:  mod bits = (1|4)|16 = 21; base = 5376
  //   RSA   = RSFT|RALT:  mod bits = (2|4)|16 = 22; base = 5632
  //   RCG   = RCTL|RGUI:  mod bits = (1|8)|16 = 25; base = 6400
  //   RCAG  = RCTL|RALT|RGUI: mod = (1|4|8)|16 = 29; base = 7424
  // -----------------------------------------------------------------------
  else if std.startsWith(str, 'LCA(') then  1280 + encode(extract_parens(str))
  else if std.startsWith(str, 'LSA(') then  1536 + encode(extract_parens(str))
  else if std.startsWith(str, 'MEH(') then  1792 + encode(extract_parens(str))
  else if std.startsWith(str, 'LSG(') then  2560 + encode(extract_parens(str))
  else if std.startsWith(str, 'LAG(') then  3072 + encode(extract_parens(str))
  else if std.startsWith(str, 'LCAG(') then 3328 + encode(extract_parens(str))
  else if std.startsWith(str, 'HYPR(') then 3840 + encode(extract_parens(str))
  else if std.startsWith(str, 'RCA(') then  5376 + encode(extract_parens(str))
  else if std.startsWith(str, 'RSA(') then  5632 + encode(extract_parens(str))
  else if std.startsWith(str, 'RCG(') then  6400 + encode(extract_parens(str))
  else if std.startsWith(str, 'RCAG(') then 7424 + encode(extract_parens(str))

  // -----------------------------------------------------------------------
  // Mod-tap convenience wrappers.
  // XYYY_T(kc) = MT(MOD_XYYY, kc) = 8192 | (mod_val<<8) | kc
  //
  //   LCTL_T: mod=1 -> 8448   LSFT_T: 2 -> 8704
  //   LALT_T: mod=4 -> 9216   LGUI_T: 8 -> 10240
  //   RCTL_T: mod=17 -> 12544   RSFT_T: 18 -> 12800
  //   RALT_T: mod=20 -> 13312   RGUI_T: 24 -> 14336
  //   LCA_T:  mod=5 -> 9472   LSA_T:  6 -> 9728
  //   MEH_T:  mod=7 -> 9984   LSG_T:  10 -> 10752
  //   LAG_T:  mod=12 -> 11264   LCAG_T: 13 -> 11520
  //   HYPR_T: mod=15 -> 12032
  //   RCA_T:  mod=21 -> 13568   RSA_T:  22 -> 13824
  //   RCG_T:  mod=25 -> 14592   RCAG_T: 29 -> 15616
  // -----------------------------------------------------------------------
  else if std.startsWith(str, 'LCTL_T(') then 8448 + encode(extract_parens(str))
  else if std.startsWith(str, 'LSFT_T(') then 8704 + encode(extract_parens(str))
  else if std.startsWith(str, 'LALT_T(') then 9216 + encode(extract_parens(str))
  else if std.startsWith(str, 'LGUI_T(') then 10240 + encode(extract_parens(str))
  else if std.startsWith(str, 'RCTL_T(') then 12544 + encode(extract_parens(str))
  else if std.startsWith(str, 'RSFT_T(') then 12800 + encode(extract_parens(str))
  else if std.startsWith(str, 'RALT_T(') then 13312 + encode(extract_parens(str))
  else if std.startsWith(str, 'RGUI_T(') then 14336 + encode(extract_parens(str))
  else if std.startsWith(str, 'LCA_T(') then  9472 + encode(extract_parens(str))
  else if std.startsWith(str, 'LSA_T(') then  9728 + encode(extract_parens(str))
  else if std.startsWith(str, 'MEH_T(') then  9984 + encode(extract_parens(str))
  else if std.startsWith(str, 'LSG_T(') then  10752 + encode(extract_parens(str))
  else if std.startsWith(str, 'LAG_T(') then  11264 + encode(extract_parens(str))
  else if std.startsWith(str, 'LCAG_T(') then 11520 + encode(extract_parens(str))
  else if std.startsWith(str, 'HYPR_T(') then 12032 + encode(extract_parens(str))
  else if std.startsWith(str, 'RCA_T(') then  13568 + encode(extract_parens(str))
  else if std.startsWith(str, 'RSA_T(') then  13824 + encode(extract_parens(str))
  else if std.startsWith(str, 'RCG_T(') then  14592 + encode(extract_parens(str))
  else if std.startsWith(str, 'RCAG_T(') then 15616 + encode(extract_parens(str))

  else
    error 'Unknown keycode: ' + str;

// ---------------------------------------------------------------------------
// Legacy keycode translation tables (pre-refactor QMK ~0.17.x, Keychron fork)
//
// Keychron's legacy firmware removed BL_BRTG from the flat enum, shifting
// all keycodes after BL_STEP (23745) by -1 compared to standard QMK 0.18.0.
// The legacy values below account for this.
// ---------------------------------------------------------------------------

// Sorted array of [current_start, current_end, legacy_start].
// null legacy_start means "not available in legacy firmware".
local legacy_ranges = [
  [0, 255, 0],                    // Basic keycodes
  [256, 8191, 256],               // QK_MODS
  [8192, 16383, 24576],           // QK_MOD_TAP
  [16384, 20479, 16384],          // QK_LAYER_TAP
  [20992, 21023, 20480],          // QK_TO
  [21024, 21055, 20736],          // QK_MOMENTARY
  [21056, 21087, 20992],          // QK_DEF_LAYER
  [21088, 21119, 21248],          // QK_TOGGLE_LAYER
  [21120, 21151, 21504],          // QK_ONE_SHOT_LAYER
  [21152, 21183, 21760],          // QK_ONE_SHOT_MOD
  [21184, 21215, 22528],          // QK_LAYER_TAP_TOGGLE
  [22016, 22271, 22016],          // QK_SWAP_HANDS
  [22272, 22527, 22272],          // QK_TAP_DANCE
  [29936, 29948, 23088],          // Steno
  [28928, 28930, 23596],          // MIDI on/off/toggle
  [28944, 28955, 23599],          // MIDI notes octave 0
  [28960, 28971, 23611],          // MIDI notes octave 1
  [28976, 28987, 23623],          // MIDI notes octave 2
  [28992, 29003, 23635],          // MIDI notes octave 3
  [29008, 29019, 23647],          // MIDI notes octave 4
  [29024, 29035, 23659],          // MIDI notes octave 5
  [29040, 29051, 23671],          // MIDI octave controls
  [29056, 29070, 23683],          // MIDI transpose
  [29072, 29084, 23698],          // MIDI velocity
  [29088, 29105, 23711],          // MIDI channels
  [29120, 29130, 23729],          // MIDI effects
  [29824, 29826, 23581],          // Audio AU on/off/toggle
  [29834, 29845, 23584],          // Audio CK+MU block
  [30752, 30771, 23746],          // RGB (TOG-RGBTEST)
  [31776, 31777, 23772],          // Output AUTO/USB
  [31792, 31798, 23775],          // Unicode modes (NEXT-WINC)
  [31808, 31820, 23782],          // Haptic
  [31824, 31826, 23799],          // Combo
  [31827, 31831, 23811],          // Dynamic Macro
  [32256, 32319, 24448],          // QK_KB
  [32320, 32383, 24512],          // QK_USER
  // Not available in legacy (null base)
  [30464, 30495, null],           // QK_MACRO
  [31834, 31836, null],           // One Shot controls
  [31837, 31839, null],           // Key Override
  [31840, 31843, null],           // Secure
  [31856, 31858, null],           // Dynamic Tapping Term
  [31859, 31864, null],           // CapsWord/AC/TriLayer
];

// Individual keycodes where the order changed between versions.
// Maps string(current_val) -> legacy_val (or null if unavailable).
local legacy_keycodes = {
  // Backlight (order changed)
  '30720': 23740,   // BL_ON
  '30721': 23741,   // BL_OFF
  '30722': 23744,   // BL_TOGG
  '30723': 23742,   // BL_DOWN
  '30724': 23743,   // BL_UP
  '30725': 23745,   // BL_STEP
  '30726': 23745,   // BL_BRTG -> BL_STEP (no legacy equivalent)
  // RGB_MODE_TWINKLE
  '30772': null,     // position-dependent on Sequencer config
  // Quantum
  '31744': 23552,   // QK_BOOTLOADER
  '31745': null,     // QK_REBOOT (not in legacy)
  '31746': 23553,   // QK_DEBUG_TOGGLE
  '31747': 23774,   // QK_CLEAR_EEPROM (Keychron: std 23775 - 1)
  '31748': null,     // QK_MAKE (not in legacy)
  // Auto Shift (reordered)
  '31760': 23576,   // AS_DOWN
  '31761': 23575,   // AS_UP
  '31762': 23577,   // AS_RPT
  '31763': 23579,   // AS_ON
  '31764': 23580,   // AS_OFF
  '31765': 23578,   // AS_TOGG
  // Grave Escape
  '31766': 23574,   // QK_GRAVE_ESCAPE
  // Velocikey
  '31767': 23766,   // VK_TOGG (after BL, Keychron -1)
  // Space Cadet
  '31768': 23795,   // SC_LCPO
  '31769': 23796,   // SC_RCPC
  '31770': 23767,   // SC_LSPO
  '31771': 23768,   // SC_RSPC
  '31772': 23797,   // SC_LAPO
  '31773': 23798,   // SC_RAPC
  '31774': 23769,   // SC_SENT
  // Output BT
  '31778': 23849,   // OU_BT (Keychron: std 23850 - 1)
  // Unicode EMACS
  '31799': null,     // UC_EMAC
  // Leader/Lock
  '31832': 23848,   // QK_LEAD (Keychron: std 23849 - 1)
  '31833': 23850,   // QK_LOCK (Keychron: std 23851 - 1)
  // Magic keycodes - first batch (before BL block, NO Keychron shift)
  '28672': 23554,   // SWAP_CONTROL_CAPSLOCK
  '28673': 23563,   // UNSWAP_CONTROL_CAPSLOCK
  '28674': null,     // TOGGLE_CONTROL_CAPSLOCK
  '28675': 23564,   // UNCAPSLOCK_TO_CONTROL
  '28676': 23555,   // CAPSLOCK_TO_CONTROL
  '28677': 23556,   // SWAP_LALT_LGUI
  '28678': 23565,   // UNSWAP_LALT_LGUI
  '28679': 23557,   // SWAP_RALT_RGUI
  '28680': 23566,   // UNSWAP_RALT_RGUI
  '28681': 23567,   // UNNO_GUI
  '28682': 23558,   // NO_GUI
  '28683': null,     // TOGGLE_GUI
  '28684': 23559,   // SWAP_GRAVE_ESC
  '28685': 23568,   // UNSWAP_GRAVE_ESC
  '28686': 23560,   // SWAP_BACKSLASH_BACKSPACE
  '28687': 23569,   // UNSWAP_BACKSLASH_BACKSPACE
  '28688': null,     // TOGGLE_BACKSLASH_BACKSPACE
  '28689': 23561,   // HOST_NKRO
  '28690': 23570,   // UNHOST_NKRO
  '28691': 23572,   // TOGGLE_NKRO
  '28692': 23562,   // SWAP_ALT_GUI
  '28693': 23571,   // UNSWAP_ALT_GUI
  '28694': 23573,   // TOGGLE_ALT_GUI
  // Magic keycodes - second batch (after BL, Keychron -1, partially reordered)
  '28695': 23802,   // SWAP_LCTL_LGUI
  '28696': 23804,   // UNSWAP_LCTL_LGUI
  '28697': 23803,   // SWAP_RCTL_RGUI
  '28698': 23805,   // UNSWAP_RCTL_RGUI
  '28699': 23806,   // SWAP_CTL_GUI
  '28700': 23807,   // UNSWAP_CTL_GUI
  '28701': 23808,   // TOGGLE_CTL_GUI
  '28702': 23809,   // EE_HANDS_LEFT
  '28703': 23810,   // EE_HANDS_RIGHT
  // Magic keycodes - third batch (unknown)
  '28704': null,     // SWAP_ESCAPE_CAPSLOCK
  '28705': null,     // UNSWAP_ESCAPE_CAPSLOCK
  '28706': null,     // TOGGLE_ESCAPE_CAPSLOCK
};

// QK_LAYER_MOD changed encoding between versions:
//   Current: 0x5000 | ((layer & 0xF) << 5) | (mods & 0x1F) — 5-bit mods
//   Legacy:  0x5900 | ((layer & 0xF) << 4) | (mods & 0xF)  — 4-bit mods
local translate_layer_mod(val) =
  local off = val - 20480;
  local layer = std.floor(off / 32) % 16;
  local mods = off % 32;
  22784 + (layer * 16) + (mods % 16);

// Translate a current-version keycode value to a legacy-version value.
// If version != 'legacy', returns val unchanged.
local translate(val, version) =
  if version != 'legacy' then val
  else
    local key = std.toString(val);
    if std.objectHas(legacy_keycodes, key) then
      if legacy_keycodes[key] == null then
        error 'Keycode ' + key + ' not available in legacy firmware'
      else legacy_keycodes[key]
    else if val >= 20480 && val <= 20991 then
      translate_layer_mod(val)
    else
      local matches = [r for r in legacy_ranges if val >= r[0] && val <= r[1]];
      if std.length(matches) > 0 then
        if matches[0][2] == null then
          error 'Keycode ' + std.toString(val) + ' not available in legacy firmware'
        else matches[0][2] + (val - matches[0][0])
      else
        error 'No legacy translation for keycode ' + std.toString(val);

{
  encode:: encode,

  output(format, config, matrix)::
    if format == 'launcher' then
      self.to_launcher(config, matrix)
    else
      config,

  to_launcher(config, matrix)::
    local cols = matrix.cols;
    local rows = matrix.rows;
    local enc_keys = matrix.encoder_keys;
    local version = if std.objectHas(matrix, 'keycode_version')
                    then matrix.keycode_version
                    else 'current';
    local enc(str) = translate(encode(str), version);

    local layer_to_entries(layer) = [
      { col: i % cols, row: std.floor(i / cols), val: enc(layer[i]) }
      for i in std.range(0, std.length(layer) - 1)
    ] + [
      { col: j, row: rows, val: 0 }
      for j in std.range(0, enc_keys - 1)
    ];

    local keymap = [layer_to_entries(l) for l in config.layers];

    local knob =
      if std.objectHas(config, 'encoders') && std.length(config.encoders) > 0 then
        [
          { left: config.encoders[0][i][0], right: config.encoders[0][i][1] }
          for i in std.range(0, std.length(config.encoders[0]) - 1)
        ]
      else
        null;

    {
      id: config.vendorProductId,
      version: '1.0.0',
      MD5: std.md5(std.manifestJsonMinified(keymap)),
      keymap: keymap,
      [if knob != null then 'knob']: knob,
    },
}
