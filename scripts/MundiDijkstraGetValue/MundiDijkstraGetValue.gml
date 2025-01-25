// Feather disable all

/// @param mundi
/// @param x
/// @param y

function MundiDijkstraGetValue(_mundi, _x, _y)
{
    if (_mundi == undefined) return undefined;
    return _mundi.DijkstraGetValue(_x, _y);
}