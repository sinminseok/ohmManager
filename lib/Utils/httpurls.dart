String endpoint = "http://192.168.0.101:8080/api/";

class AdminApi_Url {
  String save_ceo = endpoint+"ceo";

  String checkCode_ceo = endpoint+"ceo/code/"; //+{code}

  String save_manager = endpoint+"manager/"; //+{gymId}

  String save_trainer = endpoint + "trainer/";

  String login = endpoint + "admin/login";

  String register_profile = endpoint + "admin/image/"; //+{managerId}

  String getInfo = endpoint + "admin";

  String getInfo_byId = endpoint + "admin/info/"; // +{managerId}

  String update_profile = endpoint+"admin/image/"; // +{managerId}

  String update_info = endpoint+"admin"; // +{managerId}

  String delete_account = endpoint+"admin/"; // +{managerId}

  String findall_admin = endpoint + "admin/findall/"; //+{{gymId}}



}

class GymApi_Url {
  String find_byId = endpoint + "gym/";

  String find_gymPrice = endpoint+"gym/price/";

  String find_gymTime = endpoint+"gym/price/";

  String time_avg = endpoint+"gym/avg/";

  String register_price = endpoint + "gym/price/";

  String register_time = endpoint + "gym/time/";

  String check_code = endpoint + "gym/code/";

  String reset_count = endpoint +"gym/reset/";

  String register_gym = endpoint + "gym";

  String registerimg_gym = endpoint + "gym/image/";

  String decrease_count = endpoint + "gym/count-decrease/";

  String increase_count = endpoint + "gym/count-increase/";

  String current_count = endpoint + "gym/count/";

  String find_byName = endpoint + "gym/name/";

  String findall = endpoint + "gyms";

  String udpate_gymInfo = endpoint+"gym";
}

class PostApi_Url {
  String find_byId = endpoint + "post/";

  String findall_bygymId = endpoint + "posts/";

  String save_post = endpoint + "post/";

  String update_post = endpoint + "post";

  String save_postimgs = endpoint + "post/img/";
}

class QuestionApi_Url {
  String findall_question = endpoint + "question/all/";

  String find_question = endpoint + "question/";

  String register_answer = endpoint + "answer/";


}
