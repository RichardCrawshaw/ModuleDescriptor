#!/bin/sh

# Generate descriptor file for CANMIO-Universal modules.
# Use this script to avoid duplication and reduce maintenance.

# CANXIO is similar to CANMIO but with 24 channels.

# Used to omit trailing comma at end of lists.
ending[0]=',' # False - not end of list, add a comma.
ending[1]=''  # True  - at end of list, omit trailing comma.

cat <<EOF
{
  "generated":"Generated by $0",
  "moduleName":"CANXIO",
  "nodeVariables": [
    {
      "type": "NodeVariableTabs",
      "tabPanels": [
        { "displayTitle": "Globals",
          "items": [
            {
              "type": "NodeVariableSlider",
              "nodeVariableIndex": 1,
              "displayTitle": "Produced startup event Delay",
              "displaySubTitle": "0.1 second steps, starting at 2",
              "displayUnits": "seconds",
              "displayScale": 0.1,
              "displayOffset":2
            },
            {
              "type": "NodeVariableNumber",
              "nodeVariableIndex": 2,
              "displayTitle": "Heartbeat Delay",
              "displaySubTitle": "not yet implemented",
              "displayUnits": "milliseconds"
            },
            {
              "type": "NodeVariableSlider",
              "nodeVariableIndex": 5,
              "displayTitle": "Time delay between response messages",
              "displaySubTitle": "1 millisecond steps",
              "displayUnits": "milliseconds"
            },
            {
              "type": "NodeVariableNumber",
              "nodeVariableIndex": 3,
              "displayTitle": "Multi Servo speed",
              "displaySubTitle": "If >234 moves this amount every 100ms. If <= 234 number of 20ms periods per step",
              "displayUnits": "milliseconds"
            },
            {
              "type": "NodeVariableBitArray",
              "nodeVariableIndex": 6,
              "displayTitle": "Flags",
              "displaySubTitle": "",
              "bitCollection":[
                {"bitPosition": 0, "label": "ch17-24 pullups enabled"}
              ]
            },
            {
              "type": "NodeVariableBitArray",
              "nodeVariableIndex": 4,
              "displayTitle": "PORTB Pullups",
              "displaySubTitle": "",
              "bitCollection":[
                {"bitPosition": 0, "label": "Port B0"},
                {"bitPosition": 1, "label": "Port B1"},
                {"bitPosition": 2, "label": "Port B2"},
                {"bitPosition": 3, "label": "Port B3"},
                {"bitPosition": 4, "label": "Port B4"},
                {"bitPosition": 5, "label": "Port B5"},
                {"bitPosition": 6, "label": "Port B6"},
                {"bitPosition": 7, "label": "Port B7"}
              ]
            }
          ]
        },
EOF

for ch in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
do
    if [ $ch -ge 9 -a $ch -le 24 -a $ch -ne 12 ]
    then
      ioTypes='{"label": "INPUT", "value": 0},
                {"label": "OUTPUT", "value": 1},
                {"label": "SERVO", "value": 2},
                {"label": "BOUNCE", "value": 3},
                {"label": "MULTI", "value": 4},
                {"label": "ANALOGUE", "value": 5},
                {"label": "MAGNET", "value": 6}'
    else
      ioTypes='{"label": "INPUT", "value": 0},
                {"label": "OUTPUT", "value": 1},
                {"label": "SERVO", "value": 2},
                {"label": "BOUNCE", "value": 3},
                {"label": "MULTI", "value": 4}'
    fi
    cat <<EOF
        { "displayTitle": "Channel $ch",
          "items": [
            {
              "type": "NodeVariableSelect",
              "nodeVariableIndex": $((9+$ch*7)),
              "displayTitle": "I/O type",
              "displaySubTitle": "",
              "options": [${ioTypes}]
            },
            {
              "type": "NodeVariableSlider",
              "comment":"input type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 0 },
              "nodeVariableIndex": $((11+$ch*7)),
              "displayTitle": "ON delay",
              "displaySubTitle": "input specific",
              "displayUnits": "milliseconds",
              "displayScale": 5
            },
            {
              "type": "NodeVariableSlider",
              "comment":"output type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 1 },
              "nodeVariableIndex": $((11+$ch*7)),
              "displayTitle": "Pulse duration",
              "displaySubTitle": "output specific",
              "displayUnits": "seconds",
              "displayScale": 0.1
            },
            {
              "type": "NodeVariableSlider",
              "comment":"servo type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 2 },
              "nodeVariableIndex": $((11+$ch*7)),
              "displayTitle": "OFF position",
              "displaySubTitle": "servo specific",
              "displayUnits": "steps",
              "outputOnWrite": true
            },
            {
              "type": "NodeVariableSlider",
              "comment":"bounce type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 3 },
              "nodeVariableIndex": $((11+$ch*7)),
              "displayTitle": "UPPER position",
              "displaySubTitle": "bounce specific",
              "displayUnits": "steps",
              "outputOnWrite": true
            },
            {
              "displayTitle": "number of positions",
              "displaySubTitle": "multi specific",
              "comment":"multi type only",
              "type": "NodeVariableSelect",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 4 },
              "nodeVariableIndex": $((11+$ch*7)),
              "options": [
                {"label": "1 position", "value": 1},
                {"label": "2 positions", "value": 2},
                {"label": "3 positions", "value": 3},
                {"label": "4 positions", "value": 4}
              ]
            },
            {
              "displayTitle": "magnet setup",
              "displaySubTitle": "ADC offset",
              "comment":"magnet type only",
              "type": "NodeVariableSlider",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 6 },
              "nodeVariableIndex": $((11+$ch*7)),
              "displayUnits": "ADC units, in 1.22mV steps"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"input type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 0 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayTitle": "OFF delay",
              "displaySubTitle": "input specific",
              "displayUnits": "milliseconds",
              "displayScale": 5
            },
            {
              "type": "NodeVariableSlider",
              "comment":"output type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 1 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayTitle": "Flash period",
              "displaySubTitle": "output specific",
              "displayUnits": "seconds",
              "displayScale": 0.1
            },
            {
              "type": "NodeVariableSlider",
              "comment":"servo type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 2 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayTitle": "ON position",
              "displaySubTitle": "servo specific",
              "displayUnits": "steps",
              "outputOnWrite": true
            },
            {
              "type": "NodeVariableSlider",
              "comment":"bounce type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 3 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayTitle": "LOWER position",
              "displaySubTitle": "bounce specific",
              "displayUnits": "steps",
              "outputOnWrite": true
            },
            {
              "type": "NodeVariableSlider",
              "comment":"multi type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 4 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayTitle": "pos 1",
              "displaySubTitle": "multi specific",
              "displayUnits": "steps",
              "outputOnWrite": true
            },
            {
              "displayTitle": "Threshold",
              "displaySubTitle": "analog specific",
              "comment":"analog type only",
              "type": "NodeVariableSlider",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 5 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayUnits": "Volts",
              "displayScale": 0.0196
            },
            {
              "displayTitle": "Threshold",
              "displaySubTitle": "magnet specific",
              "comment":"analog type only",
              "type": "NodeVariableSlider",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 6 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayUnits": "ADC units, in 1.22mV steps"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"servo type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 2 },
              "nodeVariableIndex": $((13+$ch*7)),
              "displayTitle": "OFF to ON speed",
              "displaySubTitle": "servo specific",
              "displayUnits": ""
            },
            {
              "type": "NodeVariableSlider",
              "comment":"bounce type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 3 },
              "nodeVariableIndex": $((13+$ch*7)),
              "displayTitle": "Bounce coefficient",
              "displaySubTitle": "bounce specific",
              "displayUnits": " %"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"multi type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 4 },
              "nodeVariableIndex": $((13+$ch*7)),
              "displayTitle": "pos 2",
              "displaySubTitle": "multi specific",
              "displayUnits": "steps",
              "outputOnWrite": true
            },
            {
              "displayTitle": "Hysteresis",
              "displaySubTitle": "analogue specific",
              "comment":"analogue type only",
              "type": "NodeVariableSlider",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 5 },
              "nodeVariableIndex": $((13+$ch*7)),
              "displayUnits": "Volts",
              "displayScale": 0.0196
            },
            {
              "displayTitle": "Hysteresis",
              "displaySubTitle": "magnet specific",
              "comment":"magnet type only",
              "type": "NodeVariableSlider",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 6 },
              "nodeVariableIndex": $((13+$ch*7)),
              "displayUnits": "ADC units, in 1.22mV steps"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"servo type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 2 },
              "nodeVariableIndex": $((14+$ch*7)),
              "displayTitle": "ON to OFF speed",
              "displaySubTitle": "servo specific",
              "displayUnits": ""
            },
            {
              "type": "NodeVariableSlider",
              "comment":"bounce type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 3 },
              "nodeVariableIndex": $((14+$ch*7)),
              "displayTitle": "Pull speed",
              "displaySubTitle": "bounce specific",
              "displayUnits": "milliseconds",
              "displayScale": 20
            },
            {
              "type": "NodeVariableSlider",
              "comment":"multi type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 4 },
              "nodeVariableIndex": $((14+$ch*7)),
              "displayTitle": "pos 3",
              "displaySubTitle": "multi specific",
              "displayUnits": "steps",
              "outputOnWrite": true
            },
            {
              "displayTitle": "Offset H",
              "displaySubTitle": "magnet specific",
              "comment":"magnet type only",
              "type": "NodeVariableSlider",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 6 },
              "nodeVariableIndex": $((14+$ch*7)),
              "displayUnits": "ADC units, in 1.22mV steps"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"bounce type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 3 },
              "nodeVariableIndex": $((15+$ch*7)),
              "displayTitle": "Pull pause",
              "displaySubTitle": "bounce specific",
              "displayUnits": "milliseconds",
              "displayScale": 20
            },
            {
              "type": "NodeVariableSlider",
              "comment":"multi type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 4 },
              "nodeVariableIndex": $((15+$ch*7)),
              "displayTitle": "pos 4",
              "displaySubTitle": "multi specific",
              "displayUnits": "steps",
              "outputOnWrite": true
            },
            {
              "displayTitle": "Offset L",
              "displaySubTitle": "magnet specific",
              "comment":"magnet type only",
              "type": "NodeVariableSlider",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 6 },
              "nodeVariableIndex": $((15+$ch*7)),
              "displayUnits": "ADC units, in 1.22mV steps"
            },
            {
              "type": "NodeVariableBitArray",
              "nodeVariableIndex": $((10+$ch*7)),
              "displayTitle": "Flags",
              "bitCollection":[
                {"bitPosition": 0, "overload":{"nv": $((9+$ch*7)), "labels": [
                      {"value": 0, "label": "TRIGGER_INVERTED"},
                      {"value": 1, "label": "TRIGGER_INVERTED"},
                      {"value": 2, "label": "TRIGGER_INVERTED"},
                      {"value": 3, "label": "TRIGGER_INVERTED"},
                      {"value": 4, "label": "TRIGGER_INVERTED"}
                    ]
                  }
                },
                {"bitPosition": 1, "overload":{"nv": $((9+$ch*7)), "labels": [
                      {"value": 2, "label": "CUTOFF"},
                      {"value": 3, "label": "CUTOFF"},
                      {"value": 4, "label": "CUTOFF"}
                    ]
                  }
                },
                {"bitPosition": 2, "overload":{"nv": $((9+$ch*7)), "labels": [
                      {"value": 1, "label": "STARTUP"},
                      {"value": 2, "label": "STARTUP"},
                      {"value": 3, "label": "STARTUP"},
                      {"value": 4, "label": "STARTUP"}
                    ]
                  }
                },
                {"bitPosition": 3, "overload":{"nv": $((9+$ch*7)), "labels": [
                      {"value": 0, "label": "DISABLE_OFF"},
                      {"value": 1, "label": "DISABLE_OFF"},
                      {"value": 5, "label": "DISABLE_OFF"},
                      {"value": 6, "label": "DISABLE_OFF"}
                    ]
                  }
                },
                {"bitPosition": 4, "overload":{"nv": $((9+$ch*7)), "labels": [
                      {"value": 0, "label": "TOGGLE"},
                      {"value": 2, "label": "PULLUP"},
                      {"value": 3, "label": "PULLUP"},
                      {"value": 4, "label": "PULLUP"}
                    ]
                  }
                },
                {"bitPosition": 5, "overload":{"nv": $((9+$ch*7)), "labels": [
                      {"value": 0, "label": "INPUT_DISABLE_SOD_RESPONSE"},
                      {"value": 1, "label": "ACTION_INVERTED"},
                      {"value": 2, "label": "ACTION_INVERTED"},
                      {"value": 3, "label": "ACTION_INVERTED"},
                      {"value": 4, "label": "ACTION_INVERTED"},
                      {"value": 5, "label": "INPUT_DISABLE_SOD_RESPONSE"},
                      {"value": 6, "label": "INPUT_DISABLE_SOD_RESPONSE"}
                    ]
                  }
                },
                {"bitPosition": 6, "label": "EVENT_INVERTED"},
                {"bitPosition": 7, "overload":{"nv": $((9+$ch*7)), "labels": [
                      {"value": 1, "label": "ACTION_EXPEDITED"},
                      {"value": 2, "label": "EXTENDED 180 DEGREE RANGE"},
                      {"value": 3, "label": "EXTENDED 180 DEGREE RANGE"},
                      {"value": 4, "label": "EXTENDED 180 DEGREE RANGE"}
                    ]
                  }
                }
              ]
            }
          ],
          "comment":"end of channel $ch"
        }${ending[$(($ch == 24))]}
