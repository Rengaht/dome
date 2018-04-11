
void genWindow(){
  
  _window=new ArrayList<ArrayList<Window>>();
  
  float the1=py[0];  
  float ex=TWO_PI/mx;  
  
  for(float i=1;i<my;++i){
    
    
    float the2=HALF_PI*(py[(int)i]);
    
    //println(degrees(the1)+"  "+degrees(the2));
    
    if(i==1||i==3||i==7){
      ArrayList<Window> loop_=new ArrayList<Window>();
      
      for(float j=0;j<mx;++j){
        
        ArrayList<PVector> vec_=new ArrayList<PVector>();
        float phi=ex*j;
           
        vec_.add(new PVector(Rad*sin(the1)*cos(phi),Rad*sin(the1)*sin(phi),Rad*cos(the1)));
        vec_.add(new PVector(Rad*sin(the1+the2)*cos(phi),Rad*sin(the1+the2)*sin(phi),Rad*cos(the1+the2)));
        
        phi+=ex;
        vec_.add(new PVector(Rad*sin(the1+the2)*cos(phi),Rad*sin(the1+the2)*sin(phi),Rad*cos(the1+the2)));
        vec_.add(new PVector(Rad*sin(the1)*cos(phi),Rad*sin(the1)*sin(phi),Rad*cos(the1)));
            
        loop_.add(new Window(vec_));
      }
      
      _window.add(loop_);
      
  }else if(i==2||i==4||i==5){
    
        ArrayList<Window> loop1_=new ArrayList<Window>();
        ArrayList<Window> loop2_=new ArrayList<Window>();
    
        for(float j=0;j<mx;++j){
            
            float phi=ex*j;        
            
                       
            if((i%2==0&&j%2==1)||(i%2==1 && j%2==0)){
        
              ArrayList<PVector> vec_=new ArrayList<PVector>();
        
              vec_.add(new PVector(Rad*sin(the1)*cos(phi),Rad*sin(the1)*sin(phi),Rad*cos(the1)));
              vec_.add(new PVector(Rad*sin(the1+the2)*cos(phi),Rad*sin(the1+the2)*sin(phi),Rad*cos(the1+the2))); 
              vec_.add(new PVector(Rad*sin(the1)*cos(phi+ex),Rad*sin(the1)*sin(phi+ex),Rad*cos(the1)));
              
              loop1_.add(new Window(vec_));
              
              
              ArrayList<PVector> vec2_=new ArrayList<PVector>();
              
              vec2_.add(new PVector(Rad*sin(the1+the2)*cos(phi),Rad*sin(the1+the2)*sin(phi),Rad*cos(the1+the2))); 
              vec2_.add(new PVector(Rad*sin(the1)*cos(phi+ex),Rad*sin(the1)*sin(phi+ex),Rad*cos(the1)));
              vec2_.add(new PVector(Rad*sin(the1+the2)*cos(phi+ex),Rad*sin(the1+the2)*sin(phi+ex),Rad*cos(the1+the2)));
              
              loop2_.add(new Window(vec2_));
              
            }else{
              
              ArrayList<PVector> vec_=new ArrayList<PVector>();
              vec_.add(new PVector(Rad*sin(the1+the2)*cos(phi),Rad*sin(the1+the2)*sin(phi),Rad*cos(the1+the2))); 
              vec_.add(new PVector(Rad*sin(the1)*cos(phi),Rad*sin(the1)*sin(phi),Rad*cos(the1)));
              vec_.add(new PVector(Rad*sin(the1+the2)*cos(phi+ex),Rad*sin(the1+the2)*sin(phi+ex),Rad*cos(the1+the2)));
              
              loop2_.add(new Window(vec_));
              
              ArrayList<PVector> vec2_=new ArrayList<PVector>();
              vec2_.add(new PVector(Rad*sin(the1)*cos(phi),Rad*sin(the1)*sin(phi),Rad*cos(the1)));
              vec2_.add(new PVector(Rad*sin(the1+the2)*cos(phi+ex),Rad*sin(the1+the2)*sin(phi+ex),Rad*cos(the1+the2)));
              vec2_.add(new PVector(Rad*sin(the1)*cos(phi+ex),Rad*sin(the1)*sin(phi+ex),Rad*cos(the1)));
              
              loop1_.add(new Window(vec2_));
              
            }
            
            
        }
        _window.add(loop1_);
        _window.add(loop2_);
        
      }else if(i==6){
        
        ArrayList<Window> loop1_=new ArrayList<Window>();
        ArrayList<Window> loop2_=new ArrayList<Window>();
        
        for(float j=0;j<mx;++j){
            float phi=ex*j;
        
            //beginShape(TRIANGLE_STRIP);                    
              
            //  vertex(Rad*sin(the1+the2)*cos(phi),Rad*sin(the1+the2)*sin(phi),Rad*cos(the1+the2));         
            //  vertex(Rad*sin(the1)*cos(phi),Rad*sin(the1)*sin(phi),Rad*cos(the1));
              
            //   vertex(Rad*sin(the1+the2)*cos(phi+ex/2),Rad*sin(the1+the2)*sin(phi+ex/2),Rad*cos(the1+the2));         
              
            //  vertex(Rad*sin(the1)*cos(phi+ex),Rad*sin(the1)*sin(phi+ex),Rad*cos(the1));
            //  vertex(Rad*sin(the1+the2)*cos(phi+ex),Rad*sin(the1+the2)*sin(phi+ex),Rad*cos(the1+the2));
            
            //endShape();
                       
            
           
              
              PVector cent,px,py,ccent;
              if(j%2==0){
                
                cent=new PVector(Rad*sin(the1)*cos(phi+ex),Rad*sin(the1)*sin(phi+ex),Rad*cos(the1));
                px=new PVector(Rad*sin(the1)*cos(phi),Rad*sin(the1)*sin(phi),Rad*cos(the1));
                py=new PVector(Rad*sin(the1+the2)*cos(phi+ex),Rad*sin(the1+the2)*sin(phi+ex),Rad*cos(the1+the2));
                
                ccent=new PVector(Rad*sin(the1+the2)*cos(phi),Rad*sin(the1+the2)*sin(phi),Rad*cos(the1+the2));
              }else{
                cent=new PVector(Rad*sin(the1)*cos(phi),Rad*sin(the1)*sin(phi),Rad*cos(the1));
                px=new PVector(Rad*sin(the1)*cos(phi+ex),Rad*sin(the1)*sin(phi+ex),Rad*cos(the1));
                py=new PVector(Rad*sin(the1+the2)*cos(phi),Rad*sin(the1+the2)*sin(phi),Rad*cos(the1+the2));
                
                ccent=new PVector(Rad*sin(the1+the2)*cos(phi+ex),Rad*sin(the1+the2)*sin(phi+ex),Rad*cos(the1+the2));
              }
                //vertex(px.x,px.y,px.z);
              
                px.sub(cent);
                py.sub(cent);              

           ArrayList<PVector> vec_=new ArrayList<PVector>();
              
           float eang=HALF_PI/marc;
                
                for(int x=0;x<=marc;++x){
                    float athe=eang*x;
                    PVector tmp=cent.get();
                    tmp.add(PVector.mult(px,cos(athe)));
                    tmp.add(PVector.mult(py,sin(athe)));
                    vec_.add(new PVector(tmp.x,tmp.y,tmp.z));
                }
                //vertex(py.x,py.y,py.z);
                vec_.add(new PVector(cent.x,cent.y,cent.z));
         
            
           ArrayList<PVector> vec2_=new ArrayList<PVector>();
                 
                for(int x=0;x<=marc;++x){
                    float athe=eang*x;
                    PVector tmp=cent.get();
                    tmp.add(PVector.mult(px,cos(athe)));
                    tmp.add(PVector.mult(py,sin(athe)));
                    vec2_.add(new PVector(tmp.x,tmp.y,tmp.z));
                }
                //vertex(py.x,py.y,py.z);
                vec2_.add(new PVector(ccent.x,ccent.y,ccent.z));    
                
             loop1_.add(new Window(vec_));
             loop2_.add(new Window(vec2_));
            //if(j%2==0){
            //  loop_.add(new Window(vec2_));
            //  loop_.add(new Window(vec_));               
            //}else{
            //  loop_.add(new Window(vec_));
            //  loop_.add(new Window(vec2_));              
            //}
            
            
        }  
        _window.add(loop1_);
        _window.add(loop2_);
      }
      the1+=the2;
      
  }
}