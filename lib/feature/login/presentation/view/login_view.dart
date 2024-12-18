import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopy_app/constants.dart';
import 'package:shopy_app/core/utils/app_router.dart';
import 'package:shopy_app/core/utils/cache_helper.dart';
import 'package:shopy_app/core/utils/service_locator.dart';
import 'package:shopy_app/feature/login/data/repos/login_repo_impl.dart';
import 'package:shopy_app/feature/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:shopy_app/feature/login/presentation/manger/login_cubit/login_state.dart';
import 'package:shopy_app/feature/login/presentation/view/widgets/build_login_view.dart';
import '../../../../core/functions/show_toast.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  //static var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(getIt.get<LoginRepoImpl>()),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              {
                if (state.model.status == false) {
                  showToast(text: state.model.message!, color: Colors.amber);
                } else {
                  showToast(text: state.model.message!, color: Colors.green);
                  CacheHelper.setData(
                      key: 'token', value: state.model.data!.token);
                  token = state.model.data!.token;
                  GoRouter.of(context).push(AppRouter.kHomeLayoutView);
                }
              }
            } else if (state is LoginFailureState) {
              showToast(text: state.errorMessage, color: Colors.red);
            }
          },
          builder: (context, state) {
            return BuildLoginView(cubit: LoginCubit.get(context));
          },
        ),
      ),
    );
  }
}
