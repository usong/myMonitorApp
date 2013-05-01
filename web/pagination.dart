
part of monitorapp;


class PgindeofStatus{
  PgindeofStatus(this._status,this._txt);
  bool    _status ;
  String  _txt ;  
}

class Pagination {

  final int  _slidenums = 5;
  
  final int _firsttotal  = 5;
  final int _tailtotal = 5;
  
  final int _tail ;  //length
  int  _interval = 2;
 
  var   _curValue;
  
  bool  _bStart ;
  bool  _bEnd   ;
  Pagination( this._tail);
  Map<int , PgindeofStatus> _pgmap = new Map<int ,PgindeofStatus>();
  void nagv_selected(int num) {
    if( num == 1 ){
      _bStart = false;
      _bEnd   = true;
    } else if( num == _tail){
      _bStart = true;
      _bEnd   = false;
    } else {
      _bStart = true;
      _bEnd   = true;
    }
     
  }
  void selected( int clickpos ){
 
     _pgmap.clear();
     nagv_selected(clickpos);
     int pos = 0;
     int idx = 0;
     if( _tail < 10 ){
       
       print("cucucucucucucuc");
       for( pos = idx = 1; idx <= _tail ; pos++,idx++ ){
         PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
         _pgmap[pos] = pgnode;         
       }
       viewit( _pgmap );
     }else if( ( clickpos - _interval > _interval  &&  clickpos >  _firsttotal &&  clickpos < _tail - _tailtotal )|| 
         (clickpos + _interval < _tail - _interval && clickpos > _tailtotal ) )
     {
       //output( 1 2 ..  pos-2 pos-1  pos  pos+1 pos+2  .. max )
       print("foooooooooooooooooooooo");
       for( pos = idx = 1; idx <= _interval ; pos++,idx++ ){
         PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
         _pgmap[pos] = pgnode;         
       }
       PgindeofStatus pgnode = new PgindeofStatus(false,'..');
       _pgmap[pos++] = pgnode;
       print('idx=$pos');
       
       for( idx = clickpos - _interval; idx <= clickpos +  _interval; pos++,idx++ ){         
         PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
         _pgmap[pos] = pgnode;
         
       } 
       pgnode = new PgindeofStatus(false,'..');
       _pgmap[pos++] = pgnode;
       print('idx=$pos');
       
       for( idx = _tail - _interval; idx <= _tail ; pos++,idx++ ){         
         PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
         _pgmap[pos] = pgnode;         
       }
       viewit( _pgmap );
     }else if (  clickpos <= _firsttotal ){
       print("zzzzzzzzzzzzzzzzzzzzzzzzz");
       if( clickpos + _interval > _firsttotal) { 
         for( pos = idx = 1; idx <= clickpos + _interval ;idx++,pos++ ){
           PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
           _pgmap[pos] = pgnode;
         }
       }else {
         for( pos = idx = 1; pos <= _firsttotal ; idx++,pos++ ){
           PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
           _pgmap[pos] = pgnode;
         }
       }
       PgindeofStatus pgnode = new PgindeofStatus(false,'..');
       _pgmap[pos++] = pgnode;
       print('idx=$pos');
       for( idx = _tail - _interval; idx <= _tail ; pos++,idx++ ){
         PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
         _pgmap[pos] = pgnode;
         
       }
       viewit( _pgmap );

     }else if(   clickpos >= _tail - _tailtotal ){
       //output ( 1 2  .. tailtotal - ..  max-1 max);
       print("susssssssssssusususususus");       
       for( pos = idx = 1; idx <= _interval ; pos++,idx++ ){
         PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
         _pgmap[pos] = pgnode;         
       }
       PgindeofStatus pgnode = new PgindeofStatus(false,'..');
       _pgmap[pos++] = pgnode;
       print('idx=$pos');
       if( clickpos - _interval < _tail - _tailtotal +1) { 
         for( idx = clickpos - _interval; idx <= _tail ;pos++,idx++ ){
           PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
           _pgmap[pos] = pgnode;
         }
       }else {
         for( idx = _tail - _tailtotal + 1; idx <= _tail ; idx++,pos++ ){
           PgindeofStatus pgnode = new PgindeofStatus(true,idx.toString());
           _pgmap[pos] = pgnode;
         }
       }
       viewit( _pgmap );
     }

     
  }
  void preview(Event e){
    
  }
  void lastview(Event e){
    
  }
  
  void viewit( Map<int ,PgindeofStatus> pgmap ){
    query("#pg_ul").children.clear();
    var compare = (a, b) => a.compareTo( b );
    var list = new List.from( pgmap.keys );
    list.sort(compare); 
    list.forEach((value)=>print(value));
    Element ulelement = query("#pg_ul");
    //pre element
    Element li = new LIElement();
    if( !_bStart ){
      li.attributes["class"] = 'disabled';
    }
    AnchorElement anchor = new AnchorElement();
    anchor.href = '#';
    
    SpanElement span= new SpanElement();
    span.text = "<";
    anchor.onClick.listen(preview);    
    
    anchor.children.add(span);
    li.children.add(anchor);    
    ulelement.children.add(li);
    //pglist element
  
    for (final key in list) {
      PgindeofStatus value = pgmap[key];
      Element li = new LIElement();
      if( !value._status ) {
        li.attributes["class"] = 'disabled';
      }
      anchor = new AnchorElement();
      anchor.href = '#';
      SpanElement span= new SpanElement();
      span.text = value._txt;
      
      if( value._status ){
        int curclick = int.parse(span.text);
        anchor.onClick.listen( (e){  
            print("click=$curclick");
            selected( curclick );
        });
      }
      
      anchor.children.add(span);
      li.children.add(anchor);
      ulelement.children.add(li);
    }
    
    //last element  
    li = new LIElement();
    if( !_bEnd ){
      li.attributes["class"] = 'disabled';   
    }
    anchor = new AnchorElement();
    anchor.href = '#';
    span= new SpanElement();
    span.text = ">";
    anchor.onClick.listen(lastview);
    
    anchor.children.add(span);
    li.children.add(anchor);    
    ulelement.children.add(li);
  }
 
   

  
}

