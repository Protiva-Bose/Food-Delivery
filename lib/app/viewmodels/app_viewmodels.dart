import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../core/di/di_config.dart';
import '../../features/home/presentation/viewmodel/home_viewmodel.dart';
import '../../features/parent/view_model/parent_view_model.dart';

class AppViewModels {
  static final List<SingleChildWidget> viewmodels = [
    ChangeNotifierProvider<ParentViewModel>(create: (_) => ParentViewModel(),),

    // Add other feature viewmodels/providers here
  ];
}
