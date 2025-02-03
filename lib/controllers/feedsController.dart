import 'package:vibeshr/untils/export_file.dart';

class FeedController extends GetxController {
  var postdataPageNation = [].obs;
  var empProfile = {};
  @override
  void onInit() {
    // TODO: implement onInit
    getProfile();
    super.onInit();
  }
  getProfile()async{
    var data = await Services.employeeprofile();
    empProfile = data;
  }
  var postidtoCreateComment = {}.obs;
  createComment(Map postdata){
    postidtoCreateComment.value = postdata;
  }
  incrementCommentCount(int postId){
    for(int i=0;i<postdataPageNation[0].length;i++){
      if(postdataPageNation[0][i]["post_id"]==postId){
        postdataPageNation[0][i]["commentsCount"]= postdataPageNation[0][i]["commentsCount"]+1;
        if(postdataPageNation[0][i]["commentsCount"]<0){
          postdataPageNation[0][i]["commentsCount"]=0;
        }
        const update();
      }
    } 
  }
  decreementCommentCount(int postId){
    for(int i=0;i<postdataPageNation[0].length;i++){
      if(postdataPageNation[0][i]["post_id"]==postId){
        postdataPageNation[0][i]["commentsCount"]= postdataPageNation[0][i]["commentsCount"]-1;
        if(postdataPageNation[0][i]["commentsCount"]<0){
          postdataPageNation[0][i]["commentsCount"]=0;
        }
        const update();
      }
    } 
  }

}