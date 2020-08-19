class UserModel{
  String userId,userUniqueId,userName,userEmail,userProfileImageUrl,userPhoneNumber,userCity,userCountry,userPin;
  dynamic point;
  String distance;
  UserModel({this.userId,this.userUniqueId,this.userName,this.userEmail,this.userCity,this.userCountry,this.point,
    this.userPin,this.userPhoneNumber,this.userProfileImageUrl,this.distance});
  factory UserModel.fromMap(Map snapshot){
    return UserModel(
      userId: snapshot['userId'],
      userUniqueId: snapshot["userUniqueId"],
      userName: snapshot['userName'],
      userEmail: snapshot['userEmail'],
      userCity: snapshot['userCity'],
      userCountry: snapshot['userCountry'],
      userPin: snapshot['userPin'],
      //point: snapshot['point'],
      userPhoneNumber: snapshot['userPhoneNumber'],
      userProfileImageUrl: snapshot['userProfileImageUrl'],
      distance: snapshot["distance"] ??  "0"
    );
  }

  toJson(){
    return {
      "userId":userId,
      "userEmail":userEmail,
      "userUniqueId":userUniqueId,
      "point":point,
      "userName":userName,
      "userCity":userCity,
      "userCountry":userCountry,
      "userPin":userPin,
      "userPhoneNumber":userPhoneNumber,
      "userProfileImageUrl":userProfileImageUrl
    };
  }
}