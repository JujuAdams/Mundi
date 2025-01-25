// Feather disable all

/// @param width
/// @param height

function __MundiClass(_width, _height) constructor
{
    __width  = _width;
    __height = _height;
    
    __weightGrid = ds_grid_create(_width, _height);
    ds_grid_clear(__weightGrid, MUNDI_MINIMUM_WEIGHT);
    
    __typeGrid   = ds_grid_create(_width, _height);
    ds_grid_clear(__typeGrid, undefined);
    
    __dijkstraGrid = ds_grid_create(_width, _height);
    ds_grid_clear(__dijkstraGrid, -1);
    
    __dijkstraExists = false;
    __dijkstraCellArray = [];
    __dijkstraX = undefined;
    __dijkstraY = undefined;
    
    
    
    
    
    Destroy = function()
    {
        Destroy = function() {}
        Exists = function() { return false; }
    }
    
    Exists = function()
    {
        return true;
    }
    
    Duplicate = function()
    {
        var _new = new __MundiClass(__width, __height);
        
        ds_grid_copy(__weightGrid, _new.__weightGrid);
        ds_grid_copy(__typeGrid, _new.__typeGrid);
        
        return _new;
    }
    
    GetWidth = function()
    {
        return __width;
    }
    
    GetHeight = function()
    {
        return __height;
    }
    
    SetWidth = function(_width)
    {
        __width = _width;
        
        ds_grid_resize(__weightGrid, __width, __height);
        ds_grid_clear(__weightGrid, MUNDI_MINIMUM_WEIGHT);
        
        ds_grid_resize(__typeGrid, __width, __height);
        ds_grid_clear(__typeGrid, undefined);
        
        ds_grid_resize(__dijkstraGrid, __width, __height);
        DijkstraClear();
    }
    
    SetHeight = function(_height)
    {
        __height = _height;
        
        ds_grid_resize(__weightGrid, __width, __height);
        ds_grid_clear(__weightGrid, MUNDI_MINIMUM_WEIGHT);
        
        ds_grid_resize(__typeGrid, __width, __height);
        ds_grid_clear(__typeGrid, undefined);
        
        ds_grid_resize(__dijkstraGrid, __width, __height);
        DijkstraClear();
    }
    
    
    
    #region Weight
    
    GetWeight = function(_x, _y)
    {
        if ((_x < 0) || (_x >= __width) || (_y < 0) || (_y >= __height))
        {
            return undefined;
        }
        
        return __weightGrid[# _x, _y];
    }
    
    SetWeight = function(_x, _y, _value)
    {
        if ((_x < 0) || (_x >= __width) || (_y < 0) || (_y >= __height)) return;
        
        __weightGrid[# _x, _y] = max(MUNDI_MINIMUM_WEIGHT, _value);
    }
    
    SetWeightRegion = function(_x1, _y1, _x2, _y2, _value)
    {
        _value = max(MUNDI_MINIMUM_WEIGHT, _value);
        
        var _xMin = min(_x1, _x2);
        var _xMax = max(_x1, _x2);
        var _yMin = min(_y1, _y2);
        var _yMax = max(_y1, _y2);
        
        if ((_xMax < 0) || (_xMin >= __width) || (_yMax < 0) || (_yMin >= __height)) return;
        
        _xMin = clamp(_xMin, 0, __width-1);
        _xMax = clamp(_xMax, 0, __height-1);
        _yMin = clamp(_yMin, 0, __width-1);
        _yMax = clamp(_yMax, 0, __height-1);
        
        ds_grid_set_region(__weightGrid, _x1, _y1, _x2, _y2, _value);
    }
    
    AddWeight = function(_x, _y, _value)
    {
        if ((_x < 0) || (_x >= __width) || (_y < 0) || (_y >= __height)) return;
        
        __weightGrid[# _x, _y] = max(MUNDI_MINIMUM_WEIGHT, __weightGrid[# _x, _y] + _value);
    }
    
    AddWeightRegion = function(_x1, _y1, _x2, _y2, _value)
    {
        var _xMin = min(_x1, _x2);
        var _xMax = max(_x1, _x2);
        var _yMin = min(_y1, _y2);
        var _yMax = max(_y1, _y2);
        
        if ((_xMax < 0) || (_xMin >= __width) || (_yMax < 0) || (_yMin >= __height)) return;
        
        _xMin = clamp(_xMin, 0, __width-1);
        _xMax = clamp(_xMax, 0, __height-1);
        _yMin = clamp(_yMin, 0, __width-1);
        _yMax = clamp(_yMax, 0, __height-1);
        
        if ((_value < 0) && (ds_grid_get_min(__weightGrid, _x1, _y1, _x2, _y2) + _value < MUNDI_MINIMUM_WEIGHT))
        {
            var _grid = __weightGrid;
            
            var _y = 0;
            repeat(1 + _yMax - _yMin)
            {
                var _x = 0;
                repeat(1 + _xMax - _xMin)
                {
                    _grid[# _x, _y] = max(MUNDI_MINIMUM_WEIGHT, _grid[# _x, _y] + _value);
                    ++_x;
                }
                
                ++_y;
            }
        }
        else
        {
            ds_grid_add_region(__weightGrid, _x1, _y1, _x2, _y2, _value);
        }
    }
    
    ClearWeight = function(_value)
    {
        ds_grid_clear(__weightGrid, max(MUNDI_MINIMUM_WEIGHT, _value));
    }
    
    #endregion
    
    
    
    #region Type
    
    GetType = function(_x, _y)
    {
        if ((_x < 0) || (_x >= __width) || (_y < 0) || (_y >= __height))
        {
            return undefined;
        }
        
        return __typeGrid[# _x, _y];
    }
    
    SetType = function(_x, _y, _value, _cloneValue = true)
    {
        if ((_x < 0) || (_x >= __width) || (_y < 0) || (_y >= __height)) return;
        
        __typeGrid[# _x, _y] = _cloneValue? variable_clone(_value) : _value;
    }
    
    SetTypeRegion = function(_x1, _y1, _x2, _y2, _value, _cloneValue = true)
    {
        var _xMin = min(_x1, _x2);
        var _xMax = max(_x1, _x2);
        var _yMin = min(_y1, _y2);
        var _yMax = max(_y1, _y2);
        
        if ((_xMax < 0) || (_xMin >= __width) || (_yMax < 0) || (_yMin >= __height)) return;
        
        _xMin = clamp(_xMin, 0, __width-1);
        _xMax = clamp(_xMax, 0, __height-1);
        _yMin = clamp(_yMin, 0, __width-1);
        _yMax = clamp(_yMax, 0, __height-1);
        
        var _grid = __typeGrid;
        
        if (_cloneValue)
        {
            var _y = 0;
            repeat(1 + _yMax - _yMin)
            {
                var _x = 0;
                repeat(1 + _xMax - _xMin)
                {
                    _grid[# _x, _y] = variable_clone(_value);
                    ++_x;
                }
                
                ++_y;
            }
        }
        else
        {
            var _y = 0;
            repeat(1 + _yMax - _yMin)
            {
                var _x = 0;
                repeat(1 + _xMax - _xMin)
                {
                    _grid[# _x, _y] = _value;
                    ++_x;
                }
                
                ++_y;
            }
        }
    }
    
    SetWeightForType = function(_type, _value)
    {
        _value = max(MUNDI_MINIMUM_WEIGHT, _value);
        
        var _weightGrid = __weightGrid;
        var _typeGrid   = __typeGrid;
        
        var _y = 0;
        repeat(__height)
        {
            var _x = 0;
            repeat(__width)
            {
                if (_typeGrid[# _x, _y] == _type)
                {
                    _weightGrid[# _x, _y] = _weight;
                }
                
                ++_x;
            }
            
            ++_y;
        }
    }
    
    AddWeightForType = function(_type, _weight)
    {
        var _weightGrid = __weightGrid;
        var _typeGrid   = __typeGrid;
        
        var _y = 0;
        repeat(__height)
        {
            var _x = 0;
            repeat(__width)
            {
                if (_typeGrid[# _x, _y] == _type)
                {
                    _weightGrid[# _x, _y] = max(MUNDI_MINIMUM_WEIGHT, _weightGrid[# _x, _y] + _weight);
                }
                
                ++_x;
            }
            
            ++_y;
        }
    }
    
    ClearType = function(_value)
    {
        ds_grid_clear(__typeGrid, _value);
    }
    
    #endregion
    
    
    
    #region Dijkstra
    
    DijkstraClear = function()
    {
        __dijkstraExists = false;
        
        ds_grid_clear(__dijkstraGrid, -1);
        __dijkstraCellArray = [];
        
        __dijkstraX = undefined;
        __dijkstraY = undefined;
    }
    
    DijkstraExists = function()
    {
        return __dijkstraExists;
    }
    
    DijkstraGetX = function()
    {
        return __dijkstraX;
    }
    
    DijkstraGetY = function()
    {
        return __dijkstraY;
    }
    
    DijkstraBuild = function(_originX, _originY, _originRange, _costOnEnter)
    {
        static _visitedMap = ds_map_create();
        static _visitedArray = [];
        
        if (__dijkstraExists) DijkstraClear();
        
        __dijkstraExists = true;
        
        __dijkstraX = _originX;
        __dijkstraY = _originY;
        
        var _wMinusOne = __width-1;
        var _hMinusOne = __height-1;
        
        if ((_originX < 0) || (_originX > _wMinusOne) || (_originY < 0) || (_originY > _hMinusOne)) return;
        
        var _weightGrid        = __weightGrid;
        var _dijkstraGrid      = __dijkstraGrid;
        var _dijkstraCellArray = __dijkstraCellArray;
        
        var _openArray = [_originX, _originY, _originRange];
        
        if (_costOnEnter)
        {
            while(array_length(_openArray) > 0)
            {
                var _x     = array_shift(_openArray);
                var _y     = array_shift(_openArray);
                var _range = array_shift(_openArray);
                
                var _existing = _dijkstraGrid[# _x, _y];
                if (_existing < _range)
                {
                    _dijkstraGrid[# _x, _y] = _range;
                    _visitedMap[? (_y << 32) | _x] = _range;
                    
                    if (_x > 0)
                    {
                        var _newRange = _range - _weightGrid[# _x-1, _y];
                        if (_dijkstraGrid[# _x-1, _y] < _newRange)
                        {
                            array_push(_openArray, _x-1, _y, _newRange);
                        }
                    }
                    
                    if (_y > 0)
                    {
                        var _newRange = _range - _weightGrid[# _x, _y-1];
                        if (_dijkstraGrid[# _x, _y-1] < _newRange)
                        {
                            array_push(_openArray, _x, _y-1, _newRange);
                        }
                    }
                    
                    if (_x < _wMinusOne)
                    {
                        var _newRange = _range - _weightGrid[# _x+1, _y];
                        if (_dijkstraGrid[# _x+1, _y] < _newRange)
                        {
                            array_push(_openArray, _x+1, _y, _newRange);
                        }
                    }
                    
                    if (_y < _hMinusOne)
                    {
                        var _newRange = _range - _weightGrid[# _x, _y+1];
                        if (_dijkstraGrid[# _x, _y+1] < _newRange)
                        {
                            array_push(_openArray, _x, _y+1, _newRange);
                        }
                    }
                }
            }
        }
        else
        {
            while(array_length(_openArray) > 0)
            {
                var _x     = array_shift(_openArray);
                var _y     = array_shift(_openArray);
                var _range = array_shift(_openArray);
                
                var _existing = _dijkstraGrid[# _x, _y];
                if (_existing < _range)
                {
                    var _weight = _weightGrid[# _x, _y];
                    if (_weight <= _originRange)
                    {
                        _dijkstraGrid[# _x, _y] = _range;
                        _visitedMap[? (_y << 32) | _x] = _range;
                        
                        var _newRange = _range - _weight;
                        if ((_x > 0) && (_dijkstraGrid[# _x-1, _y] < _newRange))
                        {
                            array_push(_openArray, _x-1, _y, _newRange);
                        }
                        
                        if ((_y > 0) && (_dijkstraGrid[# _x, _y-1] < _newRange))
                        {
                            array_push(_openArray, _x, _y-1, _newRange);
                        }
                        
                        if ((_x < _wMinusOne) && (_dijkstraGrid[# _x+1, _y] < _newRange))
                        {
                            array_push(_openArray, _x+1, _y, _newRange);
                        }
                        
                        if ((_y < _hMinusOne) && (_dijkstraGrid[# _x, _y+1] < _newRange))
                        {
                            array_push(_openArray, _x, _y+1, _newRange);
                        }
                    }
                }
            }
        }
        
        ds_map_keys_to_array(_visitedMap, _visitedArray);
        array_sort(_visitedArray, true);
        
        var _i = 0;
        repeat(array_length(_visitedArray))
        {
            var _xy = _visitedArray[_i];
            array_push(_dijkstraCellArray, (_xy & 0xFFFFFFFF), (_xy >> 32), _visitedMap[? _xy]);
            ++_i;
        }
        
        ds_map_clear(_visitedMap);
        array_resize(_visitedArray, 0);
        
        return _dijkstraCellArray;
    }
    
    DijkstraGetCells = function()
    {
        return __dijkstraCellArray;
    }
    
    DijkstraGetPath = function(_originX, _originY)
    {
        var _value = __dijkstraGrid[# _originX, _originY];
        
        if ((not __dijkstraExists) || (_value < 0)) return undefined;
        
        var _dijkstraGrid = __dijkstraGrid;
        
        var _wMinusOne = __width-1;
        var _hMinusOne = __height-1;
        
        var _destinationX = __dijkstraX;
        var _destinationY = __dijkstraY;
        
        var _x = _originX;
        var _y = _originY;
        var _pathArray = [];
        
        var _flipflop = false;
        while(true)
        {
            array_insert(_pathArray, 0, _x, _y, _value);
            
            if ((_x == _destinationX) && (_y == _destinationY))
            {
                break;
            }
            
            var _lowestValue = _value;
            var _lowestX     = undefined;
            var _lowestY     = undefined;
            
            //Use a flipflop to try to create nicer looking diagonal paths
            repeat(2)
            {
                if (_flipflop)
                {
                    _flipflop = false;
                    
                    if (_x > 0)
                    {
                        var _newValue = _dijkstraGrid[# _x-1, _y];
                        if (_newValue > _lowestValue)
                        {
                            _lowestValue = _newValue;
                            _lowestX     = _x-1;
                            _lowestY     = _y;
                        }
                    }
                    
                    if (_x < _wMinusOne)
                    {
                        var _newValue = _dijkstraGrid[# _x+1, _y];
                        if (_newValue > _lowestValue)
                        {
                            _lowestValue = _newValue;
                            _lowestX     = _x+1;
                            _lowestY     = _y;
                        }
                    }
                }
                else
                {
                    _flipflop = true;
                    
                    if (_y > 0)
                    {
                        var _newValue = _dijkstraGrid[# _x, _y-1];
                        if (_newValue > _lowestValue)
                        {
                            _lowestValue = _newValue;
                            _lowestX     = _x;
                            _lowestY     = _y-1;
                        }
                    }
                    
                    if (_y < _hMinusOne)
                    {
                        var _newValue = _dijkstraGrid[# _x, _y+1];
                        if (_newValue > _lowestValue)
                        {
                            _lowestValue = _newValue;
                            _lowestX     = _x;
                            _lowestY     = _y+1;
                        }
                    }
                }
            }
            
            _flipflop = not _flipflop;
            
            if (_lowestX != undefined)
            {
                _x     = _lowestX;
                _y     = _lowestY;
                _value = _lowestValue;
            }
            else
            {
                break;
            }
        }
        
        return _pathArray;
    }
    
    DijkstraPathExists = function(_x, _y)
    {
        return (__dijkstraExists && (__dijkstraGrid[# _x, _y] >= 0));
    }
    
    DijkstraGetValue = function(_x, _y)
    {
        if ((_x < 0) || (_x >= __width) || (_y < 0) || (_y >= __height)) return -1;
        
        return __dijkstraGrid[# _x, _y];
    }
    
    #endregion
    
    DebugDrawWeights = function(_xOffset, _yOffset, _cellWidth, _cellHeight)
    {
        return __DebugDrawGrid(__weightGrid, _xOffset, _yOffset, _cellWidth, _cellHeight);
    }
    
    DebugDrawTypes = function(_xOffset, _yOffset, _cellWidth, _cellHeight)
    {
        return __DebugDrawGrid(__typeGrid, _xOffset, _yOffset, _cellWidth, _cellHeight);
    }
    
    DebugDrawDijkstra = function(_xOffset, _yOffset, _cellWidth, _cellHeight)
    {
        return __DebugDrawGrid(__dijkstraGrid, _xOffset, _yOffset, _cellWidth, _cellHeight);
    }
    
    __DebugDrawGrid = function(_grid, _xOffset, _yOffset, _cellWidth, _cellHeight)
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        var _y = 0;
        repeat(__height)
        {
            var _x = 0;
            repeat(__width)
            {
                draw_rectangle(_x*_cellWidth + _xOffset, _y*_cellHeight + _yOffset, (_x+1)*_cellWidth-1 + _xOffset, (_y+1)*_cellHeight-1 + _yOffset, true);
                draw_text((_x+0.5)*_cellWidth + _xOffset, (_y+0.5)*_cellHeight + _yOffset, string(_grid[# _x, _y]));
                ++_x;
            }
            
            ++_y;
        }
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}