// Feather disable all

/// @param mundi

function MundiExists(_mundi)
{
    if (_mundi == undefined) return false;
    return _mundi.Exists();
}