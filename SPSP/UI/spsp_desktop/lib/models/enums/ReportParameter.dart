enum ReportQuarterParameter { Q1, Q2, Q3, Q4 }

enum ReportSubjectParameter { MENU_ITEM, CUSTOMER }

extension ReportQuarterParameterExtension on ReportQuarterParameter {
  String get value {
    switch (this) {
      case ReportQuarterParameter.Q1:
        return 'Prvi kvartal';
      case ReportQuarterParameter.Q2:
        return 'Drugi kvartal';
      case ReportQuarterParameter.Q3:
        return 'Treći kvartal';
      case ReportQuarterParameter.Q4:
        return 'Četvrti kvartal';
    }
  }
}

extension ReportSubjectParameterExtension on ReportSubjectParameter {
  String get value {
    switch (this) {
      case ReportSubjectParameter.MENU_ITEM:
        return 'Meni artikl';
      case ReportSubjectParameter.CUSTOMER:
        return 'Kupac';
    }
  }
}
