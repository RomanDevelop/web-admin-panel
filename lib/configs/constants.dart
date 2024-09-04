import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';

// --------- Don't edit these -----------

const String notificationTopicForAll = 'all';

const Map<int, List<dynamic>> menuList = {
  0: ['Dashboard', LineIcons.pieChart],
  1: ['Articles', LineIcons.list],
  2: ['Featured', LineIcons.bomb],
  3: ['Categories', CupertinoIcons.grid],
  4: ['Tags', LineIcons.tags],
  5: ['Comments', LineIcons.comment],
  6: ['Users', LineIcons.userFriends],
  7: ['Notifications', LineIcons.bell],
  8: ['Purchases', LineIcons.receipt],
  9: ['Ads', LineIcons.dollarSign],
  10: ['Settings', CupertinoIcons.settings],
  11: ['License', LineIcons.key],
};

const Map<int, List<dynamic>> menuListAuthor = {
  0: ['Dashboard', LineIcons.pieChart],
  1: ['My Articles', LineIcons.list],
  2: ['Comments', LineIcons.comment],
};

const Map<String, String> articleStatus = {'draft': 'Draft', 'pending': 'Pending', 'live': 'Live', 'archive': 'Archived'};

const Map<String, String> contentTypes = {'normal': "Normal" ,'video': 'Video', 'audio': 'Audio'};

const Map<String, String> priceStatus = {'free': 'Free', 'premium': 'Premium'};

const Map<String, String> sortByArticle = {
  'all': 'All',
  'live': 'Published',
  'draft': 'Drafts',
  'pending': 'Pending',
  'archive': 'Archived',
  'featured': 'Featured Articles',
  'new': 'Newest First',
  'old': 'Oldest First',
  'free': 'Free Articles',
  'premium': 'Premium Articles',
  'popular': 'Most Viewed',
  'liked': 'Most Liked',
  'category': 'Category',
  'author': 'Author',
};

const Map<String, String> sortByUsers = {
  'all': 'All',
  'new': 'Newest First',
  'old': 'Oldest First',
  'admin': 'Admins',
  'author': 'Authors',
  'disabled': "Disabled Users",
  'subscribed': "Subscribed Users",
  'android': 'Android Users',
  'ios': 'iOS Users'
};

const Map<String, String> sortByComments = {
  'all': 'All',
  'new': 'Newest First',
  'old': 'Oldest First',
};

const Map<String, String> sortByPurchases = {
  'all': 'All',
  'new': 'Newest First',
  'old': 'Oldest First',
  'active': 'Active',
  'expired': 'Expired',
  'android': 'Android Platform',
  'ios': 'iOS Platform',
};

const Map<String, String> userMenus = {
  'edit': 'Edit Profile',
  'password': 'Change Password',
  'logout': 'Logout',
};

const Map<String, String> postDetailsLayoutTypes = {
  'random': 'Random',
  'layout-1': 'Post Details Layout 1',
  'layout-2': 'Post Details Layout 2',
  'layout-3': 'Post Details Layout 3',
};

const Map<String, String> categoryTileLayoutTypes = {
  'grid': 'Category Grid Tile',
  'list': 'Category List Tile',
};
