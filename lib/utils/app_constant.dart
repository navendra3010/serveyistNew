int language = 0;

class AppConstantClass {
  static final RegExp emailValidatorRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
}

//this menu for admin panel dashboard
enum ButtomMenu {
  home,
  users,
  projectOverView,
  profile,
}

//this emuns function for userdashboard panel
enum ButtomMenu2 {
  userHome,
  userWorkHistory,
  progess,
  userprofile,
}
