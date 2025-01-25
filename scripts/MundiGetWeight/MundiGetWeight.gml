// Feather disable all

/// @param mundi
/// @param x
/// @param y

function MundiGetWeight(_mundi, _x, _y)
{
    if (_mundi == undefined) return;
    return _mundi.GetWeight(_x, _y);
}