#!/bin/sh

# Generate descriptor file for CANMIO-Universal modules.
# Use this script to avoid duplication and reduce maintenance.

cat <<EOF
{
  "moduleName":"CANLEVER",
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
              "displayTitle": "Servo speed",
              "displaySubTitle": "If >234 MULTI servo is moved this amount every 100ms. If <= 234 this is number of 20ms periods per step",
              "displayUnits": "milliseconds"
            },
            {
              "type": "NodeVariableNumber",
              "nodeVariableIndex": 6,
              "displayTitle": "Event number offset",
              "displaySubTitle": ""
            }
          ]
        },
EOF

first=t
for ch in 1 2 3 4
do
    if [ "$first" != "t" ]
    then
        cat <<EOF
        },
EOF
    else
        first="f"
    fi
    
    cat <<EOF
        { "displayTitle": "CH $ch",
          "items": [
            { 
              "type": "NodeVariableGroup",
              "displayTitle": "Dedicated lever channel $ch",
              "groupItems": [
                {
                  "type": "NodeVariableSelect",
                  "comment":"lever type only",
                  "nodeVariableIndex": $((11+$ch*7)),
                  "displayTitle": "Valid Positions",
                  "displaySubTitle": "",
                  "options": [
                    {"label": "No LEVER", "value": 0},
                    {"label": "Spare LEVER", "value": 1},
                    {"label": "Two positions", "value": 2},
                    {"label": "Three positions", "value": 3}
                  ]
                },
                {
                  "type": "NodeVariableSelect",
                  "comment":"lever type only",
                  "nodeVariableIndex": $((12+$ch*7)),
                  "displayTitle": "Locking Method",
                  "displaySubTitle": "",
                  "options": [
                    {"label": "No locking", "value": 0},
                    {"label": "Virtual locking", "value": 1},
                    {"label": "Mechanical locking", "value": 2}
                  ]
                },
                {
                  "type": "NodeVariableNumber",
                  "comment":"lever type only",
                  "nodeVariableIndex": $((13+$ch*7)),
                  "displayTitle": "Int action forward",
                  "displaySubTitle": ""
                },
                {
                  "type": "NodeVariableNumber",
                  "comment":"lever type only",
                  "nodeVariableIndex": $((14+$ch*7)),
                  "displayTitle": "Int action back",
                  "displaySubTitle": ""
                },
                {
                  "type": "NodeVariableNumber",
                  "comment":"lever type only",
                  "nodeVariableIndex": $((15+$ch*7)),
                  "displayTitle": "Int action centre",
                  "displaySubTitle": ""
                },
                {
                  "type": "NodeVariableBitArray",
                  "nodeVariableIndex": $((10+$ch*7)),
                  "displayTitle": "Flags",
                  "bitCollection":[
                    {"bitPosition": 0, "label": "TRIGGER_INVERTED"},
                    {"bitPosition": 3, "label": "DISABLE_OFF"},
                    {"bitPosition": 5, "label": "DISABLE_SOD"},
                    {"bitPosition": 6, "label": "EVENT_INVERTED"}
                  ]
                }
              ]
            }
          ],
          "comment":"end of channel $ch"
EOF
done




first=t
for ch in 5 6 7 8
do
        cat <<EOF
        },
    
        { "displayTitle": "CH $ch",
          "items": [
            { 
              "type": "NodeVariableGroup",
              "displayTitle": "Dedicated lock channel $ch",
              "groupItems": [
                {
                  "type": "NodeVariableSelect",
                  "comment":"lock type only",
                  "nodeVariableIndex": $((11+$ch*7)),
                  "displayTitle": "Function gate 1",
                  "displaySubTitle": "",
                  "options": [
                    {"label": "Unused", "value": 0},
                    {"label": "BUFFER", "value": 1},
                    {"label": "NOT", "value": 2},
                    {"label": "AND", "value": 3},
                    {"label": "NAND", "value": 4},
                    {"label": "OR", "value": 5},
                    {"label": "NOR", "value": 6},
                    {"label": "XOR", "value": 7},
                    {"label": "XNOR", "value": 8},
                    {"label": "ANDOR44", "value": 9},
                    {"label": "ANDNOR44", "value": 10},
                    {"label": "ANDOR332", "value": 11},
                    {"label": "ANDNOR332", "value": 12},
                    {"label": "ANDOR2222", "value": 13},
                    {"label": "ANDNOR2222", "value": 14},
                    {"label": "ORAND44", "value": 15},
                    {"label": "ORNAND44", "value": 16},
                    {"label": "ORAND332", "value": 17},
                    {"label": "ORNANDAND332", "value": 18},
                    {"label": "ORAND2222", "value": 19},
                    {"label": "ORNAND2222", "value": 20}
                  ]
                },
                {
                  "type": "NodeVariableBitArray",
                  "nodeVariableIndex": $((12+$ch*7)),
                  "displayTitle": "input mask gate 1",
                  "bitCollection":[
                    {"bitPosition": 0, "label": "Input 1"},
                    {"bitPosition": 1, "label": "Input 2"},
                    {"bitPosition": 2, "label": "Input 3"},
                    {"bitPosition": 3, "label": "Input 4"},
                    {"bitPosition": 4, "label": "Input 5"},
                    {"bitPosition": 5, "label": "Input 6"},
                    {"bitPosition": 6, "label": "Input 7"},
                    {"bitPosition": 7, "label": "Input 8"}
                  ]
                },
                {
                  "type": "NodeVariableSelect",
                  "comment":"lock type only",
                  "nodeVariableIndex": $((13+$ch*7)),
                  "displayTitle": "Function gate 5",
                  "options": [
                    {"label": "Unused", "value": 0},
                    {"label": "BUFFER", "value": 1},
                    {"label": "NOT", "value": 2},
                    {"label": "AND", "value": 3},
                    {"label": "NAND", "value": 4},
                    {"label": "OR", "value": 5},
                    {"label": "NOR", "value": 6},
                    {"label": "XOR", "value": 7},
                    {"label": "XNOR", "value": 8},
                    {"label": "ANDOR44", "value": 9},
                    {"label": "ANDNOR44", "value": 10},
                    {"label": "ANDOR332", "value": 11},
                    {"label": "ANDNOR332", "value": 12},
                    {"label": "ANDOR2222", "value": 13},
                    {"label": "ANDNOR2222", "value": 14},
                    {"label": "ORAND44", "value": 15},
                    {"label": "ORNAND44", "value": 16},
                    {"label": "ORAND332", "value": 17},
                    {"label": "ORNANDAND332", "value": 18},
                    {"label": "ORAND2222", "value": 19},
                    {"label": "ORNAND2222", "value": 20}
                  ]
                },
                {
                  "type": "NodeVariableBitArray",
                  "comment":"lock type only",
                  "nodeVariableIndex": $((14+$ch*7)),
                  "displayTitle": "input mask gate 5",
                  "displaySubTitle": "NV1",
                  "bitCollection":[
                    {"bitPosition": 0, "label": "Input 1"},
                    {"bitPosition": 1, "label": "Input 2"},
                    {"bitPosition": 2, "label": "Input 3"},
                    {"bitPosition": 3, "label": "Input 4"},
                    {"bitPosition": 4, "label": "Input 5"},
                    {"bitPosition": 5, "label": "Input 6"},
                    {"bitPosition": 6, "label": "Input 7"},
                    {"bitPosition": 7, "label": "Input 8"}
                  ]
                },
                {
                  "type": "NodeVariableNumber",
                  "comment":"lever type only",
                  "nodeVariableIndex": $((15+$ch*7)),
                  "displayTitle": "Int action gate 5",
                  "displaySubTitle": ""
                },
                {
                  "type": "NodeVariableBitArray",
                  "nodeVariableIndex": $((10+$ch*7)),
                  "displayTitle": "Flags",
                  "bitCollection":[
                    {"bitPosition": 0, "label": "TRIGGER_INVERTED"},
                    {"bitPosition": 3, "label": "DISABLE_OFF"},
                    {"bitPosition": 5, "label": "DISABLE_SOD"},
                    {"bitPosition": 6, "label": "EVENT_INVERTED"},
                    {"bitPosition": 7, "label": "INTERNAL_ACTION"}
                  ]
                }
              ]
            }
          ],
          "comment":"end of channel $ch"
EOF
done


first=t
for ch in 9 10 11 12
do
        cat <<EOF
        },

        { "displayTitle": "CH $ch",
          "items": [
            {
              "type": "NodeVariableSelect",
              "nodeVariableIndex": $((9+$ch*7)),
              "displayTitle": "I/O type",
              "displaySubTitle": "",
              "options": [
              {"label": "INPUT", "value": 0},
              {"label": "OUTPUT", "value": 1},
              {"label": "SERVO", "value": 2},
              {"label": "BOUNCE", "value": 3},
              {"label": "MULTI", "value": 4}
              ]
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
              "displayUnits": "steps"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"bounce type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 3 },
              "nodeVariableIndex": $((11+$ch*7)),
              "displayTitle": "UPPER position",
              "displaySubTitle": "bounce specific",
              "displayUnits": "steps"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"multi type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 4 },
              "nodeVariableIndex": $((11+$ch*7)),
              "displayTitle": "num pos",
              "displaySubTitle": "multi specific",
              "displayUnits": "steps"
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
              "displayUnits": "steps"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"bounce type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 3 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayTitle": "LOWER position",
              "displaySubTitle": "bounce specific",
              "displayUnits": "steps"
            },
            {
              "type": "NodeVariableSlider",
              "comment":"multi type only",
              "visibilityLogic":{ "nv":$((9+$ch*7)), "equals": 4 },
              "nodeVariableIndex": $((12+$ch*7)),
              "displayTitle": "pos 1",
              "displaySubTitle": "multi specific",
              "displayUnits": "steps"
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
              "displayUnits": "steps"
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
              "displayUnits": "steps"
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
              "displayUnits": "steps"
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
                      {"value": 1, "label": "DISABLE_OFF"}
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
                      {"value": 4, "label": "ACTION_INVERTED"}
                    ]
                  }
                },
                {"bitPosition": 6, "label": "EVENT_INVERTED"},
                {"bitPosition": 7, "overload":{"nv": $((9+$ch*7)), "labels": [
                      {"value": 1, "label": "ACTION_EXPEDITED"}
                    ]
                  }
                }
              ]
            }
          ],
          "comment":"end of channel $ch"
EOF
done

first=t
for ch in 15
do
        cat <<EOF
        },
    
        { "displayTitle": "CH $ch",
          "items": [
            { 
              "type": "NodeVariableGroup",
              "displayTitle": "Lock control channel $ch",
              "groupItems": [
                {
                  "type": "NodeVariableBitArray",
                  "nodeVariableIndex": $((10+$ch*7)),
                  "displayTitle": "Flags",
                  "bitCollection":[
                    {"bitPosition": 3, "label": "DISABLE_OFF"},
                    {"bitPosition": 5, "label": "DISABLE_SOD"},
                    {"bitPosition": 6, "label": "EVENT_INVERTED"}
                  ]
                }
              ]
            }
          ],
          "comment":"end of channel $ch"
EOF
done

cat <<EOF
        }
      ]
    },
    {"comment":"end of node variables"}
  ],
  "comment":"start of event variables"
EOF
cat <<EOF
}
EOF
