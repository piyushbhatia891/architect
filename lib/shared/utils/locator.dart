import 'package:architect/screens/drawing_detail/drawing_points_list.dart';
import 'package:architect/services/drawing/DrawingViewApi.dart';
import 'package:architect/services/drawing/DrawingViewModel.dart';
import 'package:architect/services/markings/MarkingViewApi.dart';
import 'package:architect/services/markings/MarkingViewModel.dart';
import 'package:architect/services/project/ProjectViewApi.dart';
import 'package:architect/services/project/ProjectViewModel.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt.instance;
void setUpLocator(){
  locator.registerLazySingleton(() => DrawingViewModel());
  locator.registerLazySingleton(() => DrawingPointsList());
  locator.registerLazySingleton(() => ProjectViewModel());
  locator.registerLazySingleton(() => MarkingViewModel());
  locator.registerLazySingleton(() => DrawingViewApi("projects"));
  locator.registerLazySingleton(() => ProjectViewApi("projects"));
  locator.registerLazySingleton(() => MarkingViewApi("projects"));
}