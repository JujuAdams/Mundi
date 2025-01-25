// Feather disable all

/// @param path
/// @param xOffset
/// @param yOffset
/// @param cellWidth
/// @param cellHeight

function MundiDebugDrawPath(_path, _xOffset, _yOffset, _cellWidth, _cellHeight)
{
    if (not is_array(_path)) return;
    
    var _i = 0;
    repeat(array_length(_path) div 3)
    {
        var _x = _path[_i];
        var _y = _path[_i+1];
        //var _range = _path[_i+2];
        
        draw_rectangle(_x*_cellWidth + _xOffset, _y*_cellHeight + _yOffset, (_x+1)*_cellWidth - 1 + _xOffset, (_y+1)*_cellHeight - 1 + _yOffset, false);
        
        _i += 3;
    }
}