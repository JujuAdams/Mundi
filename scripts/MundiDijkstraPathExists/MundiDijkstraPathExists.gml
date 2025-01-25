// Feather disable all

/// @param mundi
/// @param x
/// @param y

function MundiDijkstraPathExists(_mundi, _x, _y)
{
    if (_mundi == undefined) return false;
    return _mundi.DijkstraPathExists(_x, _y);
}