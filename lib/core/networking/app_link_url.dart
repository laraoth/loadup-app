class AppLinkUrl {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static const String login = '/api/login';
  static const String signup = '/api/register';
  static const String logout = '/api/logout';
  static const String reset = '/api/resetpassword';

  static const String shipmentrequest = '/api/shipments/add-shipment-request';
  static const String getgovernorates = '/api/governorates';
  static const String getsentshipments = '/api/shipments/my-sent-shipments';
  static const String getusers = '/api/users';
  static const String getprofile = '/api/user';
  static const String updateprofile = '/api/user/update-profile';
  static const String getcenters = '/api/company-centers';
  static const String getreceivedshipments =
      '/api/shipments/my-received-shipments';

  static const String getcomplaints = '/api/complaints';
  static const String sendcomplaints = '/api/complaints';

  static String updateComplaint(int id) => '/api/complaints/$id';

  static String deleteComplaint(int id) => '/api/complaints/$id';
}
