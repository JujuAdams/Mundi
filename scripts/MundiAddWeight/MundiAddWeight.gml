// Feather disable all

/// @param mundi
/// @param x
/// @param y
/// @param value

function MundiAddWeight(_mundi, _x, _y, _value)
{
    if (_mundi == undefined) return;
    return _mundi.AddWeight(_x, _y, _value);
}