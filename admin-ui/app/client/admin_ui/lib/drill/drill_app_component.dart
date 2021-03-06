
import 'package:admin_ui/drill/controls/drill_controls_component.dart';
import 'package:admin_ui/drill/drill.dart';
import 'package:admin_ui/drill/drill_service.dart';
import 'package:admin_ui/drill/list/drill_list_component.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'kt-drill-app',
    templateUrl: 'drill_app_component.html',
    styleUrls: const ['drill_app_component.css'],
    directives: const [DrillControlsComponent, DrillListComponent],
    providers: const [DrillService]
)
class DrillAppComponent implements OnInit {

  final DrillService _drillService;
  final Router _router;

  final List<Drill> drills;
  final List<Drill> filteredDrills;

  DrillAppComponent(this._drillService, this._router)
      : drills = new List(), filteredDrills = new List() {
  }

  @override
  ngOnInit() {
    _loadDrills();
  }

  void setFilteredDrills(List<Drill> newFilteredDrills) {
    filteredDrills.clear();
    filteredDrills.addAll(newFilteredDrills);
  }

  void onDrillSelected(String drillId) {
    _router.navigate([
      'DrillDetail',
      { 'drillId': drillId }
    ]);
  }

  void _loadDrills() {
    drills.clear();
    _drillService.listDrills().then((loadedDrills) {
      drills.addAll(loadedDrills);
      filteredDrills.clear();
      filteredDrills.addAll(drills);
    });
  }
}