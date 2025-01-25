// Feather disable all

/// @param mundi
/// @param x
/// @param y
/// @param cellWidth
/// @parma cellHeight

function MundiDebugDrawWeights(_mundi, _x, _y, cellWidth, _cellHeight)
{
    if (_mundi == undefined) return;
    _mundi.DebugDrawWeights(_x, _y, cellWidth, _cellHeight);
}