#include "..\script_component.hpp"
/*
 * Author: CPL.Brostrom.A
 * This function return a funtion icon path or path provided.
 *
 * Arguments:
 * nothing
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call cScripts_fnc_clearRadioIds
 *
 */

private _playerRadios = [] call acre_api_fnc_getCurrentRadioList;

{
    private _base = [_x] call acre_api_fnc_getBaseRadio;
    player removeItem _x;
    player addItem _base;
} forEach _playerRadios;

[{[player] call EGVAR(gear,setupRadios);}] call CBA_fnc_execNextFrame;

"Your radios have been reset" call CBA_fnc_notify;
[format["%1: Your radios have been reset", name player], "ACRE", true] call FUNC(info);