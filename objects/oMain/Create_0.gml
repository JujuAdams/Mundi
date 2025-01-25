// Feather disable all

debugFunc = MundiDebugDrawWeights;

mundi = MundiCreate(15, 15);
MundiSetWeight(mundi, 0, 0, 5);
MundiSetWeight(mundi, 1, 1, 5);
MundiSetWeight(mundi, 2, 2, 5);
MundiSetWeight(mundi, 2, 3, 5);
MundiSetWeight(mundi, 3, 3, 5);

cells = undefined;
path = undefined;