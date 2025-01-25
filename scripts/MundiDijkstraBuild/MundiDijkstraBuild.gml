// Feather disable all

/// @param mundi
/// @param x
/// @param y
/// @param range
/// @param costOnEnter

function MundiDijkstraBuild(_mundi, _x, _y, _range, _costOnEnter)
{
    if (_mundi == undefined) return;
    _mundi.DijkstraBuild(_x, _y, _range, _costOnEnter);
}