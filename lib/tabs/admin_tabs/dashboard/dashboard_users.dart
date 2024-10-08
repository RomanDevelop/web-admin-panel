import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_admin/mixins/users_mixin.dart';
import '../../../components/side_menu.dart';
import '../../../mixins/user_mixin.dart';
import '../../../models/user_model.dart';
import '../../../services/firebase_service.dart';
import '../../../pages/home.dart';

final dashboardUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  final List<UserModel> users = await FirebaseService().getLatestUsers(5);
  return users;
});

class DashboardUsers extends ConsumerWidget with UsersMixins{
  const DashboardUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(dashboardUsersProvider);
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.shade300,
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Users',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                  onPressed: () {
                    ref.read(menuIndexProvider.notifier).update((state) => 6);
                    ref.read(pageControllerProvider.notifier).state.jumpToPage(6);
                  },
                  child: const Text('View All'))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: users.when(
              data: (data) {
                return Column(
                  children: data.map((user) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      leading: UserMixin.getUserImageByUrl(imageUrl: user.imageUrl),
                      title: Text(user.name),
                      subtitle: getEmail(user, ref),
                    );
                  }).toList(),
                );
              },
              error: (a, b) => Container(),
              loading: () => Container(),
            ),
          )
        ],
      ),
    );
  }
}
