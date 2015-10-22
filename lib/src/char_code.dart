library malison.char_code;

/// Unicode code points for various special characters that also exist on
/// [code page 437][font].
///
/// [font]: http://en.wikipedia.org/wiki/Code_page_437
class CharCode {
  static const space = 0x0020;
  static const asterisk = 0x002a;

  // 1 - 15.
  static const whiteSmilingFace = 0x263a;
  static const blackSmilingFace = 0x263b;
  static const blackHeartSuit = 0x2665;
  static const blackDiamondSuit = 0x2666;
  static const blackClubSuit = 0x2663;
  static const blackSpadeSuit = 0x2660;
  static const bullet = 0x2022;
  static const inverseBullet = 0x25d8;
  static const whiteCircle = 0x25cb;
  static const inverseWhiteCircle = 0x25d9;
  static const maleSign = 0x2642;
  static const femaleSign = 0x2640;
  static const eighthNote = 0x266a;
  static const beamedEighthNotes = 0x266b;
  static const whiteSunWithRays = 0x263c;

  // 16 - 31.
  static const blackRightPointingPointer = 0x25ba;
  static const blackLeftPointingPointer = 0x25c4;
  static const upDownArrow = 0x2195;
  static const doubleExclamationMark = 0x203c;
  static const pilcrow = 0x00b6;
  static const sectionSign = 0x00a7;
  static const blackRectangle = 0x25ac;
  static const upDownArrowWithBase = 0x21a8;
  static const upwardsArrow = 0x2191;
  static const downwardsArrow = 0x2193;
  static const rightwardsArrow = 0x2192;
  static const leftwardsArrow = 0x2190;
  static const rightAngle = 0x221f;
  static const leftRightArrow = 0x2194;
  static const blackUpPointingTriangle = 0x25b2;
  static const blackDownPointingTriangle = 0x25bc;

  // 127.
  static const house = 0x2302;

  // 128 - 143.
  static const latinCapitalLetterCWithCedilla = 0x00c7;
  static const latinSmallLetterUWithDiaeresis = 0x00fc;
  static const latinSmallLetterEWithAcute = 0x00e9;
  static const latinSmallLetterAWithCircumflex = 0x00e2;
  static const latinSmallLetterAWithDiaeresis = 0x00e4;
  static const latinSmallLetterAWithGrave = 0x00e0;
  static const latinSmallLetterAWithRingAbove = 0x00e5;
  static const latinSmallLetterCWithCedilla = 0x00e7;
  static const latinSmallLetterEWithCircumflex = 0x00ea;
  static const latinSmallLetterEWithDiaeresis = 0x00eb;
  static const latinSmallLetterEWithGrave = 0x00e8;
  static const latinSmallLetterIWithDiaeresis = 0x00ef;
  static const latinSmallLetterIWithCircumflex = 0x00ee;
  static const latinSmallLetterIWithGrave = 0x00ec;
  static const latinCapitalLetterAWithDiaeresis = 0x00c4;
  static const latinCapitalLetterAWithRingAbove = 0x00c5;

  // 144 - 159.
  static const latinCapitalLetterEWithAcute = 0x00c9;
  static const latinSmallLetterAe = 0x00e6;
  static const latinCapitalLetterAe = 0x00c6;
  static const latinSmallLetterOWithCircumflex = 0x00f4;
  static const latinSmallLetterOWithDiaeresis = 0x00f6;
  static const latinSmallLetterOWithGrave = 0x00f2;
  static const latinSmallLetterUWithCircumflex = 0x00fb;
  static const latinSmallLetterUWithGrave = 0x00f9;
  static const latinSmallLetterYWithDiaeresis = 0x00ff;
  static const latinCapitalLetterOWithDiaeresis = 0x00d6;
  static const latinCapitalLetterUWithDiaeresis = 0x00dc;
  static const centSign = 0x00a2;
  static const poundSign = 0x00a3;
  static const yenSign = 0x00a5;
  static const pesetaSign = 0x20a7;
  static const latinSmallLetterFWithHook = 0x0192;

  // 160 - 175.
  static const latinSmallLetterAWithAcute = 0x00e1;
  static const latinSmallLetterIWithAcute = 0x00ed;
  static const latinSmallLetterOWithAcute = 0x00f3;
  static const latinSmallLetterUWithAcute = 0x00fa;
  static const latinSmallLetterNWithTilde = 0x00f1;
  static const latinCapitalLetterNWithTilde = 0x00d1;
  static const feminineOrdinalIndicator = 0x00aa;
  static const masculineOrdinalIndicator = 0x00ba;
  static const invertedQuestionMark = 0x00bf;
  static const reversedNotSign = 0x2310;
  static const notSign = 0x00ac;
  static const vulgarFractionOneHalf = 0x00bd;
  static const vulgarFractionOneQuarter = 0x00bc;
  static const invertedExclamationMark = 0x00a1;
  static const leftPointingDoubleAngleQuotationMark = 0x00ab;
  static const rightPointingDoubleAngleQuotationMark = 0x00bb;

