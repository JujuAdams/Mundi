// Feather disable all

/// @param mundi
/// @param x
/// @param y
/// @param cellWidth
/// @parma cellHeight

function MundiDebugDrawTypes(_mundi, _x, _y, cellWidth, _cellHeight)
{
    if (_mundi == undefined) return;
    _mundi.DebugDrawTypes(_x, _y, cellWidth, _cellHeight);
}