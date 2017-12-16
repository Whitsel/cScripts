/*
 * Author: CPL.Brostrom.A
 * Modified by: PVT.Schouten.M
 * This function crates a startercrate.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Example:
 *  this call moduleCreateStarterCrate;
 */

#include "..\script_component.hpp";

params ["_crate","_pos"];

_pos = _this select 0;

private _dialogResult = [
    "7th Cavalry Starter Crate",
    [
        ["Quick Select Scale",["none","alpha","bravo","charlie","ranger","medical","full"],0],
        ["ReGear action",["true","false"],1],
        ["Heal action",["true","false"],0],
        ["Insignia Selection",["true","false"],0],
        ["Supply Size","SLIDER",1],
        ["Require Platoon Variable",["true","false"],1]
    ]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

private _quickSelectScale = switch (_dialogResult select 0) do {
    case 0: {"none";};
    case 1: {"alpha";};
    case 2: {"bravo";};
    case 3: {"charlie";};
    case 4: {"ranger";};
    case 5: {"medical";};

    case 6: {"full";};
};

private _reGearOption = if (_dialogResult select 1 == 0) then {true} else {false};
private _reHealOption = if (_dialogResult select 2 == 0) then {true} else {false};
private _InsigniaSelectOption = if (_dialogResult select 3 == 0) then {true} else {false};
private _supplieSize = _dialogResult select 4;
private _requirePlatoonVariable = if (_dialogResult select 5 == 0) then {true} else {false};

_crate = "B_supplyCrate_F" createVehicle _pos;
[_crate,_quickSelectScale,_reGearOption,_reHealOption,_InsigniaSelectOption,_supplieSize,_requirePlatoonVariable] remoteExec ["cScripts_fnc_doStarterCrate",0,true];