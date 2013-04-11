part of monitorapp;


class Hostnode{// extends WebComponent {
  
  /*   host info parameter */
  String m_ip;
  
  
  /*   view parameter */
  bool m_mouseover = false; //mouseover true
   
  Element m_closeicon;
  
  
  static final Map<String , Hostnode> _cache = <String ,Hostnode>{};
  factory Hostnode( String ipstr){
    if( _cache.containsKey( ipstr ) ){
      return _cache[ipstr];
    } else {
      /* first node is visual node */
      final hostnode = new Hostnode._internal(ipstr);
      _cache[ipstr] = hostnode;
      return hostnode;
    }
    
  }
  Hostnode._internal(this.m_ip);
  
  void show()=>print('this is $m_ip');
  
  void delete_node(Event e){
    var key = _cache.remove(m_ip);
    show();
    print('ip=$m_ip');
    query("#li$m_ip").remove();    
  }
  
  void generate_nodeadd(Element parent ,String name){
    Element lielement = new Element.tag("li");
    lielement.attributes['class'] = 'span3';
    lielement.attributes['id'] = 'li$name';
    m_ip = name;
    print("#thumbnail""$name");
    Element element = new Element.html("<div class='thumbnail' id='thumbnail$name'>"
        "<div class='imgclass' id='closeicon$name'>"       
        "<div class='mycircle_out_class' id='mycircle$name'>"
        "<img id='imgclose$m_ip' src='../public/img/del.png' style='display:none ;width: 18px; height: 18px'></img>"
        "</div>"
        "</div>"        
        "<img src='../public/img/add.png' style='width: 180px; height: 180px'>"
        "<div class='caption'>$m_ip</div></div>");
    lielement.insertAdjacentElement('afterBegin', element);   
    parent.insertAdjacentElement('afterBegin',lielement); 
    query("#thumbnail$name").onMouseOver.listen(ShowIcon);
    query("#thumbnail$name").onMouseOut.listen(HiddenIcon);
  }
  
  void ShowIcon(Event e){  
    if(!m_mouseover){
      m_mouseover = true;     
      //query("#mycircle$m_ip").remove();
      //var element = new Element.html("<img id='imgclose$m_ip' src='../public/img/del.png' style='border: 2px;width: 18px; height: 18px'></img>");
      //query("#closeicon$m_ip").children.add(element);
      query("#imgclose$m_ip").attributes['style']='display:block ;width: 18px; height: 18px';
      query("#imgclose$m_ip").onClick.listen(delete_node);
    }
  }
  void HiddenIcon(Event e){  
    if(m_mouseover){      
      m_mouseover = false;
      //query("#imgclose$m_ip").remove();
      //var element = new Element.html("<div class='mycircle_out_class' id='mycircle$m_ip'></div>");
      //query("#closeicon$m_ip").children.add(element);
      query("#imgclose$m_ip").attributes['style']='display:none ;width: 18px; height: 18px';
    }    
  }
  
}

