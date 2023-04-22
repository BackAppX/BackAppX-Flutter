library backappx;

class Project {
  static final String
      projectRef= ''; // this is the project reference that you get from the dashboard
  static final String
      stripeKey= '' ; //this is the stripe key that you get from the dashboard
  static final Project _instance = Project._internal();
  factory Project() {
    return _instance;
  }
  Project._internal();
}
