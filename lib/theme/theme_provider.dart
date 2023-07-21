import 'package:flutter/material.dart';
import 'color.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode;
  Gradient? _darkGradient;
  Gradient? _lightGradient;
  Gradient? _cardGradientDark;
  Gradient? _cardGradientLight;
  Gradient? _signupButtonBackgroundDark;
  Gradient? _signupButtonBackgroundLight;
  Gradient? _signupBackgroundDark;
  Gradient? _signupBackgroundLight;
  Color? _textColors;
  Color? _textColors2;
  Color? lightGradientTextColor;
  Gradient? _containerDark;
  Gradient? _containerLight;
  Gradient? _loginContainerDark;
  Gradient? _loginContainerLight;
  Gradient? _bookAppointmentButtonDark;
  Gradient? _bookAppointmentButtonLight;
  Gradient? _luckyDetailGradientDark;
  Gradient? _luckyDetailGradientLight;
  Gradient? _appBarDarkGradient;
  Gradient? _appBarLightGradient;
  Gradient? _whiteLiteContainerDark;
  Gradient? _whiteLiteContainerLight;
  Color? _tabDarkBackground;
  Color? _tabLightBackground;
  Color? _tabBarDarkColor;
  Color? _tabBarLightColor;
  Color? _tabUnSelectedLabelColorDark;
  Color? _tabUnSelectedLabelColorLight;
  Color? _tabBackground2Dark;
  Color? _tabBackground2Light;
  Color? _bookAppointmentBackgroundLight;
  Color? _bookAppointmentBackgroundDark;
  Color? _aboutIconColorDark;
  Color? _aboutIconColorLight;
  Color? aboutIconColorDark;
  Color? _reviewBackgroundDark;
  Color? _reviewBackgroundLight;
  Color? _reviewBackground2Dark;
  Color? _reviewBackground2Light;
  Color? _panchangaBackgroundDark;
  Color? _panchangaBackgroundLight;
  Color? _bottomNavigationIconColorDark;
  Color? _bottomNavigationIconColorLight;
  Color? _iconColorWhiteDark;
  Color? _iconColorBlackLight;
  Color? _calenderBorderLight;
  Color? _calenderBorderDark;
  Color? _whiteTextColorDark;
  Color? _whiteTextColorLight;
  Color? _horosCopRedColorDark;
  Color? _horosCopPurpuleColorLight;
 Color? _todaycolor;
  Color? selectedtodaycolor;
  Color? eventcolor;
  Color? event2color;
  ThemeProvider(
    this._isDarkMode,
  ) {
    _bookAppointmentButtonDark = const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(137, 55, 255, 1.0),
        Color.fromRGBO(232, 91, 255, 1.0),
      ],
      // Define gradient colors for the dark theme
    );

    _bookAppointmentButtonLight = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(243, 115, 53, 1.0),
        Color.fromRGBO(248, 216, 148, 1.0),
      ],
      // Define gradient colors for the dark theme
    );

    _whiteLiteContainerDark = const LinearGradient(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(110, 55, 255, 0.15),
        Color.fromRGBO(200, 91, 255, 0.15)
      ],
      // Define gradient colors for the light theme
    );

    _whiteLiteContainerLight = const LinearGradient(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(247, 243, 244, 1.0),
        Color.fromRGBO(247, 243, 244, 1.0),
      ],
      // Define gradient colors for the light theme
    );

    _loginContainerDark = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(180, 122, 248, 1.0),
        Color.fromRGBO(232, 91, 255, 1.0),
      ],
      // Define gradient colors for the dark theme
    );
    _loginContainerLight = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(255, 255, 255, 1),
        Color.fromRGBO(255, 255, 255, 1),
      ],
      // Define gradient colors for the dark theme
    );

    _signupBackgroundDark = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(250, 250, 253, 0.14901960784313725),
        Color.fromRGBO(250, 250, 253, 0.14901960784313725),
      ],
      // Define gradient colors for the dark theme
    );
    _signupBackgroundLight = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(243, 115, 53, 1.0),
        Color.fromRGBO(248, 216, 148, 1.0),
      ],
      // Define gradient colors for the dark theme
    );

    _signupButtonBackgroundDark = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(255, 255, 255, 1),
        Color.fromRGBO(255, 255, 255, 1),
      ],
      // Define gradient colors for the dark theme
    );
    _signupButtonBackgroundLight = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(255, 255, 255, 1),
        Color.fromRGBO(255, 255, 255, 1),
      ],
      // Define gradient colors for the dark theme
    );

    _appBarDarkGradient = const LinearGradient(
      begin: Alignment.center,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(137, 55, 255, 1.0),
        Color.fromRGBO(180, 90, 250, 1.0)
      ],
      // Define gradient colors for the dark theme
    );
    _appBarLightGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
      colors: [
        Color.fromRGBO(243, 115, 53, 1.0),
        Color.fromRGBO(248, 216, 148, 1.0),
      ],
      // Define gradient colors for the dark theme
    );
    _darkGradient = const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(137, 55, 255, 1.0),
        Color.fromRGBO(232, 91, 255, 1.0),
      ],
      // Define gradient colors for the dark theme
    );

    _lightGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(243, 115, 53, 1),
        Color.fromRGBO(243, 115, 53, 1)
      ],
      // Define gradient colors for the light theme
    );
    _luckyDetailGradientDark = const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(180, 122, 248, 1.0),
        Color.fromRGBO(232, 91, 255, 1.0),
      ],
      // Define gradient colors for the light theme
    );
    _luckyDetailGradientLight = const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(254, 46, 29, 1.0),
        Color.fromRGBO(254, 46, 29, 1.0),
      ],
      // Define gradient colors for the light theme
    );
    _cardGradientDark = const LinearGradient(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(110, 55, 255, 0.15),
        Color.fromRGBO(200, 91, 255, 0.15)
      ],
      // Define gradient colors for the light theme
    );
    _cardGradientLight = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(255, 255, 255, 0.85),
        Color.fromRGBO(255, 255, 255, 0.85)
      ],
      // Define gradient colors for the light theme
    );

    _containerDark = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(31, 31, 66, 1),
        Color.fromRGBO(31, 31, 66, 1),
      ],
      // Define gradient colors for the light theme
    );
    aboutIconColorDark = const Color.fromRGBO(232, 91, 255, 1);
    _textColors = const Color.fromRGBO(255, 255, 255, 0.85);
    _textColors2 = const Color.fromRGBO(218, 216, 216, 1.0);
    lightGradientTextColor = const Color.fromRGBO(249, 90, 0, 1);
    //_cornerDark = const Color.fromRGBO(255, 255, 255, 0.85);
    _tabDarkBackground = const Color.fromRGBO(31, 31, 66, 1.0);
    _tabLightBackground = const Color.fromRGBO(255, 255, 255, 0.85);
    _tabBarDarkColor = const Color.fromRGBO(212, 98, 248, 1.0);
    _tabBarLightColor = const Color.fromRGBO(243, 115, 53, 1.0);
    _tabUnSelectedLabelColorDark = const Color.fromRGBO(255, 255, 255, 1);
    _tabUnSelectedLabelColorLight =
        const Color.fromRGBO(0, 0, 0, 0.8509803921568627);
    _tabBackground2Dark = const Color.fromRGBO(137, 55, 255, 0.15);
    _tabBackground2Light = const Color.fromRGBO(247, 243, 244, 1.0);
    _bookAppointmentBackgroundDark =
        const Color.fromRGBO(250, 250, 253, 0.14901960784313725);
    _bookAppointmentBackgroundLight = const Color.fromRGBO(247, 243, 244, 1.0);
    _aboutIconColorDark = const Color.fromRGBO(137, 55, 255, 1.0);
    _aboutIconColorLight = const Color.fromRGBO(254, 46, 29, 1.0);
    // _aboutIconColorLight = const Color.fromRGBO(31, 31, 66, 1);
    _reviewBackgroundDark =
        const Color.fromRGBO(45, 45, 45, 0.5803921568627451);
    _reviewBackground2Dark =
        const Color.fromRGBO(173, 146, 210, 0.15294117647058825);
    _panchangaBackgroundDark = const Color.fromRGBO(150, 150, 150, 1.0);
    _bottomNavigationIconColorDark = const Color.fromRGBO(137, 55, 255, 1);
    _bottomNavigationIconColorLight = const Color.fromRGBO(249, 90, 0, 1);
    _iconColorWhiteDark = const Color.fromRGBO(255, 255, 255, 0.85);
    _iconColorBlackLight = const Color.fromRGBO(0, 0, 0, 0.8509803921568627);
    _calenderBorderDark = const Color.fromRGBO(150, 150, 150, 1.0);
    _calenderBorderLight = const Color.fromRGBO(218, 216, 216, 1.0);
    _whiteTextColorDark = const Color.fromRGBO(255, 255, 255, 1);
    _whiteTextColorLight = const Color.fromRGBO(255, 255, 255, 1);
    _horosCopRedColorDark = const Color.fromRGBO(212, 98, 248, 1.0);
    _horosCopPurpuleColorLight = const Color.fromRGBO(254, 46, 29, 1.0);
    _todaycolor=const Color.fromRGBO(74, 184, 23, 1);
    selectedtodaycolor=const Color.fromRGBO(74, 184, 23, 0.4);
    eventcolor=const Color.fromRGBO(74, 111, 197, 1);
    event2color=const Color.fromRGBO(249, 90, 0, 1);


  }

  Gradient? get appointmentButtonColor =>
      _isDarkMode ? _bookAppointmentButtonDark : _bookAppointmentButtonLight;
  Gradient? get whiteLiteContainerBackground =>
      _isDarkMode ? _whiteLiteContainerDark : _whiteLiteContainerLight;
  Gradient? get loginContainerBack =>
      _isDarkMode ? _loginContainerDark : _loginContainerLight;

  Gradient? get signAndLoginBackground =>
      _isDarkMode ? _signupBackgroundDark : _signupBackgroundLight;

  Gradient? get signUpBackground =>
      _isDarkMode ? _signupButtonBackgroundDark : _signupButtonBackgroundLight;
  bool get isDarkMode => _isDarkMode;
  Gradient? get appBar =>
      _isDarkMode ? _appBarDarkGradient : _appBarLightGradient;
  Gradient? get gradient => _isDarkMode ? _darkGradient : _lightGradient;
  Gradient? get gradient2 =>
      _isDarkMode ? _cardGradientDark : _cardGradientLight;

  Gradient? get luckyDetail =>
      _isDarkMode ? _luckyDetailGradientDark : _luckyDetailGradientLight;

  Gradient? get containerBackground =>
      _isDarkMode ? _containerDark : _cardGradientLight;
  Color? get textColor => _isDarkMode ? _textColors : _textColors2;
  Color? get gradientTextColor =>
      _isDarkMode ? _textColors : lightGradientTextColor;
  Color? get corner => _isDarkMode ? _textColors : _textColors2;
  Color? get tabBackground =>
      _isDarkMode ? _tabDarkBackground : _tabLightBackground;
  
  Color? get todayColor=>_isDarkMode ? _todaycolor : _todaycolor;
  Color? get tabColor => _isDarkMode ? _tabBarDarkColor : _tabBarLightColor;
  Color? get tabUnSelectedLabelColor => _isDarkMode
      ? _tabUnSelectedLabelColorDark
      : _tabUnSelectedLabelColorLight;

  Color? get tabBackground2 =>
      _isDarkMode ? _tabBackground2Dark : _tabBackground2Light;
  Color? get bookAppointmentBackground => _isDarkMode
      ? _bookAppointmentBackgroundDark
      : _bookAppointmentBackgroundLight;
  Color? get bookAppointmentIconColors =>
      _isDarkMode ? _aboutIconColorDark : _aboutIconColorLight;
  Color? get reviewBackground =>
      _isDarkMode ? _reviewBackgroundDark : _reviewBackgroundLight;
  Color? get reviewBackground2 =>
      _isDarkMode ? _reviewBackground2Dark : _reviewBackground2Light;
  Color? get panchangBackground =>
      _isDarkMode ? _panchangaBackgroundDark : _panchangaBackgroundLight;
  Color? get bottomNavigationIconColor => _isDarkMode
      ? _bottomNavigationIconColorDark
      : _bottomNavigationIconColorLight;
  Color? get iconColorWhiteAndBlack =>
      _isDarkMode ? _iconColorWhiteDark : _iconColorBlackLight;

  Color? get calenderBorder =>
      _isDarkMode ? _calenderBorderDark : _calenderBorderLight;

  Color? get whiteTextColor =>
      _isDarkMode ? _whiteTextColorDark : _whiteTextColorLight;
  Color? get horosCopColor =>
      _isDarkMode ? _horosCopRedColorDark : _horosCopPurpuleColorLight;

  ThemeData get themeData => _isDarkMode ? _darkTheme : _lightTheme;
  ThemeData get _darkTheme => ThemeData.dark().copyWith(
      cardColor: Colors.white,
      primaryColor: ThemeColors.blueColor,
      scaffoldBackgroundColor: ThemeColors.backgroundColor,
      appBarTheme:
          const AppBarTheme(color: ThemeColors.backgroundColor, elevation: 0),
      backgroundColor: ThemeColors.backgroundColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ThemeColors.background,
      ),
      //iconTheme: IconThemeData(color: Colors.deepPurple,opacity: 0.8),
      buttonTheme: const ButtonThemeData(buttonColor: ThemeColors.purpleColor)
      // Define more dark theme colors here
      );

  ThemeData get _lightTheme => ThemeData.light().copyWith(
        primaryColor: ThemeColors.orangeColor,
        cardColor: Colors.orangeAccent,
        scaffoldBackgroundColor: ThemeColors.whiteColor,
        appBarTheme: const AppBarTheme(
          color: ThemeColors.whiteColor,
          elevation: 0,
        ),
        //iconTheme: IconThemeData(color: Colors.orange,opacity: 0.8),

        backgroundColor: ThemeColors.whiteColor,

        // Define more light theme colors here
      );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
