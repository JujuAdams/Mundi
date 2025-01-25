// Feather disable all

/// @param mundi
/// @param x
/// @param y
/// @param value
/// @param [cloneValue=true]

function MundiSetType(_mundi, _x, _y, _value, _cloneValue = true)
{
    if (_mundi == undefined) return;
    return _mundi.SetType(_x, _y, _value, _cloneValue);
}