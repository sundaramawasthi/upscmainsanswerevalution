enum UserRole { user, admin, evaluator }

String roleToString(UserRole role) {
  switch (role) {
    case UserRole.admin:
      return 'admin';
    case UserRole.evaluator:
      return 'evaluator';
    case UserRole.user:
    default:
      return 'user';
  }
}
