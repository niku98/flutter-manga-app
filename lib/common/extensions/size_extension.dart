
import 'package:manga_app/common/screenutil/screenutil.dart';

extension SizeExtension on num {
  get w => ScreenUtil().setWidth(this);
  get h => ScreenUtil().setHeight(this);
  get sp => ScreenUtil().setSp(this);
}