EOF
done

cat <<EOF
      ]
    }
  ],
  "eventVariables": [
    {
      "type": "EventVariableSelect",
      "eventVariableIndex": 1,
      "displayTitle": "Produced event",
      "displaySubTitle": "EV1",
      "options": [
        {"value": 0, "label": "no event (0)"},
        {"value": 1, "label": "Startup event (1)"},
EOF

for ch in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
    cat <<EOF
        {"value": $((4+$ch*4)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 0, "label": "CH$ch - Input Changed"},
              {"value": 1, "label": "CH$ch - Output Changed"},
              {"value": 2, "label": "CH$ch - Reached OFF"},
              {"value": 3, "label": "CH$ch - Output Changed"},
              {"value": 4, "label": "CH$ch - AT1"},
              {"value": 5, "label": "CH$ch - Threshold"},
              {"value": 6, "label": "CH$ch - Lower Threshold"}
            ]
          }
        },
        {"value": $((5+$ch*4)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 0, "label": "CH$ch - TWO_ON"},
              {"value": 2, "label": "CH$ch - Reached MID"},
              {"value": 4, "label": "CH$ch - AT2"},
              {"value": 6, "label": "CH$ch - Upper Threshold"}
            ]
          }
        },
        {"value": $((6+$ch*4)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 2, "label": "CH$ch - Reached ON"},
              {"value": 4, "label": "CH$ch - AT3"}
            ]
          }
        },
        {"value": $((7+$ch*4)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 4, "label": "CH$ch - AT4"}
            ]
          }
        }${ending[$(($ch == 16))]}
