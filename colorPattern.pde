
void setColorPattern(int index_){
    
    int k=0;    
    
    for(int i=_window.size()-1;i>=0;--i){
      int layer_=i; 
      int len=_window.get(i).size();
      for(int j=len-1;j>=0;--j){                
        if(_mode==0){
          k++;
          if(k>_pos_emerge) return;
        }
        
        _window.get(i).get(j).setColor(getColorPattern(layer_,j),20);
      }
    }
}

color getColorPattern(int i,int j){
        
      float layer_=i;
      int x=j;
        
        switch(floor(layer_)){
          case 0: 
            if(x%4>1) return _palette1[0];
            else return _palette1[1];            
          case 1:           
            if(x%4<2) return _palette1[0];
            else if(x%8<4) return _palette1[2];
            else return _palette1[3];            
          case 2:
            x=(x-1+_mwindow)%_mwindow;
            if(x%8<4) return _palette1[2];
            else return _palette1[3];            
          case 3:
            return _palette1[4];                        
          case 4:
            x+=2;
            if(x%8<4) return _palette1[2];
            else return _palette1[3];            
          case 5:
            x=(x+3)%_mwindow;
            if(x%8<2) return _palette1[4];
            else if(x%8<4) return _palette1[2];
            else if(x%8<6) return _palette1[4];
            else return _palette1[3];            
          case 6:
            x+=3;
            if(x%4<2) return _palette1[4];
            else return _palette1[5];            
          case 7:
          case 8:
            if(x%4>1) return _palette1[0];
            else return _palette1[1];            
          case 9:
          case 10:
            if((x+1)%4<2) return _palette1[3];
            else return _palette1[2];                          
          default:
            return color(0,0,0,0);            
        }
      
    
    
}