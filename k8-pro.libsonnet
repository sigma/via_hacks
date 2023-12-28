function() {
    new:: function(via) {
        local ______ = "KC_TRNS",

        name:: 'Keychron K8 Pro',
        id:: 875823744,

        default_macros:: function()
            via.block('', 16),

        default_mac_layer:: function()
            local MC = self.custom_keys.get("Mission Control");
            local LP = self.custom_keys.get("Launch pad");
            local SS = self.custom_keys.get("Screen shot");
            local SI = self.custom_keys.get("Siri");
            local LO = self.custom_keys.get("Left Option");
            local LC = self.custom_keys.get("Left Cmd");
            local RO = self.custom_keys.get("Right Option");
            local RC = self.custom_keys.get("Right Cmd");

            via.layer([
                ['KC_ESC', 'KC_BRID','KC_BRIU',MC,LP, 'RGB_VAD','RGB_VAI','KC_MPRV','KC_MPLY', 'KC_MNXT','KC_MUTE','KC_VOLD','KC_VOLU',     SS,        SI,     'RGB_MOD'],
                ['KC_GRV','KC_1','KC_2','KC_3','KC_4','KC_5','KC_6','KC_7','KC_8','KC_9','KC_0','KC_MINS','KC_EQL',     'KC_BSPC',       'KC_INS',  'KC_HOME', 'KC_PGUP'],
                ['KC_TAB',  'KC_Q','KC_W','KC_E','KC_R','KC_T','KC_Y','KC_U','KC_I','KC_O','KC_P', 'KC_LBRC', 'KC_RBRC', 'KC_BSLS',      'KC_DEL',  'KC_END',  'KC_PGDN'],
                ['KC_CAPS',   'KC_A','KC_S','KC_D','KC_F','KC_G','KC_H','KC_J','KC_K','KC_L','KC_SCLN', 'KC_QUOT',      'KC_ENT'                                        ],
                ['KC_LSFT',     'KC_Z','KC_X','KC_C','KC_V','KC_B','KC_N','KC_M', 'KC_COMM', 'KC_DOT', 'KC_SLSH',       'KC_RSFT',                  'KC_UP'             ],
                ['KC_LCTL',LO,LC,                           'KC_SPC',                                    RC,RO,'MO(1)', 'KC_RCTL',       'KC_LEFT', 'KC_DOWN', 'KC_RGHT'],
            ]),

        default_mac_fn_layer:: function()
            local BT1 = self.custom_keys.get("Bluetooth Host 1");
            local BT2 = self.custom_keys.get("Bluetooth Host 2");
            local BT3 = self.custom_keys.get("Bluetooth Host 3");
            local BL = self.custom_keys.get("Battery Level");

            via.layer([
                [ ______,    'KC_F1','KC_F2','KC_F3','KC_F4',  'KC_F5','KC_F6','KC_F7','KC_F8',  'KC_F9','KC_F10','KC_F11','KC_F12',       ______, ______,'RGB_TOG'],
                [ ______,BT1, BT2, BT3,  ______, ______, ______, ______, ______, ______,  ______,  ______,  ______,        ______,         ______, ______, ______  ],
                ['RGB_TOG','RGB_MOD','RGB_VAI','RGB_HUI','RGB_SAI','RGB_SPI',______,______,______,______,______,______,______,______,      ______, ______, ______  ],
                [______,'RGB_RMOD','RGB_VAD','RGB_HUD','RGB_SAD','RGB_SPD', ______, ______, ______, ______, ______, ______, ______                                 ],
                [______,    ______,   ______,   ______,   ______,   BL,   ______,   ______,   ______,   ______,   ______,   ______,                ______          ],
                [______,______,______,                           ______,                                ______,______,______,______,       ______, ______, ______  ],
            ]),

        default_win_layer:: function()
            local CO = self.custom_keys.get("Cortana");

            via.layer([
                ['KC_ESC', 'KC_F1','KC_F2','KC_F3','KC_F4',  'KC_F5','KC_F6','KC_F7','KC_F8',  'KC_F9','KC_F10','KC_F11','KC_F12',       'KC_PSCR',    CO,     'RGB_MOD'],
                ['KC_GRV','KC_1','KC_2','KC_3','KC_4','KC_5','KC_6','KC_7','KC_8','KC_9','KC_0','KC_MINS','KC_EQL',     'KC_BSPC',       'KC_INS',  'KC_HOME', 'KC_PGUP'],
                ['KC_TAB',  'KC_Q','KC_W','KC_E','KC_R','KC_T','KC_Y','KC_U','KC_I','KC_O','KC_P', 'KC_LBRC', 'KC_RBRC', 'KC_BSLS',      'KC_DEL',  'KC_END',  'KC_PGDN'],
                ['KC_CAPS',   'KC_A','KC_S','KC_D','KC_F','KC_G','KC_H','KC_J','KC_K','KC_L','KC_SCLN', 'KC_QUOT',      'KC_ENT'                                        ],
                ['KC_LSFT',     'KC_Z','KC_X','KC_C','KC_V','KC_B','KC_N','KC_M', 'KC_COMM', 'KC_DOT', 'KC_SLSH',       'KC_RSFT',                  'KC_UP'             ],
                ['KC_LCTL','KC_LGUI','KC_LALT',             'KC_SPC',                       'KC_RALT','KC_RGUI','MO(3)','KC_RCTL',       'KC_LEFT', 'KC_DOWN', 'KC_RGHT'],
            ]),

        default_win_fn_layer:: function()
            local TV = self.custom_keys.get("Task View");
            local FE = self.custom_keys.get("File Explorer");
            local BT1 = self.custom_keys.get("Bluetooth Host 1");
            local BT2 = self.custom_keys.get("Bluetooth Host 2");
            local BT3 = self.custom_keys.get("Bluetooth Host 3");
            local BL = self.custom_keys.get("Battery Level");

            via.layer([
                [ ______,  'KC_BRID','KC_BRIU',TV,FE,  'RGB_VAD','RGB_VAI','KC_MPRV','KC_MPLY', 'KC_MNXT','KC_MUTE','KC_VOLD','KC_VOLU',   ______, ______,'RGB_TOG'],
                [ ______,BT1, BT2, BT3, ______, ______, ______, ______, ______, ______, ______, ______, ______,          ______,           ______, ______, ______  ],
                ['RGB_TOG','RGB_MOD','RGB_VAI','RGB_HUI','RGB_SAI','RGB_SPI',______,______,______,______,______,______,______,______,      ______, ______, ______  ],
                [______,'RGB_RMOD', 'RGB_VAD', 'RGB_HUD', 'RGB_SAD', 'RGB_SPD', ______, ______, ______, ______, ______, ______, ______                             ],
                [______,   ______, ______, ______, ______,   BL  , ______, ______, ______, ______, ______,               ______,                   ______          ],
                [______, ______, ______,                   ______,                                    ______, ______, ______, ______,      ______, ______, ______  ],
            ]),  

        // each row is padded to 17 items
        padder:: function(keys) [
            // row 0
            keys[0][0:13],
            via.no(1),
            keys[0][13:16],
            // row 1
            keys[1],
            // row 2
            keys[2],
            // row 3
            keys[3][0:12],
            via.no(1),
            keys[3][12:13],
            via.no(3),
            // row 4
            keys[4][0:1],
            via.no(1),
            keys[4][1:11],
            via.no(1),
            keys[4][11:12],
            via.no(1),
            keys[4][12:13],
            via.no(1),
            // row 5
            keys[5][0:3],
            via.no(3),
            keys[5][3:4],
            via.no(3),
            keys[5][4:11],
        ],

        custom_keys:: {
            keys:: [
                'Left Option',
                'Right Option',
                'Left Cmd',
                'Right Cmd',
                'Mission Control',
                'Launch pad',
                'Task View',
                'File Explorer',
                'Screen shot',
                'Cortana',
                'Siri',
                'Bluetooth Host 1',
                'Bluetooth Host 2',
                'Bluetooth Host 3',
                'Battery Level',
            ],

            get:: function(label)
                local idx = std.find(label, self.keys);
                std.format("USER%02d", idx[0]),
        },
    },
}