EOF
done

cat <<EOF
      ],
      "comment":"end of EV1"
    },
EOF

for ev in 2 3 4 5 6 7 8
do
    cat <<EOF
    {
      "type": "EventVariableSelect",
      "eventVariableIndex": $ev,
      "displayTitle": "Consumed event",
      "displaySubTitle": "EV$ev",
      "options": [
        {"value": 0, "label": "no action"},
        {"value": 1, "label": "Consumed SOD"},
        {"value": 2, "label": "WAIT05"},
        {"value": 3, "label": "WAIT1"},
        {"value": 4, "label": "WAIT2"},
        {"value": 5, "label": "WAIT5"},
EOF

for ch in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
    cat <<EOF
        {"value": $((3+$ch*5)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 1, "label": "CH$ch - Change"},
              {"value": 2, "label": "CH$ch - Change"},
              {"value": 3, "label": "CH$ch - Change"},
              {"value": 4, "label": "CH$ch - AT1"}
            ]
          }
        },
        {"value": $((4+$ch*5)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 1, "label": "CH$ch - ON"},
              {"value": 2, "label": "CH$ch - ON"},
              {"value": 3, "label": "CH$ch - ON"},
              {"value": 4, "label": "CH$ch - AT2"}
            ]
          }
        },
        {"value": $((5+$ch*5)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 1, "label": "CH$ch - OFF"},
              {"value": 2, "label": "CH$ch - OFF"},
              {"value": 3, "label": "CH$ch - OFF"},
              {"value": 4, "label": "CH$ch - AT3"}
            ]
          }
        },
        {"value": $((6+$ch*5)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 1, "label": "CH$ch - FLASH"},
              {"value": 4, "label": "CH$ch - AT4"}
            ]
          }
        },
        {"value": $((7+$ch*5)), "overload":{"nv": $((9+$ch*7)), "labels": [
              {"value": 1, "label": "CH$ch - !Change"},
              {"value": 2, "label": "CH$ch - !Change"},
              {"value": 3, "label": "CH$ch - !Change"}
            ]
          }
        }${ending[$(($ch == 16))]}
EOF
done

cat <<EOF
      ],
      "comment":"end of EV$ev"
    }${ending[$(($ev == 8))]}
EOF
done # ev

cat <<EOF
  ]
}
EOF
