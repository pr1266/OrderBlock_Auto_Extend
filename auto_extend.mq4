//+------------------------------------------------------------------+
//|                                                  auto_extend.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, NJFC."
#property version   "1.00"
#property strict


datetime NewCandleTime = TimeCurrent();
bool isNewCandle(){
    if(NewCandleTime == iTime(Symbol(), 0, 0)) return false;
    else{
        NewCandleTime = iTime(Symbol(), 0, 0);        
        return true;
    }
}

void check_orderblocks(){
    for(int i = ObjectsTotal() - 1; i >= 0; i--){
        if(ObjectType(i) != OBJ_RECTANGLE) continue;
        
    }
}

void OnTick(){
    if(isNewCandle()){
        check_orderblocks();
    }
}