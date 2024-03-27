// class LoginResponseModel {
//   final String statusCode;
//   final String error;

//   LoginResponseModel({required this.statusCode, required this.error});

//   factory LoginResponseModel.fromJson(Map<String, dynamic> json){
//     return LoginResponseModel(statusCode: json["status"] !=null ? json["token"] : "", error: json["error"] != null ? json ["error"] : "");
//   }
// }
// class LoginRequestModel {
//   String? email;
//   String? password;

//   LoginRequestModel({this.email, this.password});

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> map = {
//       "email": email?.trim(),
//       "password": password?.trim(),
//     };

//     return map;
//   }
// }
