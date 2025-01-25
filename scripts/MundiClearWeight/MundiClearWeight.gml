// Feather disable all

/// @param mundi
/// @param value

function MundiClearWeight(_mundi, _value)
{
    if (_mundi == undefined) return;
    return _mundi.ClearWeight(_value);
}