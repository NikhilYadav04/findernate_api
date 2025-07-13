//* API endpoints matching your Node.js backend routes exactly
class ApiEndpoints {
  //* Authentication endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // //* User endpoints
  // static const String users = '/users';
  // static const String userProfile = '/user/profile';
  // static const String updateProfile = '/user/profile';

  // //* Wallet endpoints
  // static const String addWalletBalance = '/user/wallet/add';
  // static const String getWalletHistory = '/user/wallet/history';
  // static const String withdrawWallet = '/user/wallet/withdraw';

  // //* User management endpoints
  // static const String verifyAccount = '/user/verify';
  // static const String changePassword = '/user/change-password';
  // static const String deleteAccount = '/user/delete';

  // //* Admin endpoints (for admin role)
  // static const String getAllUsers = '/admin/users';
  // static const String banUser = '/admin/ban-user';
  // static const String unbanUser = '/admin/unban-user';
  // static const String blockUser = '/admin/block-user';
  // static const String unblockUser = '/admin/unblock-user';
  // static const String promoteToExpert = '/admin/promote-expert';

  // //* Posts endpoints (if you have posts in your app)
  // static const String posts = '/posts';
  // static const String createPost = '/posts';

  // //* Dynamic endpoints
  static String getUserById(String id) => '/getUser/$id';
  static String postById(String id) => '/posts/$id';
  static String userPosts(String userId) => '/users/$userId/posts';

  //* Experts
  static const String getAllExperts = '/allExperts';
}
