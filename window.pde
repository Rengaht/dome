class Window{
   ArrayList<PVector> _vertex;
   color _color;
   color _src_color,_dest_color;
   float _alpha;
   FrameTimer _timer;
   
   boolean _breath;
   FrameTimer _timer_breath;
   
   Window(ArrayList<PVector> vert_){
      _vertex=new ArrayList<PVector>(vert_);
      _src_color=_dest_color=_color=color(0,0,0,0);
      _alpha=0;
      _timer=new FrameTimer(20);
      
      _timer_breath=new FrameTimer(180);
      _breath=false;
   }
   void draw(PGraphics g_){
     
     g_.emissive(_color);//red(_color)/2,green(_color)/2,blue(_color)/2);
     //g_.ambient(_color);
     g_.shininess(2.0);
     g_.specular(120);
  
     g_.pushStyle();
       g_.stroke(120);
       //g_.noStroke();
       
       if(_breath) g_.fill(_color,_alpha-40*sin(PI*_timer_breath.val()));
       else g_.fill(_color,_alpha);
       
       if(_vertex.size()>0){
         g_.beginShape();
           for(PVector v:_vertex) g_.vertex(v.x,v.y,v.z);         
         g_.endShape(CLOSE);
       }
       
     g_.popStyle();
     
     
   }
   void update(int dt_){
     
     _timer.update(dt_);
     _timer_breath.update(dt_);
     if(_timer_breath.end()) _timer_breath.restart();
     
     _color=lerpColor(_src_color,_dest_color,_timer.val());
     _alpha=lerp(alpha(_src_color),alpha(_dest_color),_timer.val());
   }
   void setColor(color c_){
     setColor(c_,(int)random(300,800));
   }
   void setColor(color c_,float t_){
      _src_color=_color;
      _dest_color=c_;
      _timer.setDue(floor(t_));
      _timer.restart();
   }
   void setBreath(boolean b){
      
      if(b){
        if(!_breath) _timer_breath.restart();
      }else _timer_breath.reset();
      _breath=b;
   }
}