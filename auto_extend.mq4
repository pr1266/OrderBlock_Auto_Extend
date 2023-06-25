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
    string name;
    double upper_bound;
    double lower_bound;
    int anchor;
    for(int i = ObjectsTotal() - 1; i >= 0; i--){
        name = ObjectName(i);
        if(ObjectType(name) != OBJ_RECTANGLE) continue;
        if(ObjectGetInteger(0, name, OBJPROP_COLOR) == clrRed){
            upper_bound = ObjectGetDouble(0, name, OBJPROP_PRICE1);
            lower_bound = ObjectGetDouble(0, name, OBJPROP_PRICE2);            
            if(iClose(NULL, 0, 1) > upper_bound){
                // delete
                ObjectSetInteger(0, name, OBJPROP_COLOR, clrYellow);
            }
            else{
                // extend
                anchor = ObjectGetInteger(0, name, OBJPROP_TIME1);
                ObjectDelete(0, name);
                ObjectCreate(0, name, OBJ_RECTANGLE, 0, anchor, lower_bound, iTime(NULL, 0, 0), upper_bound);
                ObjectSetInteger(0, name, OBJPROP_FILL, false);
                ObjectSetInteger(0, name, OBJPROP_BACK, false);
                ObjectSetInteger(0, name, OBJPROP_WIDTH, rect_width);
                ObjectSetInteger(0, name, OBJPROP_COLOR, clrRed);
            }
        }
      
        else if(ObjectGetInteger(0, name, OBJPROP_COLOR) == clrGreen){
            upper_bound = ObjectGetDouble(0, name, OBJPROP_PRICE1);
            lower_bound = ObjectGetDouble(0, name, OBJPROP_PRICE2);            
            if(iClose(NULL, 0, 1) < lower_bound){
                ObjectSetInteger(0, name, OBJPROP_COLOR, clrBlue);                
            }
            else{
                // extend
                anchor = ObjectGetInteger(0, name, OBJPROP_TIME1);
                ObjectDelete(0, name);
                ObjectCreate(0, name, OBJ_RECTANGLE, 0, anchor, lower_bound, iTime(NULL, 0, 0), upper_bound);
                ObjectSetInteger(0, name, OBJPROP_FILL, false);
                ObjectSetInteger(0, name, OBJPROP_BACK, false);
                ObjectSetInteger(0, name, OBJPROP_WIDTH, rect_width);
                ObjectSetInteger(0, name, OBJPROP_COLOR, clrGreen);            
            }
        }        
    }
}

void OnTick(){
    if(isNewCandle()){
        check_orderblocks();
    }
}