class AppLinkUrl {
  // static const String baseUrl = 'http://10.0.2.2:8000';
  // static const String baseUrl = 'http://192.168.189.1:8000';
  static const String baseUrl = "https://c30db6470741.ngrok-free.app";
  // static const String baseUrl = 'http://10.150.210.52:8000';
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
  static const String getcenters = '/api/company-centers/all';
  static const String getreceivedshipments =
      '/api/shipments/my-received-shipments';

  static const String getcomplaints = '/api/complaints/get-my-complaints';
  static const String sendcomplaints = '/api/complaints';
  static const String getCheckpoints = '/api/checkpoints';
  static const String getPayments = '/api/payments';
  static const String createPayment = '/api/payments';
  static const String getpendingShipments =
      '/api/shipments/my-customer-pending';
  static const String myPayments = '/api/shipments/my-payments';

  static const String approvePrice = '/api/shipments/approve-price';
  static const String groupTrackings = '/api/group-trackings';

  static String updateComplaint(int id) => '/api/complaints/$id';

  static String deleteComplaint(int id) => '/api/complaints/$id';
}
