// Feather disable all

/// @param mundi
/// @param x
/// @param y
/// @param value

function MundiSetWeight(_mundi, _x, _y, _value)
{
    if (_mundi == undefined) return;
    return _mundi.SetWeight(_x, _y, _value);
}