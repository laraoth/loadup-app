import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/di/dependency_injection.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/logic/cubit/login_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/signup_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/complaints_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/create_complaints_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/delete_complaint_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/update_complaint_cubit.dart';
import 'package:loadup/features/complaints/presentation/screens/complaints_screen.dart';
import 'package:loadup/features/complaints/presentation/screens/complaints_screen_selector.dart';
import 'package:loadup/features/complaints/presentation/screens/complaints_view_screen.dart';
import 'package:loadup/features/create_shipment/logic/cubit/centers_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/governorates_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/shipment_request_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/users_cubit.dart';
import 'package:loadup/features/create_shipment/presentation/screens/centers_screen.dart';
import 'package:loadup/features/create_shipment/presentation/screens/create_shipment_screen.dart';
import 'package:loadup/features/create_shipment/presentation/screens/governorates_screen.dart';
import 'package:loadup/features/create_shipment/presentation/screens/users_screen.dart';
import 'package:loadup/features/edit_profile/logic/cubit/edit_profile_cubit.dart';
import 'package:loadup/features/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/features/my_shipping/logic/cubit/pending_shipments_cubit.dart';
import 'package:loadup/features/my_shipping/logic/cubit/received_shipments_cubit.dart';
import 'package:loadup/features/my_shipping/logic/cubit/sent_shipments_cubit.dart';
import 'package:loadup/features/my_shipping/presentation/screens/pending_shipments_screen.dart';
import 'package:loadup/features/my_shipping/presentation/screens/received_shipment_details_screen.dart';
import 'package:loadup/features/my_shipping/presentation/screens/received_shipments_screen.dart';
import 'package:loadup/features/payment/logic/cubit/create_payment_cubit.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';
import 'package:loadup/features/profile/presentation/screens/profile_screen.dart';
import 'package:loadup/features/get_started/presentation/screens/get_started_screen.dart';
import 'package:loadup/features/home/presentation/screens/home_screen.dart';
import 'package:loadup/features/auth/presentation/screens/login_screen.dart';
import 'package:loadup/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:loadup/features/my_shipping/presentation/screens/sent_shipments_screen.dart';
import 'package:loadup/features/reset_password/logic/cubit/reset_password_cubit.dart';
import 'package:loadup/features/reset_password/presentation/screens/reset_password_screen.dart';
import 'package:loadup/features/settings/presentation/screens/settings_screen.dart';
import 'package:loadup/features/shipment_details/logic/cubit/checkpoints_cubit.dart';
import 'package:loadup/features/shipment_details/presentation/screens/map_screen.dart';
import 'package:loadup/features/shipment_details/presentation/screens/shipment_details_screen.dart';
import 'package:loadup/features/wallet/logic/cubit/payment_cubit.dart';
import 'package:loadup/features/wallet/presentation/screens/wallet_screen.dart';

import '../public_widgets/custom_bottom_navigation_bar.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.getStartedScreen:
        return MaterialPageRoute(
          builder: (_) => GetStartedScreen(),
        );

      case Routes.mapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<CheckpointsCubit>(),
            child: const MapScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<LogoutCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<ProfileCubit>(),
              ),
            ],
            child: const ProfileScreen(),
          ),
        );

      case Routes.resetpasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: const ResetPasswordScreen(),
          ),
        );

      case Routes.editprofileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<EditProfileCubit>(),
            child: const EditProfileScreen(),
          ),
        );
      case Routes.complaintsViewScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<ComplaintsCubit>()..getcomplaints(),
              ),
              BlocProvider(
                create: (context) => getIt<UpdateComplaintsCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<DeleteComplaintCubit>(),
              ),
            ],
            child: ComplaintsViewScreen(),
          ),
        );

      case Routes.walletScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<PaymentsCubit>(),
            child: const WalletScreen(),
          ),
        );

      case Routes.customBottomNavigationBar:
        return MaterialPageRoute(
          builder: (_) => CustomBottomNavigationBar(currentIndex: 0),
        );
      case Routes.complaintsScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CreateComplaintsCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<ReceivedShipmentsCubit>(),
              ),
            ],
            child: const ComplaintsScreen(),
          ),
        );
      case Routes.myShipping:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SentShipmentsCubit>(),
            child: const MyShippingScreen(),
          ),
        );

      case Routes.receivedShipmentsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ReceivedShipmentsCubit>(),
            child: const ReceivedShipmentsScreen(),
          ),
        );
      case Routes.shipmentRequestScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<ShipmentRequestCubit>()),
              BlocProvider(create: (context) => getIt<UsersCubit>()),
              BlocProvider(create: (context) => getIt<CentersCubit>()),
              BlocProvider(create: (context) => getIt<GovernoratesCubit>()),
            ],
            child: CreateShipmentScreen(),
          ),
        );

      case Routes.userSelectionScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UsersCubit>(),
            child: UsersSelectionScreen(),
          ),
        );

      case Routes.governorateSelectionScreen:
        final isOrigin = settings.arguments as bool? ?? true;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<GovernoratesCubit>(),
            child: GovernorateSelectionScreen(isOrigin: isOrigin),
          ),
        );

      case Routes.centerSelectionScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final isOrigin = args['isOrigin'] as bool? ?? true;
        final governorateId = args['governorateId'] as int?;

        if (governorateId == null) {
          throw Exception("Governorate ID is required for center selection");
        }

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<ShipmentRequestCubit>()),
              BlocProvider(create: (_) => getIt<CentersCubit>()),
            ],
            child: CenterSelectionScreen(
              isOrigin: isOrigin,
              governorateId: governorateId,
            ),
          ),
        );

      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );
      case Routes.sentShipmentDetailsScreen:
        final shipment = settings.arguments as ShipmentDatum;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SentShipmentsCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<ApprovePriceCubit>(),
              ),
            ],
            child: SentShipmentDetailsScreen(
              shipment: shipment,
            ),
          ),
        );

      case Routes.receivedShipmentDetailsScreen:
        final shipment = settings.arguments as ShipmentDatum;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ReceivedShipmentsCubit>(),
            child: ReceivedShipmentDetailsScreen(
              shipment: shipment,
            ),
          ),
        );
      case Routes.complaintsScreenSelector:
        return MaterialPageRoute(
          builder: (_) => ComplaintsScreenSelector(),
        );

      // في app_router.dart
      case Routes.pendingShipmentsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<PendingShipmentsCubit>(),
            child: const PendingShipmentsScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Routes'),
            ),
          ),
        );
    }
  }
}
