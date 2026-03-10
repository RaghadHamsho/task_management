import 'dart:async';

extension GetDurationUtils on Duration {
  Future<void> get delay => Future.delayed(this);
}


