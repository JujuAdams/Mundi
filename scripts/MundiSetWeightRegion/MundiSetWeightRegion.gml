// Feather disable all

/// @param mundi
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param value

function MundiSetWeightRegion(_mundi, _x1, _y1, _x2, _y2, _value)
{
    if (_mundi == undefined) return;
    return _mundi.SetWeightRegion(_x1, _y1, _x2, _y2, _value);
}