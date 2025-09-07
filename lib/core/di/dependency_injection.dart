import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/network_info.dart';
import 'package:loadup/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:loadup/features/auth/data/datasources/logout_remote_data_source.dart';
import 'package:loadup/features/auth/data/datasources/sign_up_remote_data_source.dart';
import 'package:loadup/features/auth/data/repos/login_repo.dart';
import 'package:loadup/features/auth/data/repos/logout_repo.dart';
import 'package:loadup/features/auth/data/repos/sign_up_repo.dart';
import 'package:loadup/features/auth/logic/cubit/login_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/signup_cubit.dart';
import 'package:loadup/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:loadup/features/complaints/data/datasources/create_complaint_remote_data_source.dart';
import 'package:loadup/features/complaints/data/datasources/delete_complaint_remote_data_source.dart';
import 'package:loadup/features/complaints/data/datasources/update_complaint_remote_data_source.dart';
import 'package:loadup/features/complaints/data/repos/complaints_repo.dart';
import 'package:loadup/features/complaints/data/repos/create_complaint_repo.dart';
import 'package:loadup/features/complaints/data/repos/delete_complaint_repo.dart';
import 'package:loadup/features/complaints/data/repos/update_complaint_repo.dart';
import 'package:loadup/features/complaints/logic/cubit/complaints_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/create_complaints_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/delete_complaint_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/update_complaint_cubit.dart';
import 'package:loadup/features/create_shipment/data/datasource/centers_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/datasource/governorates_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/datasource/shipment_request_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/datasource/users_remote_data_source.dart';
import 'package:loadup/features/create_shipment/data/repos/centers_repo.dart';
import 'package:loadup/features/create_shipment/data/repos/governorates_repo.dart';
import 'package:loadup/features/create_shipment/data/repos/shipment_request_repo.dart';
import 'package:loadup/features/create_shipment/data/repos/users_repo.dart';
import 'package:loadup/features/create_shipment/logic/cubit/centers_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/governorates_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/shipment_request_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/users_cubit.dart';
import 'package:loadup/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:loadup/features/edit_profile/data/repos/edit_profile_repo.dart';
import 'package:loadup/features/edit_profile/logic/cubit/edit_profile_cubit.dart';
import 'package:loadup/features/my_shipping/data/datasource/pending_shipments_remote_data_source.dart';
import 'package:loadup/features/my_shipping/data/datasource/received_shipments_remote_data_source.dart';
import 'package:loadup/features/my_shipping/data/datasource/sent_shipments_remote_data_source.dart';
import 'package:loadup/features/my_shipping/data/repo/pending_shipments_repo.dart';
import 'package:loadup/features/my_shipping/data/repo/received_shipments_repo.dart';
import 'package:loadup/features/my_shipping/data/repo/sent_shipments_repo.dart';
import 'package:loadup/features/my_shipping/logic/cubit/pending_shipments_cubit.dart';
import 'package:loadup/features/my_shipping/logic/cubit/received_shipments_cubit.dart';
import 'package:loadup/features/my_shipping/logic/cubit/sent_shipments_cubit.dart';
import 'package:loadup/features/payment/data/datasources/create_payment_remote_data_source.dart';
import 'package:loadup/features/payment/data/datasources/payments_remote_data_source.dart';
import 'package:loadup/features/payment/data/repos/create_payment_repo.dart';
import 'package:loadup/features/payment/data/repos/payments_repo.dart';
import 'package:loadup/features/payment/logic/cubit/create_payment_cubit.dart';
import 'package:loadup/features/payment/logic/cubit/payments_cubit.dart';
import 'package:loadup/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:loadup/features/profile/data/repos/profile_repo.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';
import 'package:loadup/features/reset_password/data/datasources/reset_password_remote_data_source.dart';
import 'package:loadup/features/reset_password/data/repos/reset_password_repo.dart';
import 'package:loadup/features/reset_password/logic/cubit/reset_password_cubit.dart';
import 'package:loadup/features/shipment_details/data/datasources/checkpoints_remote_data_source.dart';
import 'package:loadup/features/shipment_details/data/repos/checkpoints_repo.dart';
import 'package:loadup/features/shipment_details/logic/cubit/checkpoints_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupGetit() async {
  getIt.registerLazySingleton(() => FirebaseMessaging.instance);

  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt()),
  );
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepo(networkInfo: getIt(), loginRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<SignUpRepo>(
    () => SignUpRepo(networkInfo: getIt(), signupRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(internetConnectionChecker: getIt()),
  );

  getIt.registerLazySingleton(() => CrudDio());

  final sharedPreference = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreference);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  getIt.registerFactory<LogoutCubit>(
    () => LogoutCubit(getIt()),
  );

  getIt.registerLazySingleton<LogoutRepo>(
    () => LogoutRepo(networkInfo: getIt(), logoutRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<LogoutRemoteDataSource>(
    () => LogoutRemoteDatasourceImp(dio: getIt()),
  );

  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(getIt()),
  );
  getIt.registerLazySingleton<ResetPasswordRemoteDataSource>(
    () => ResetPasswordRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<ResetPasswordRepo>(
    () => ResetPasswordRepo(
        networkInfo: getIt(), resetPasswordRemoteDataSource: getIt()),
  );

  getIt.registerFactory<ShipmentRequestCubit>(
    () => ShipmentRequestCubit(getIt()),
  );

  getIt.registerLazySingleton<ShipmentRequestRemoteDataSource>(
    () => ShipmentRequestRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<ShipmentRequestRepo>(
    () => ShipmentRequestRepo(
        networkInfo: getIt(), shipmentRequestRemoteDataSource: getIt()),
  );

  getIt.registerFactory<GovernoratesCubit>(
    () => GovernoratesCubit(getIt()),
  );

  getIt.registerLazySingleton<GovernoratesRemoteDataSource>(
    () => GovernoratesRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<GovernoratesRepo>(
    () => GovernoratesRepo(
        networkInfo: getIt(), governoratesRemoteDataSource: getIt()),
  );

  getIt.registerFactory<UsersCubit>(
    () => UsersCubit(getIt()),
  );

  getIt.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<UsersRepo>(
    () => UsersRepo(networkInfo: getIt(), usersRemoteDataSource: getIt()),
  );

  getIt.registerFactory<SentShipmentsCubit>(
    () => SentShipmentsCubit(getIt()),
  );

  getIt.registerLazySingleton<SentShipmentsRemoteDataSource>(
    () => SentShipmentsRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<SentShipmentsRepo>(
    () => SentShipmentsRepo(
        networkInfo: getIt(), sentshipmentsRemoteDataSource: getIt()),
  );

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt()),
  );

  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepo(networkInfo: getIt(), profileRemoteDataSource: getIt()),
  );

  getIt.registerFactory<EditProfileCubit>(
    () => EditProfileCubit(getIt()),
  );

  getIt.registerLazySingleton<EditProfileRemoteDataSource>(
    () => EditProfileRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<EditProfileRepo>(
    () => EditProfileRepo(
        networkInfo: getIt(), editprofileRemoteDataSource: getIt()),
  );

  getIt.registerFactory<CentersCubit>(
    () => CentersCubit(getIt()),
  );

  getIt.registerLazySingleton<CentersRemoteDataSource>(
    () => CentersRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<CentersRepo>(
    () => CentersRepo(networkInfo: getIt(), centersRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<ReceivedShipmentsRemoteDataSource>(
    () => ReceivedShipmentsRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<ReceivedShipmentsRepo>(
    () => ReceivedShipmentsRepo(
        networkInfo: getIt(), receivedShipmentsRemoteDataSource: getIt()),
  );

  getIt.registerFactory<ReceivedShipmentsCubit>(
    () => ReceivedShipmentsCubit(getIt()),
  );

  getIt.registerFactory<ComplaintsCubit>(
    () => ComplaintsCubit(getIt()),
  );

  getIt.registerLazySingleton<ComplaintsRemoteDataSource>(
    () => ComplaintsRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<ComplaintsRepo>(
    () => ComplaintsRepo(
        networkInfo: getIt(), complaintsRemoteDataSource: getIt()),
  );

  getIt.registerFactory<UpdateComplaintsCubit>(
    () => UpdateComplaintsCubit(getIt()),
  );

  getIt.registerLazySingleton<UpdateComplaintsRemoteDataSource>(
    () => UpdateComplaintsRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<UpdateComplaintsRepo>(
    () => UpdateComplaintsRepo(
        networkInfo: getIt(), updateComplaintsRemoteDataSource: getIt()),
  );

  getIt.registerFactory<CreateComplaintsCubit>(
    () => CreateComplaintsCubit(getIt()),
  );

  getIt.registerLazySingleton<CreateComplaintsRemoteDataSource>(
    () => CreateComplaintsRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<CreateComplaintRepo>(
    () => CreateComplaintRepo(
        networkInfo: getIt(), createComplaintsRemoteDataSource: getIt()),
  );

  getIt.registerFactory<DeleteComplaintCubit>(
      () => DeleteComplaintCubit(getIt()));

  getIt.registerLazySingleton<DeleteComplaintRemoteDataSource>(
    () => DeleteComplaintRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<DeleteComplaintRepo>(
    () => DeleteComplaintRepo(
        networkInfo: getIt(), deleteComplaintRemoteDataSource: getIt()),
  );

  getIt.registerFactory<CheckpointsCubit>(() => CheckpointsCubit(getIt()));

  getIt.registerLazySingleton<CheckpointsRemoteDataSource>(
    () => CheckpointsRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<CheckpointsRepo>(
    () => CheckpointsRepo(
        networkInfo: getIt(), checkpointsRemoteDataSource: getIt()),
  );

  getIt.registerFactory<PaymentsCubit>(
    () => PaymentsCubit(getIt()),
  );

  getIt.registerLazySingleton<PaymentsRemoteDataSource>(
    () => PaymentsRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<PaymentsRepo>(
    () => PaymentsRepo(
      networkInfo: getIt(),
      paymentsremoteDataSource: getIt(),
    ),
  );

  getIt.registerFactory<ApprovePriceCubit>(() => ApprovePriceCubit(getIt()));

  getIt.registerLazySingleton<ApprovePriceRemoteDataSource>(
    () => ApprovePriceRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<ApprovePriceRepo>(
    () => ApprovePriceRepo(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<PendingShipmentsRemoteDataSource>(
    () => PendingShipmentsRemoteDataSourceImp(dio: getIt()),
  );

  getIt.registerLazySingleton<PendingShipmentsRepo>(
    () => PendingShipmentsRepo(
        networkInfo: getIt(), pendingShipmentsRemoteDataSource: getIt()),
  );

  getIt.registerFactory<PendingShipmentsCubit>(
    () => PendingShipmentsCubit(getIt()),
  );
}
