// Feather disable all

/// @param mundi
/// @param height

function MundiSetHeight(_mundi, _height)
{
    if (_mundi == undefined) return;
    return _mundi.SetHeight(_height);
}