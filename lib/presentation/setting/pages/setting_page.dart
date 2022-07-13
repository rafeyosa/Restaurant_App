import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/cubits/setting/setting_cubit.dart';

import '../../../constant/common_constant.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SettingCubit>(context);
    cubit.getPreferenceSetting(prefsSettingKey);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text('Setting'),
        ),
        body: ListView(
          children: [
            ListTile(
                title: const Text('Restaurant Notification'),
                subtitle: const Text('Enable Notification'),
                trailing: BlocBuilder<SettingCubit, SettingState>(
                  builder: (context, state) {
                    return Switch.adaptive(
                      value: state.isScheduled,
                      onChanged: (value) async {
                        cubit.scheduledRestaurant(value);
                        cubit.setPreferenceSetting(prefsSettingKey,value);
                      },
                    );
                  },
                )
            ),
          ],
        )
    );
  }

}