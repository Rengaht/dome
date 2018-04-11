class FrameTimer{
  int _due;
  int _time;
  boolean _run;
  
  FrameTimer(int due){
    _due=due;//max(floor(due/1000.0*60.0),1); 
    //println(_due);
  }
  void reset(){
      _time=0;
  }
  void start(){
    _run=true;
  }
 
  void restart(){
      reset();
      start();
  }
  void update(int dt){
    if(!_run) return;
    if(_time<_due) _time++;//_time+=dt;    
  }
  boolean end(){
     return _time>=_due; 
  }
  float val(){
     return constrain((float)_time/(float)_due,0,1); 
  }
  void setDue(int d_){
    _time=floor((float)_time/(float)_due*d_);
    _due=d_;
  }
}