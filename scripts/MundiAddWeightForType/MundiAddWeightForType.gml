// Feather disable all

/// @param mundi
/// @param type
/// @param value

function MundiAddWeightForType(_mundi, _type, _value)
{
    if (_mundi == undefined) return;
    return _mundi.AddWeightForType(_type, _value);
}