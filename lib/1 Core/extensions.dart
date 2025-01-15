import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';

extension DurationFormatting on Duration {
  String integer2() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(inMinutes);
    final seconds = twoDigits(inSeconds.remainder(60));

    return [minutes, seconds].join(':');
  }

  String integer3() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(inHours);
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));

    return [hours, minutes, seconds].join(':');
  }

  String integerDynamic() {
    if (inHours != 0) {
      return integer3();
    } else {
      return integer2();
    }
  }

  String textLong2() {
    final minutes = inMinutes;
    final seconds = inSeconds.remainder(60);

    return "$minutes ${LocaleKeys.Minute.tr()} $seconds ${LocaleKeys.Second.tr()}";
  }

  String textLong3() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    return "$hours ${LocaleKeys.Hour.tr()} $minutes ${LocaleKeys.Minute.tr()} $seconds ${LocaleKeys.Second.tr()}";
  }

  String textLongDynamic() {
    if (inHours != 0) {
      return textLong3();
    } else {
      return textLong2();
    }
  }

  String textShort2() {
    final minutes = inMinutes;
    final seconds = inSeconds.remainder(60);

    return "$minutes${LocaleKeys.m.tr()} $seconds${LocaleKeys.s.tr()}";
  }

  String textShort2hour() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);

    return "$hours${LocaleKeys.h.tr()} $minutes${LocaleKeys.m.tr()}";
  }

  String textShort3() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    return "$hours${LocaleKeys.h.tr()} $minutes${LocaleKeys.m.tr()} $seconds${LocaleKeys.s.tr()}";
  }

  String textShortDynamic() {
    if (inHours != 0) {
      return textShort3();
    } else {
      return textShort2();
    }
  }

  String textLongDynamicWithoutZero() {
    final seconds = inSeconds.remainder(60);
    final minutes = inMinutes.remainder(60);
    final hours = inHours;

    if (hours > 0 && minutes > 0 && seconds == 0) {
      return "$hours${LocaleKeys.h.tr()} $minutes${LocaleKeys.m.tr()}";
    } else if (hours == 0 && minutes > 0 && seconds == 0) {
      return "$minutes${LocaleKeys.m.tr()}";
    } else if (hours > 0 && minutes == 0 && seconds == 0) {
      return "$hours${LocaleKeys.h.tr()}";
    } else if (hours == 0 && minutes == 0 && seconds > 0) {
      return "$seconds${LocaleKeys.s.tr()}";
    } else if (hours == 0 && minutes > 0 && seconds > 0) {
      return "$minutes${LocaleKeys.m.tr()} $seconds${LocaleKeys.s.tr()}";
    } else {
      return "$hours${LocaleKeys.h.tr()} $minutes${LocaleKeys.m.tr()} $seconds${LocaleKeys.s.tr()}";
    }
  }

  String toLevel() {
    // TODO direkt her 15 saat 1 lvl olmasın. 1.1x olarak daha zorlaşsın mesela lvl atlamak veya 10,20,35,50,70,100 gibi manuel kontrol

    return "${inHours ~/ 15} LVL";
  }

  Duration operator /(int value) {
    if (inSeconds == 0) {
      return Duration.zero;
    }

    return Duration(
      hours: inHours ~/ value,
      minutes: (inMinutes ~/ value) % 60,
      seconds: (inSeconds ~/ value) % 60,
    );
  }
}

extension IntFormatting on int {
  String secondToTime() {
    final int hours = this ~/ 3600;
    final int minutes = this % 3600 ~/ 60;
    final int remainingSeconds = this % 60;

    return "${hours}h ${minutes}m ${remainingSeconds}s";
  }
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
