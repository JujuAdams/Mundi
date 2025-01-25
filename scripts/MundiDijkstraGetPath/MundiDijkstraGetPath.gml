// Feather disable all

/// @param mundi
/// @param x
/// @param y

function MundiDijkstraGetPath(_mundi, _x, _y)
{
    if (_mundi == undefined) return undefined;
    return _mundi.DijkstraGetPath(_x, _y);
}