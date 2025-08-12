import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/features/create_shipment/data/models/users_model.dart';
import 'package:loadup/features/create_shipment/logic/cubit/users_cubit.dart';

class UsersSelectionScreen extends StatefulWidget {
  const UsersSelectionScreen({Key? key}) : super(key: key);

  @override
  State<UsersSelectionScreen> createState() => _UsersSelectionScreenState();
}

class _UsersSelectionScreenState extends State<UsersSelectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().getUsers(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Choose the receiver')),
        body: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return LoadingWidget();
            } else if (state is UsersSuccess) {
              final usersCubit = context.read<UsersCubit>();
              final List<UserDatum> users = state.usersModel.data;

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: users.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = users[index];
                        return ListTile(
                          title: Text(item.name),
                          onTap: () {
                            Navigator.pop(context, item);
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: usersCubit.currentPage > 1
                            ? () => usersCubit.previousPage()
                            : null,
                        child: const Text("pre"),
                      ),
                      Text("page ${usersCubit.currentPage}"),
                      TextButton(
                        onPressed: () => usersCubit.nextPage(),
                        child: const Text("next"),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is UsersError) {
              return Center(child: Text(state.error));
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
