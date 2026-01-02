import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../features/buyer/parent/view_model/parent_view_model.dart';
import '../../features/seller/parent/presentation/view_model/seller_parent_screen_viewmodel.dart';

class AppViewModels {
  static final List<SingleChildWidget> viewmodels = [
    ChangeNotifierProvider<ParentViewModel>(create: (_) => ParentViewModel(),),
    ChangeNotifierProvider<SellerParentScreenViewmodel>(create: (_) => SellerParentScreenViewmodel(),),

  ];
}
