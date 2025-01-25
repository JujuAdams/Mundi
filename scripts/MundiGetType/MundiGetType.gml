// Feather disable all

/// @param mundi
/// @param x
/// @param y

function MundiGetType(_mundi, _x, _y)
{
    if (_mundi == undefined) return undefined;
    return _mundi.GetType(_x, _y);
}