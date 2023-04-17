library backappx;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Project {
  static final String
      projectRef= '5f9f1b0b0b9b8c0017a5e1d1'; // this is the project reference that you get from the dashboard
  static final String
      stripeKey= 'sk_test_51Mb8mPF6RxBlwxAltBxdaTECgvWoYUWwLJvK82CMWWm7yB6bGC12GfqYZnhPcK8AMKtiqNtTdUb5LIlQzcGlmAij00zTqqwbov' ; //this is the stripe key that you get from the dashboard
  static final Project _instance = Project._internal();

  factory Project() {
    return _instance;
  }

  Project._internal();
}
