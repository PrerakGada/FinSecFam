// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:finsec/features/auth/login_screen.dart' as _i2;
import 'package:finsec/features/auth/register_screen.dart' as _i6;
import 'package:finsec/features/main/main_scaffold_screen.dart' as _i3;
import 'package:finsec/features/onboarding/onboarding_info.dart' as _i4;
import 'package:finsec/features/onboarding/onboarding_screen.dart' as _i5;
import 'package:finsec/features/onboarding/splash_screen.dart' as _i7;
import 'package:finsec/features/profile/transfer/enter_money_screen.dart'
    as _i1;
import 'package:finsec/features/profile/transfer/transfer.dart' as _i8;
import 'package:flutter/cupertino.dart' as _i11;
import 'package:flutter/material.dart' as _i10;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    EnterMoneyRoute.name: (routeData) {
      final args = routeData.argsAs<EnterMoneyRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.EnterMoneyScreen(
          key: args.key,
          scannedData: args.scannedData,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.LoginScreen(key: args.key),
      );
    },
    MainScaffoldRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MainScaffoldScreen(),
      );
    },
    OnboardingInfoRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.OnboardingInfoScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.OnboardingScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.RegisterScreen(key: args.key),
      );
    },
    SplashRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SplashScreen(),
      );
    },
    TransferRoute.name: (routeData) {
      final args = routeData.argsAs<TransferRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.TransferScreen(
          key: args.key,
          id: args.id,
          balance: args.balance,
          name: args.name,
          photo: args.photo,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.EnterMoneyScreen]
class EnterMoneyRoute extends _i9.PageRouteInfo<EnterMoneyRouteArgs> {
  EnterMoneyRoute({
    _i10.Key? key,
    required List<String> scannedData,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          EnterMoneyRoute.name,
          args: EnterMoneyRouteArgs(
            key: key,
            scannedData: scannedData,
          ),
          initialChildren: children,
        );

  static const String name = 'EnterMoneyRoute';

  static const _i9.PageInfo<EnterMoneyRouteArgs> page =
      _i9.PageInfo<EnterMoneyRouteArgs>(name);
}

class EnterMoneyRouteArgs {
  const EnterMoneyRouteArgs({
    this.key,
    required this.scannedData,
  });

  final _i10.Key? key;

  final List<String> scannedData;

  @override
  String toString() {
    return 'EnterMoneyRouteArgs{key: $key, scannedData: $scannedData}';
  }
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i9.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i11.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<LoginRouteArgs> page =
      _i9.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.MainScaffoldScreen]
class MainScaffoldRoute extends _i9.PageRouteInfo<void> {
  const MainScaffoldRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MainScaffoldRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainScaffoldRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.OnboardingInfoScreen]
class OnboardingInfoRoute extends _i9.PageRouteInfo<void> {
  const OnboardingInfoRoute({List<_i9.PageRouteInfo>? children})
      : super(
          OnboardingInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingInfoRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.OnboardingScreen]
class OnboardingRoute extends _i9.PageRouteInfo<void> {
  const OnboardingRoute({List<_i9.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterScreen]
class RegisterRoute extends _i9.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i9.PageInfo<RegisterRouteArgs> page =
      _i9.PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.TransferScreen]
class TransferRoute extends _i9.PageRouteInfo<TransferRouteArgs> {
  TransferRoute({
    _i10.Key? key,
    required String id,
    required double balance,
    required String name,
    required String photo,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          TransferRoute.name,
          args: TransferRouteArgs(
            key: key,
            id: id,
            balance: balance,
            name: name,
            photo: photo,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferRoute';

  static const _i9.PageInfo<TransferRouteArgs> page =
      _i9.PageInfo<TransferRouteArgs>(name);
}

class TransferRouteArgs {
  const TransferRouteArgs({
    this.key,
    required this.id,
    required this.balance,
    required this.name,
    required this.photo,
  });

  final _i10.Key? key;

  final String id;

  final double balance;

  final String name;

  final String photo;

  @override
  String toString() {
    return 'TransferRouteArgs{key: $key, id: $id, balance: $balance, name: $name, photo: $photo}';
  }
}
