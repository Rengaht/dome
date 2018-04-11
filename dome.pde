static final int MMODE=3;
color[] _palette1={color(255,176,125),color(239,46,112),color(244,255,144),color(0,109,249),color(141,255,210),color(255),color(0,0,0,0)};

float Rad=300;
float mx=48;
float my=8;

float marc=50;

float py[]={50,74.57,64.168,43.644,40.085,43.136,27.312,37.085};
float sum_=0;

int _mwindow=0;

ArrayList<ArrayList<Window>> _window;
float _phi=0;


int _last_millis;

PShader _blur;
PGraphics _graph_src;
PGraphics _graph_pass1, _graph_pass2;

int _mode=0;

FrameTimer _timer_emerge=new FrameTimer(1);
float _pos_emerge=0;

FrameTimer _timer_strip=new FrameTimer(50);
float _pos_strip=0;



boolean _record=false;


void setup(){

  size(800,800,P2D);
  _blur=loadShader("blur.glsl");
  _blur.set("blurSize", 40);
  _blur.set("sigma", 15.0f);  
  
  _graph_src=createGraphics(width, height, P3D); 
  _graph_pass1=createGraphics(width, height, P2D);
  _graph_pass2=createGraphics(width, height, P2D);
  
  for(int i=0;i<my;++i) sum_+=py[i];

  for(int i=0;i<my;++i){
    py[i]/=sum_;    
  }
  
  smooth();
  genWindow();
  setColorPattern(0);
  
  int len=_window.size();
  for(int i=0;i<len;++i){
     int size_=_window.get(i).size();
     for(int j=0;j<size_;++j){
       _mwindow++;         
     }
   }
   println("Total window= "+_mwindow);
   
   setMode(0);
}


void draw(){
  
  
  int dm=millis()-_last_millis;
   _last_millis+=dm;
   
  _graph_src.beginDraw(); 
  _graph_src.background(0);
  
  _graph_src.pushMatrix();
  _graph_src.translate(width/2,height/2);
  _graph_src.rotateX(map(mouseY,0,height,0,PI));
  _graph_src.rotateZ(map(mouseX,0,width,-PI,PI));
  
  _graph_src.ambientLight(2, 2, 2);
  //_graph_src.lightSpecular(154, 154, 154);
  _graph_src.directionalLight(50,50,50, 0, 0, -1);
  //_graph_src.pointLight(60,60,60,0,0,0);
  _graph_src.noLights();
  
  
    int len=_window.size();
    for(int i=0;i<len;++i){
       int size_=_window.get(i).size();
       for(int j=0;j<size_;++j){
         _window.get(i).get(j).update(dm);
         _window.get(i).get(j).draw(_graph_src);         
       }
    }
  
   
      switch(_mode){
        case 0:          
          //if(_pos_emerge>_mwindow) setBreath(true);
          //else{
            _timer_emerge.update(dm);
            if(_timer_emerge.end()){
              _pos_emerge++;
              _timer_emerge.restart();
              setColorPattern(0);
            }
          //}          
          break;
        case 1:          
          for(int i=0;i<len;++i){
             int size_=_window.get(i).size();
             for(int j=0;j<size_;++j){
              if(_window.get(i).get(j)._timer.end() && random(200)<1) _window.get(i).get(j).setColor(_palette1[floor(random(7))],random(30,60));         
             }
          }
          
          break;
         case 2:
           _timer_strip.update(dm);
           if(_timer_strip.end()){
               _pos_strip++;
                 
               for(int i=0;i<len;++i){
                 int size_=_window.get(i).size();
                 for(int j=0;j<size_;++j){
                    _window.get(i).get(j).setColor(_palette1[floor(getHorizonLayer(i)+_pos_strip)%5],_timer_strip._due/2);         
                 }
              }  
              //_timer_strip.setDue(floor(900+50*cos(_pos_strip/(float)len*PI)));
              _timer_strip.restart();
           }
           break;
      }
 
  _graph_src.popMatrix();
  _graph_src.endDraw();
  
  _blur.set("horizontalPass",0);
  _graph_pass1.beginDraw();            
  _graph_pass1.shader(_blur);  
  _graph_pass1.image(_graph_src, 0, 0);
  _graph_pass1.endDraw();

  _blur.set("horizontalPass", 1);
  _graph_pass2.beginDraw();            
  _graph_pass2.shader(_blur);  
  _graph_pass2.image(_graph_pass1, 0, 0);
  _graph_pass2.endDraw();   
  
   _blur.set("horizontalPass",0);
  _graph_pass1.beginDraw();            
  _graph_pass1.shader(_blur);  
  _graph_pass1.image(_graph_pass2, 0, 0);
  _graph_pass1.endDraw();

  _blur.set("horizontalPass", 1);
  _graph_pass2.beginDraw();            
  _graph_pass2.shader(_blur);  
  _graph_pass2.image(_graph_pass1, 0, 0);
  _graph_pass2.endDraw();   
  
  
  background(0);
  blendMode(ADD);
  tint(255, 150);
  image(_graph_pass2, 0, 0);
  image(_graph_src, 0, 0);
  
  if(_record) saveFrame("record/r####.jpg");
  
  text(frameRate,20,20);
  text("press'm' to change mode",20,40);
 
}

void keyPressed(){
   switch(key){
     case ' ':
       saveFrame("test_"+str(year())+str(month())+str(day())+str(hour())+str(minute())+str(second())+".jpg"); 
       break;
     case 'a':
       _record=!_record;
       break;    
     case 'm':       
       setMode((_mode+1)%MMODE);
       break;     
   }

}
void setMode(int m_){
    
    _mode=m_;
    setBreath(false);
    
    switch(_mode){
      case 0:
        clearColor();
        _pos_emerge=1;
        _timer_emerge.restart();        
        break;
      case 1:
        break;
      case 2:
        _timer_strip.restart();
        _pos_strip=0;
        for(int i=0;i<_window.size();++i){
               int size_=_window.get(i).size();
               for(int j=0;j<size_;++j){
                  _window.get(i).get(j).setColor(_palette1[floor(getHorizonLayer(i))%5],10);         
               }
        }
        break;
    }
    
}

void clearColor(){
    _phi=0;      
    int len=_window.size();
    for(int i=0;i<len;++i){
       int size_=_window.get(i).size();
       for(int j=0;j<size_;++j){
         _window.get(i).get(j).setBreath(false);
         _window.get(i).get(j).setColor(color(0,0,0,0),0);         
       }
    }
}

void setBreath(boolean b_){
  int len=_window.size(); 
  for(int i=0;i<len;++i){
     int size_=_window.get(i).size();
     for(int j=0;j<size_;++j){
        _window.get(i).get(j).setBreath(b_);         
     }
  }
}


int getHorizonLayer(int i){
  return i;
  
   //switch(i){
   //   case 0: return 0;      
   //   case 1:  
   //   case 2: return 1;
   //   case 3: return 2;  
   //   case 4: 
   //   case 5: return 3; 
   //   case 6: 
   //   case 7: return 4; 
   //   case 8: 
   //   case 9: return 5; 
   //   case 10: return 6;           
   //}
  //return 0;
}