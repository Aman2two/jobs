

class User{
  String email,name,skills,id,token;
  int userRole;

  User({this.name,this.email,this.skills,this.id,this.token,this.userRole});

  factory User.fromJson(Map<String,dynamic> map){
    return User(
        email: map['email'],
        name: map['name'],
        skills: map['skills'],
        id: map['id'],
        token: map['token'],
        userRole: map['userRole'],
    );
  }
}