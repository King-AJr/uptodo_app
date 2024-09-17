import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/view-models/auth_vm.dart';

class Redirect extends StatefulWidget {
  const Redirect({Key? key}) : super(key: key);

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: FutureBuilder(
        future: Provider.of<AuthVm>(context).getUser(redirect: true),
        builder: (context, AsyncSnapshot snapshot) {
          return const Center(
            child: CircularProgressIndicator.adaptive(backgroundColor: appWhite),
          );
        },
      ),
    );
  }
}
