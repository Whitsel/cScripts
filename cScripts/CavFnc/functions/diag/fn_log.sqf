#include "..\script_component.hpp"
/*
 * Author: CPL.Brostrom.A
 *  This function print a formated rpt message.
 *
 * Arguments:
 * 0: message <STRING>
 * 1: componant <STRING>
 * 2: type <STRING>
 * 3: showInChat <BOOL>
 *
 * Example:
 * ["Something is wrong here."] call FUNC(log)
 * [format["%1 is a player.", player]] call FUNC(log)
 *
 */

params [
    ["_message", ""],
    ["_componant", "", [""]],
    ["_showInChat", false, [false]],
    ["_sendToServer", false, [false]],
    ["_type", "LOG", [""]]
];

private _prefix = format ["[%1] ", QUOTE(PREFIX)];

_componant = if ( _componant != "" ) then {format["(%1) ", _componant]} else {""};

_type = format ["%1", _type];

private _logMessage = formatText ["%1%2%3: %4", _prefix, _componant, _type, _message];

diag_log _logMessage;

if (_sendToServer) then {
    [QEGVAR(event,logServer), _logMessage] call CBA_fnc_serverEvent;
};

if (_showInChat && (!isMultiplayer || {is3DENMultiplayer})) then {
    systemChat str _logMessage;
};