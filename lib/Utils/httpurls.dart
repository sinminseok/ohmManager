
String endpoint = "http://localhost:8080/api/";

class ManagerApi_Url{

  String save_manager = endpoint + "manager";

  String save_trainer = endpoint +  "trainer";

  String info_manager = endpoint + "manager/info/";

  String login_manager = endpoint + "manager/login";

  //GymId로 해당 Gym에 소속된 manager모두조회
  String findall_byGymId = endpoint + "manager/findall/";

  String find_byId = endpoint + "manager/";

}

class GymApi_Url{

  String find_byId = endpoint + "gym/";

  String register_gym = endpoint +"gym";

  String decrease_count = endpoint + "gym/count-decrease/";

  String increase_count = endpoint + "gym/count-increase/";

  String current_count = endpoint + "gym/count/";

  String find_byName = endpoint + "gym/name/";

  String findall = endpoint + "gyms";

}


class PostApi_Url{

  String find_byId = endpoint+"post/";

  String findall_bygymId = endpoint + "posts/";

  String save_post = endpoint +"post/";

  String save_postimgs = endpoint +"post/img/";
}