// Feather disable all

/// @param mundi
/// @param value
/// @param [cloneValue=true]

function MundiClearType(_mundi, _value, _cloneValue = true)
{
    if (_mundi == undefined) return;
    return _mundi.ClearType(_value, _cloneValue);
}