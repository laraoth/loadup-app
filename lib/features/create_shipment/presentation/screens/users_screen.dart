import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
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
    final cubit = context.read<UsersCubit>();

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('Choose the receiver'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cubit.searchController,
              decoration: InputDecoration(
                hintText: context.tr("Search users..."),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    cubit.searchUsers(cubit.searchController.text.trim());
                  },
                ),
              ),
              onSubmitted: (value) {
                cubit.searchUsers(value.trim());
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<UsersCubit, UsersState>(
              builder: (context, state) {
                if (state is UsersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UsersSuccess) {
                  final users = state.usersModel.data;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: users!.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = users[index];
                            return ListTile(
                              title: Text(item.name ?? ''),
                              onTap: () => Navigator.pop(context, item),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: cubit.currentPage > 1
                                ? cubit.previousPage
                                : null,
                            child: Text(context.tr("Previous")),
                          ),
                          Text(context.tr("Page ${cubit.currentPage}")),
                          TextButton(
                            onPressed: cubit.nextPage,
                            child: Text(context.tr("Next")),
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
            ),
          ),
        ],
      ),
    );
  }
}
