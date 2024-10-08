import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../configs/app_config.dart';
import '../mixins/appbar_mixin.dart';
import '../providers/auth_state_provider.dart';
import '../tabs/admin_tabs/dashboard/dashboard.dart';
import '../tabs/admin_tabs/license_tab.dart';
import '../utils/reponsive.dart';
import '../components/side_menu.dart';
import '../mixins/user_mixin.dart';
import '../tabs/author_tabs/author_article_comments.dart';
import '../tabs/author_tabs/author_articles.dart';
import '../tabs/author_tabs/author_dashboard.dart';
import '../models/user_model.dart';
import '../providers/categories_provider.dart';
import '../providers/user_data_provider.dart';
import '../tabs/admin_tabs/ads_settings.dart';
import '../tabs/admin_tabs/app_settings/app_settings_view.dart';
import '../tabs/admin_tabs/categories/categories.dart';
import '../tabs/admin_tabs/articles/articles.dart';
import '../tabs/admin_tabs/featured_articles.dart';
import '../tabs/admin_tabs/notifications.dart';
import '../tabs/admin_tabs/purchases/purchases.dart';
import '../tabs/admin_tabs/comments/comments.dart';
import '../tabs/admin_tabs/tags.dart';
import '../tabs/admin_tabs/users/users.dart';

final pageControllerProvider = StateProvider<PageController>((ref) => PageController(initialPage: 0, keepPage: true));

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final List<Widget> _tabList = const [
    Dashboard(),
    Articles(),
    FeaturedArticles(),
    Categories(),
    Tags(),
    Comments(),
    Users(),
    Notifications(),
    Purchases(),
    AdsSettings(),
    AppSettings(),
    LicenseTab(),
  ];

  final List<Widget> _authorTabList = const [
    AuthorDashboard(),
    AuthorArticles(),
    AuthorArticleComments(),
  ];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ref.read(categoriesProvider.notifier).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(pageControllerProvider);
    final role = ref.watch(userRoleProvider);

    return Scaffold(
      backgroundColor: AppConfig.scffoldBgColor,
      key: scaffoldKey,
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
        role: role,
      ),
      body: Row(
        children: [
          Visibility(
            visible: Responsive.isDesktop(context) || Responsive.isDesktopLarge(context),
            child: Container(
                height: double.infinity,
                color: Colors.blue,
                child: SideMenu(
                  scaffoldKey: scaffoldKey,
                  role: role,
                )),
          ),
          Expanded(
            child: Column(
              children: [
                _AppTitleBar(
                  scaffoldKey: scaffoldKey,
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey.shade200,
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: role == UserRoles.author ? _authorTabList : _tabList,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AppTitleBar extends ConsumerWidget with AppBarMixin, UserMixin {
  const _AppTitleBar({
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel? user = ref.watch(userDataProvider);
    final String dashboardString = UserMixin.hasAuthorAccess(user) ? 'Author Dashboard' : "Admin Panel"; 
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 10 : 30),
      child: Row(
        children: [
          buildMenuButton(context, scaffoldKey: scaffoldKey),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${AppConfig.appName} $dashboardString',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          buildUserMenuButton(context, user: user, ref: ref)
        ],
      ),
    );
  }
}
