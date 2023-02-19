String endpoint = "http://localhost:8080/api/";

class ManagerApi_Url {
  String save_manager = endpoint + "manager";

  String check_code = endpoint+"manager/code/";

  String save_img = endpoint+"manager/image/";

  String save_trainer = endpoint + "trainer/";

  String info_gym_byId = endpoint + "manager/info/";

  String getinfo = endpoint + "manager";

  String login_manager = endpoint + "manager/login";

  String finall_trainer = endpoint+"manager/findall/";

  //GymId로 해당 Gym에 소속된 manager모두조회
  String findall_byGymId = endpoint + "manager/findall/";

  String find_byId = endpoint + "manager/";
}

class GymApi_Url {
  String find_byId = endpoint + "gym/";

  String find_gymPrice = endpoint+"gym/price/";

  String find_gymTime = endpoint+"gym/price/";

  String time_avg = endpoint+"gym/avg/";

  String register_price = endpoint + "gym/price/";

  String register_time = endpoint + "gym/time/";

  String check_code = endpoint + "gym/code/";

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

  String save_postimgs = endpoint + "post/img/";
}