  // 176 - 191.
  static const lightShade = 0x2591;
  static const mediumShade = 0x2592;
  static const darkShade = 0x2593;
  static const boxDrawingsLightVertical = 0x2502;
  static const boxDrawingsLightVerticalAndLeft = 0x2524;
  static const boxDrawingsVerticalSingleAndLeftDouble = 0x2561;
  static const boxDrawingsVerticalDoubleAndLeftSingle = 0x2562;
  static const boxDrawingsDownDoubleAndLeftSingle = 0x2556;
  static const boxDrawingsDownSingleAndLeftDouble = 0x2555;
  static const boxDrawingsDoubleVerticalAndLeft = 0x2563;
  static const boxDrawingsDoubleVertical = 0x2551;
  static const boxDrawingsDoubleDownAndLeft = 0x2557;
  static const boxDrawingsDoubleUpAndLeft = 0x255d;
  static const boxDrawingsUpDoubleAndLeftSingle = 0x255c;
  static const boxDrawingsUpSingleAndLeftDouble = 0x255b;
  static const boxDrawingsLightDownAndLeft = 0x2510;

  // 192 - 207.
  static const boxDrawingsLightUpAndRight = 0x2514;
  static const boxDrawingsLightUpAndHorizontal = 0x2534;
  static const boxDrawingsLightDownAndHorizontal = 0x252c;
  static const boxDrawingsLightVerticalAndRight = 0x251c;
  static const boxDrawingsLightHorizontal = 0x2500;
  static const boxDrawingsLightVerticalAndHorizontal = 0x253c;
  static const boxDrawingsVerticalSingleAndRightDouble = 0x255e;
  static const boxDrawingsVerticalDoubleAndRightSingle = 0x255f;
  static const boxDrawingsDoubleUpAndRight = 0x255a;
  static const boxDrawingsDoubleDownAndRight = 0x2554;
  static const boxDrawingsDoubleUpAndHorizontal = 0x2569;
  static const boxDrawingsDoubleDownAndHorizontal = 0x2566;
  static const boxDrawingsDoubleVerticalAndRight = 0x2560;
  static const boxDrawingsDoubleHorizontal = 0x2550;
  static const boxDrawingsDoubleVerticalAndHorizontal = 0x256c;
  static const boxDrawingsUpSingleAndHorizontalDouble = 0x2567;

  // 208 - 223.
  static const boxDrawingsUpDoubleAndHorizontalSingle = 0x2568;
  static const boxDrawingsDownSingleAndHorizontalDouble = 0x2564;
  static const boxDrawingsDownDoubleAndHorizontalSingle = 0x2565;
  static const boxDrawingsUpDoubleAndRightSingle = 0x2559;
  static const boxDrawingsUpSingleAndRightDouble = 0x2558;
  static const boxDrawingsDownSingleAndRightDouble = 0x2552;
  static const boxDrawingsDownDoubleAndRightSingle = 0x2553;
  static const boxDrawingsVerticalDoubleAndHorizontalSingle = 0x256b;
  static const boxDrawingsVerticalSingleAndHorizontalDouble = 0x256a;
  static const boxDrawingsLightUpAndLeft = 0x2518;
  static const boxDrawingsLightDownAndRight = 0x250c;
  static const fullBlock = 0x2588;
  static const lowerHalfBlock = 0x2584;
  static const leftHalfBlock = 0x258c;
  static const rightHalfBlock = 0x2590;
  static const upperHalfBlock = 0x2580;

  // 224 - 239.
  static const greekSmallLetterAlpha = 0x03b1;
  static const latinSmallLetterSharpS = 0x00df;
  static const greekCapitalLetterGamma = 0x0393;
  static const greekSmallLetterPi = 0x03c0;
  static const greekCapitalLetterSigma = 0x03a3;
  static const greekSmallLetterSigma = 0x03c3;
  static const microSign = 0x00b5;
  static const greekSmallLetterTau = 0x03c4;
  static const greekCapitalLetterPhi = 0x03a6;
  static const greekCapitalLetterTheta = 0x0398;
  static const greekCapitalLetterOmega = 0x03a9;
  static const greekSmallLetterDelta = 0x03b4;
  static const infinity = 0x221e;
  static const greekSmallLetterPhi = 0x03c6;
  static const greekSmallLetterEpsilon = 0x03b5;
  static const intersection = 0x2229;

  // 240 - 254.
  static const identicalTo = 0x2261;
  static const plusMinusSign = 0x00b1;
  static const greaterThanOrEqualTo = 0x2265;
  static const lessThanOrEqualTo = 0x2264;
  static const topHalfIntegral = 0x2320;
  static const bottomHalfIntegral = 0x2321;
  static const divisionSign = 0x00f7;
  static const almostEqualTo = 0x2248;
  static const degreeSign = 0x00b0;
  static const bulletOperator = 0x2219;
  static const middleDot = 0x00b7;
  static const squareRoot = 0x221a;
  static const superscriptLatinSmallLetterN = 0x207f;
  static const superscriptTwo = 0x00b2;
  static const blackSquare = 0x25a0;
}
