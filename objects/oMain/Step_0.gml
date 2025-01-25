// Feather disable all

if (keyboard_check_pressed(ord("W")))
{
    debugFunc = MundiDebugDrawWeights;
}

if (keyboard_check_pressed(ord("T")))
{
    debugFunc = MundiDebugDrawTypes;
}

if (keyboard_check_pressed(ord("D")))
{
    debugFunc = MundiDebugDrawDijkstra;
}

if (mouse_check_button_pressed(mb_left))
{
    MundiDijkstraBuild(mundi,
                       MundiDebugConvertCoord(mouse_x, 10, 32),
                       MundiDebugConvertCoord(mouse_y, 10, 32),
                       5, false);
    
    cells = MundiDijkstraGetCells(mundi);
    path = undefined;
}

if (mouse_check_button_pressed(mb_right))
{
    path = MundiDijkstraGetPath(mundi,
                                MundiDebugConvertCoord(mouse_x, 10, 32),
                                MundiDebugConvertCoord(mouse_y, 10, 32));
}