library monitorapp;
import 'dart:html';
import 'dart:math';
import 'dart:json';

part 'hostnode.dart';
part 'pagination.dart';


void main() { 
  generate_addview(); /* addview node */
  generate_pagination(); /* add pagination view*/
  
}
void generate_pagination(){
  
  Pagination pg = new Pagination(10);
  pg.selected(1);
  
}
void generate_addview() {
  
  Element element = new Element.html("<li class='span3'><div class='thumbnail' id='thumbnail_view'>"
            "<div class='imgclass' id='closeicon'>"
            "<div class='mycircle_out_class' id='mycircle'>"
            "</div></div>"
            "<img data-src='holder.js/140x140' alt='100x100' "
            "src='../public/img/add.png' style='width: 180px; height: 180px'>"
            "<div class='caption'>new......</div></div></li>");
 
  query("#mythumbnails").children.add(element);
  query("#thumbnail_view").onMouseDown.listen(Addnode);
  //新增面板事件
  query("#status_submit").onClick.listen(GetNodeInfo);
  query("#modalheader_close").onClick.listen(modalinit);
  query("#modalfooter_close").onClick.listen(modalinit);
}
void modalinit(Event e ) {
  
  query("#nodeip").value="";
  
  query("#nodeport").value = "";
  query("#nodealias").value = "";
  query("#nodedesc").value = "";
  query("#alert_tip").attributes['style']="display:none";
  query("#status_submit").text="获取信息";
  query("#x-modal-div").attributes['style']="display:none";
  
  
}
void GetNodeInfo(Event e) {
  

  var random = new Random();
  var name = random.nextInt(4000).toString() ;
  var node = new Hostnode(name);
  var url = "http://127.0.0.1:5000/get_value";
  node.requesturl(url);

}
void Addnode(Event e){  
  
  query("#x-modal-div").attributes['style']="display:block";
  //query('#modal_example').xtag.show();
  
  query('#modal_example').xtag.show();
  
  
  var random = new Random();
  var name = random.nextInt(4000).toString() ;
  var node = new Hostnode(name);
  //add hostnode ui display
  //node.generate_nodeadd( query("#mythumbnails") ,name );

  /*
  var random = new Random();
  var name = random.nextInt(4000).toString() ;
  print('name=$name');
  var node = new Hostnode(name);
  node.generate_nodeadd( query("#mythumbnails") ,name );  */
}
void onDataLoaded(String responseText) {
  var jsonString = responseText;
  print(jsonString);
  
  
  print('reload');
}
