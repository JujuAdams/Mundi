// Feather disable all

/// @param mundi
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param value
/// @param [cloneValue=true]

function MundiSetTypeRegion(_mundi, _x1, _y1, _x2, _y2, _value, _cloneValue = true)
{
    if (_mundi == undefined) return;
    return _mundi.SetTypeRegion(_x1, _y1, _x2, _y2, _value, _cloneValue);
}