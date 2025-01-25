// Feather disable all

/// @param mundi
/// @param x
/// @param y
/// @param cellWidth
/// @parma cellHeight

function MundiDebugDrawDijkstra(_mundi, _x, _y, cellWidth, _cellHeight)
{
    if (_mundi == undefined) return;
    _mundi.DebugDrawDijkstra(_x, _y, cellWidth, _cellHeight);
}