#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEFUEL_VALUE;
		_ctrlSlider slidersetposition (fuel _unit * 10);
		_ctrlSlider ctrlenable alive _unit;
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEFUEL_VALUE;
		_fuel = sliderposition _ctrlSlider * 0.1;
		if (abs(fuel _unit - _fuel) < 0.01) exitwith {};
		_curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
		if (local _unit) then {
			{_x setfuel _fuel} forEach _curatorSelected;
		} else {
			[[_curatorSelected, _fuel], {
				_entities = _this select 0;
				_fuel = _this select 1;
				{_x setFuel _fuel} foreach _entities;
			}] remoteExec ["spawn", _unit];
		};
	};
	case "onUnload": {
	};
};