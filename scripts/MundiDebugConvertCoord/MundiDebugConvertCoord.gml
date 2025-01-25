// Feather disable all

/// @param input
/// @param offset
/// @param size

function MundiDebugConvertCoord(_input, _offset, _size)
{
    return floor((_input - _offset) / _size);
}