// Feather disable all

/// @param mundi
/// @param type
/// @param value

function MundiSetWeightForType(_mundi, _type, _value)
{
    if (_mundi == undefined) return;
    return _mundi.SetWeightForType(_type, _value);
}