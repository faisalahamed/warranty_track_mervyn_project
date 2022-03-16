class MyDateCalculation {
  String timestampToDate(String datetime) {
    if (datetime == 'Lifetime') {
      return datetime;
    }
    if (datetime == '0') {
      return 'No Warranty';
    }
    int? date = int.tryParse(datetime);

    if (date == null) {
      return 'invalid date selected';
    } else {
      var x = DateTime.fromMillisecondsSinceEpoch(date);
      var y = x.year;
      var m = getCurrentMonthName(x.month);
      var d = x.day;
      return '$d $m $y';
    }
  }

  String remainingDays(String date) {
    if (date == 'Lifetime') {
      return date;
    }
    int? intdate = int.tryParse(date);

    if (intdate == null) {
      return 'invalid date conversion';
    } else {
      var nowInt = DateTime.now().millisecondsSinceEpoch;

      var n = DateTime.fromMillisecondsSinceEpoch(intdate);
      var z = DateTime.fromMillisecondsSinceEpoch(nowInt);
      // print(n.difference(z).inDays);
      var days = n.difference(z).inDays;
      if (days < 0) {
        return '0';
      } else {
        if (days > 365) {
          // int year = days ~/ 365;
          // int cdays = days % 365;
          // return year.toString() + ' Year ' + cdays.toString() + ' Days';
          return days.toString();
        } else {
          return days.toString();
        }
      }
      // return 'invalid date conversion';
    }
  }

  String getCurrentMonthName(int number) {
    String month = '';
    switch (number) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June ";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }
    return month;
  }

  // static String formatDate(int timestamp) {
  //   DateTime val = DateTime.fromMillisecondsSinceEpoch(timestamp);
  //   return '${val.day}  ${getNextMonthName(val.month)} ${val.year}';
  // }
  bool showArchive(String date, bool isArchived) {
    int? intdate = int.tryParse(date);

    if (intdate == null) {
      return false;
    } else {
      var nowInt = DateTime.now().millisecondsSinceEpoch;

      var n = DateTime.fromMillisecondsSinceEpoch(intdate);
      var z = DateTime.fromMillisecondsSinceEpoch(nowInt);
      // print(n.difference(z).inDays);
      var days = n.difference(z).inDays;
      if (days < 0 && !isArchived) {
        return true;
      } else {
        return false;
      }
      // return 'invalid date conversion';
    }
  }

  bool showUnArchive(String date, bool isArchived) {
    int? intdate = int.tryParse(date);

    if (intdate == null) {
      return false;
    } else {
      var nowInt = DateTime.now().millisecondsSinceEpoch;

      var n = DateTime.fromMillisecondsSinceEpoch(intdate);
      var z = DateTime.fromMillisecondsSinceEpoch(nowInt);
      // print(n.difference(z).inDays);
      var days = n.difference(z).inDays;
      if (days < 0 && isArchived) {
        return true;
      } else {
        return false;
      }
      // return 'invalid date conversion';
    }
  }
}
