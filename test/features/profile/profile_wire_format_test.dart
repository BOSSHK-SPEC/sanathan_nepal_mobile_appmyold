import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_wire_format.dart';

void main() {
  group('date', () {
    test('converts between the app and the server', () {
      expect(ProfileWireFormat.dateToWire('2006/01/01'), '2006-01-01');
      expect(ProfileWireFormat.dateFromWire('1998-04-02'), '1998/04/02');
    });

    test('accepts either form, so an older cached value still converts', () {
      expect(ProfileWireFormat.dateToWire('2006-01-01'), '2006-01-01');
      expect(ProfileWireFormat.dateFromWire('1998/04/02'), '1998/04/02');
      expect(ProfileWireFormat.dateToWire(' 2006/1/5 '), '2006-01-05');
    });

    test('a date that does not exist is left out, not rolled over', () {
      expect(ProfileWireFormat.dateToWire('2006/02/30'), isNull);
      expect(ProfileWireFormat.dateToWire('2006/13/01'), isNull);
      expect(ProfileWireFormat.dateToWire('01/01/2006'), isNull);
      expect(ProfileWireFormat.dateToWire(''), isNull);
      expect(ProfileWireFormat.dateToWire(null), isNull);
    });
  });

  group('time', () {
    test('12-hour display becomes 24-hour HH:mm', () {
      expect(ProfileWireFormat.timeToWire('12:00:00 PM'), '12:00');
      expect(ProfileWireFormat.timeToWire('12:30:00 AM'), '00:30');
      expect(ProfileWireFormat.timeToWire('4:12:20 PM'), '16:12');
      expect(ProfileWireFormat.timeToWire('9:05 am'), '09:05');
      expect(ProfileWireFormat.timeToWire('16:12'), '16:12');
    });

    test('24-hour HH:mm becomes the picker\'s display', () {
      expect(ProfileWireFormat.timeFromWire('00:30'), '12:30:00 AM');
      expect(ProfileWireFormat.timeFromWire('12:00'), '12:00:00 PM');
      expect(ProfileWireFormat.timeFromWire('16:12'), '4:12:00 PM');
    });

    test('an impossible time is left out', () {
      expect(ProfileWireFormat.timeToWire('13:00 PM'), isNull);
      expect(ProfileWireFormat.timeToWire('0:15 AM'), isNull);
      expect(ProfileWireFormat.timeToWire('24:00'), isNull);
      expect(ProfileWireFormat.timeToWire('10:60'), isNull);
      expect(ProfileWireFormat.timeToWire('noon'), isNull);
      expect(ProfileWireFormat.timeToWire(null), isNull);
    });
  });
}
