library monitorapp;
import 'dart:html';
import 'dart:math';
part 'hostnode.dart';


void main() { 
  generate_addview(); /* addview node */
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
}
void Addnode(Event e){   
  var random = new Random();
  var name = random.nextInt(4000).toString() ;
  print('name=$name');
  var node = new Hostnode(name);
  node.generate_nodeadd( query("#mythumbnails") ,name );  
}
