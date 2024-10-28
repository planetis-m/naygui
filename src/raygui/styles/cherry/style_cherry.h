//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
// StyleAsCode exporter v2.0 - Style data exported as a values array            //
//                                                                              //
// USAGE: On init call: GuiLoadStyleCherry();                                   //
//                                                                              //
// more info and bugs-report:  github.com/raysan5/raygui                        //
// feedback and support:       ray[at]raylibtech.com                            //
//                                                                              //
// Copyright (c) 2020-2024 raylib technologies (@raylibtech)                    //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

#define CHERRY_STYLE_PROPS_COUNT  17

// Custom style name: Cherry
static const GuiStyleProp cherryStyleProps[CHERRY_STYLE_PROPS_COUNT] = {
    { 0, 0, 0xda5757ff },    // DEFAULT_BORDER_COLOR_NORMAL 
    { 0, 1, 0x753233ff },    // DEFAULT_BASE_COLOR_NORMAL 
    { 0, 2, 0xe17373ff },    // DEFAULT_TEXT_COLOR_NORMAL 
    { 0, 3, 0xfaaa97ff },    // DEFAULT_BORDER_COLOR_FOCUSED 
    { 0, 4, 0xe06262ff },    // DEFAULT_BASE_COLOR_FOCUSED 
    { 0, 5, 0xfdb4aaff },    // DEFAULT_TEXT_COLOR_FOCUSED 
    { 0, 6, 0xe03c46ff },    // DEFAULT_BORDER_COLOR_PRESSED 
    { 0, 7, 0x5b1e20ff },    // DEFAULT_BASE_COLOR_PRESSED 
    { 0, 8, 0xc2474fff },    // DEFAULT_TEXT_COLOR_PRESSED 
    { 0, 9, 0xa19292ff },    // DEFAULT_BORDER_COLOR_DISABLED 
    { 0, 10, 0x706060ff },    // DEFAULT_BASE_COLOR_DISABLED 
    { 0, 11, 0x9e8585ff },    // DEFAULT_TEXT_COLOR_DISABLED 
    { 0, 16, 0x0000000f },    // DEFAULT_TEXT_SIZE 
    { 0, 17, 0x00000000 },    // DEFAULT_TEXT_SPACING 
    { 0, 18, 0xfb8170ff },    // DEFAULT_LINE_COLOR 
    { 0, 19, 0x3a1720ff },    // DEFAULT_BACKGROUND_COLOR 
    { 0, 20, 0x00000016 },    // DEFAULT_TEXT_LINE_SPACING 
};

// WARNING: This style uses a custom font: "Westington.ttf" (size: 15, spacing: 0)

#define CHERRY_STYLE_FONT_ATLAS_COMP_SIZE 2821

// Font atlas image pixels data: DEFLATE compressed
static unsigned char cherryFontData[CHERRY_STYLE_FONT_ATLAS_COMP_SIZE] = { 0xed,
    0xdd, 0x59, 0x92, 0xdc, 0xba, 0x11, 0x05, 0x50, 0xee, 0x7f, 0xd3, 0xd7, 0xe1, 0x70, 0x84, 0xed, 0x27, 0xa9, 0x09, 0x20,
    0x91, 0x20, 0xab, 0x5b, 0x47, 0xe7, 0xaf, 0xa1, 0x1a, 0x38, 0x24, 0x26, 0x16, 0x12, 0xb9, 0x00, 0x00, 0x00, 0x00, 0xf2,
    0xef, 0x7f, 0x5f, 0xfd, 0xf5, 0xcf, 0x65, 0xff, 0xff, 0xaa, 0xdc, 0xbe, 0x73, 0xfd, 0xb3, 0xb3, 0xf8, 0xae, 0x59, 0xf8,
    0x7f, 0xf9, 0xf2, 0xbb, 0x64, 0xfa, 0x33, 0xd7, 0x8f, 0x7b, 0xfd, 0x58, 0xef, 0xce, 0xfd, 0xfa, 0x31, 0x5c, 0x37, 0x9f,
    0xbf, 0xf6, 0xdd, 0x2a, 0xaf, 0xb9, 0x2f, 0x59, 0xbf, 0x7b, 0x3a, 0xae, 0xc8, 0xdc, 0x35, 0xb8, 0x3f, 0xa7, 0xd7, 0xf0,
    0x95, 0xeb, 0xef, 0x9c, 0xe1, 0x59, 0x1c, 0x7f, 0xab, 0xb5, 0x1a, 0xe0, 0xeb, 0xbf, 0x8e, 0xee, 0xa6, 0x14, 0xee, 0xab,
    0xff, 0xbd, 0x22, 0x8b, 0x65, 0xa3, 0xd7, 0xec, 0xdd, 0x57, 0x59, 0xa8, 0xa5, 0x2a, 0x57, 0x21, 0x8b, 0xe7, 0x61, 0xf5,
    0xdc, 0xa5, 0x54, 0xff, 0x8c, 0xbe, 0x6d, 0x5a, 0x8e, 0xe7, 0xae, 0x24, 0xd3, 0x7f, 0x1d, 0xbf, 0xa2, 0xf2, 0x6e, 0x33,
    0xf7, 0xd5, 0xdd, 0xab, 0xfb, 0xdf, 0x39, 0x53, 0xf7, 0xef, 0xd9, 0xf8, 0x1f, 0xd5, 0x97, 0xf7, 0xe7, 0xfb, 0xee, 0x28,
    0xf2, 0xdf, 0xde, 0x45, 0xed, 0xbe, 0xdb, 0x89, 0xf4, 0xdc, 0xdc, 0x9d, 0x29, 0x9e, 0x8d, 0xfa, 0xff, 0xbb, 0x8f, 0x97,
    0x14, 0x7b, 0x5e, 0x59, 0xb8, 0x4f, 0xb3, 0x54, 0xeb, 0xcd, 0xf4, 0x26, 0x2a, 0x35, 0xdd, 0x6e, 0x2f, 0x6a, 0xbf, 0xa7,
    0xfb, 0xf5, 0x35, 0xb8, 0x3b, 0xdf, 0x99, 0x3c, 0x82, 0x94, 0xe2, 0xff, 0x5a, 0xac, 0xb1, 0x9f, 0x8a, 0xff, 0x71, 0xac,
    0x8c, 0xe2, 0x29, 0xc3, 0x2b, 0x9c, 0x96, 0xef, 0x9f, 0x52, 0x8d, 0x76, 0x6a, 0x9c, 0x55, 0xbf, 0x7f, 0x66, 0xcf, 0x5e,
    0x06, 0xa3, 0xb9, 0xee, 0x5e, 0xe8, 0x7c, 0xaf, 0x2f, 0xc5, 0xda, 0x75, 0xa5, 0x8f, 0x9f, 0xad, 0xde, 0xfa, 0x28, 0x7e,
    0xb3, 0x5c, 0x17, 0x67, 0xa2, 0x3f, 0x74, 0xa2, 0x4f, 0xf2, 0x09, 0xf1, 0x9f, 0xc2, 0x08, 0xae, 0x5a, 0xc7, 0xa7, 0xa9,
    0x6d, 0xce, 0xa1, 0xfa, 0xb5, 0x3b, 0xfe, 0xd7, 0xcb, 0xc6, 0x91, 0x91, 0xd6, 0x71, 0x58, 0x4a, 0x23, 0xe9, 0x7a, 0x1b,
    0xbe, 0xfb, 0xda, 0xbb, 0xb9, 0xa2, 0x4c, 0xd4, 0x9e, 0x59, 0x9e, 0x01, 0xd8, 0x89, 0xff, 0xfe, 0xf1, 0x7f, 0x4a, 0xaf,
    0x98, 0xab, 0x8d, 0x6b, 0x35, 0x71, 0x16, 0xbe, 0x59, 0x9a, 0x6a, 0xb6, 0x1c, 0x9d, 0x65, 0xbd, 0x1a, 0xe3, 0xbf, 0x36,
    0x72, 0x4a, 0xdb, 0xdc, 0x44, 0x7d, 0xec, 0x96, 0xa6, 0xfb, 0x35, 0xad, 0xaf, 0xb8, 0x8f, 0xff, 0xbb, 0xf6, 0x7f, 0xbf,
    0xff, 0xff, 0x7e, 0xfb, 0xdf, 0x3d, 0xfa, 0x9f, 0x9f, 0xc5, 0x18, 0x9f, 0xd3, 0xe7, 0xe2, 0xff, 0x64, 0xdf, 0xbf, 0x36,
    0x96, 0x4f, 0x71, 0x9e, 0x32, 0x4d, 0x23, 0xf6, 0x94, 0x47, 0xe7, 0x69, 0x99, 0xd5, 0xe9, 0xab, 0xab, 0x53, 0xfe, 0x8c,
    0xfa, 0x3c, 0xf6, 0x4f, 0x1d, 0xff, 0x67, 0xe9, 0xd9, 0xc0, 0xb8, 0x6f, 0x75, 0x77, 0x66, 0xd2, 0x3e, 0xff, 0xf7, 0xde,
    0x53, 0xd6, 0xb5, 0x5a, 0x27, 0x85, 0x31, 0x76, 0x65, 0xd6, 0xbc, 0xfa, 0x34, 0xb1, 0xf3, 0xd9, 0xe4, 0xfb, 0xd7, 0xa9,
    0x3a, 0xd7, 0x98, 0x72, 0xed, 0x9e, 0x89, 0x67, 0x3f, 0xeb, 0xb3, 0x0a, 0x4f, 0xf5, 0xa6, 0x66, 0xe6, 0x62, 0xae, 0xe2,
    0xbc, 0x69, 0x0a, 0x3d, 0x9c, 0x4f, 0x8f, 0xff, 0x4f, 0xaa, 0x89, 0x3e, 0xf1, 0xf7, 0x27, 0x69, 0x1e, 0xe9, 0x77, 0x45,
    0x40, 0x26, 0x46, 0xe2, 0x57, 0xa1, 0x9e, 0xfe, 0x0e, 0xcf, 0xff, 0xc7, 0xf1, 0x5f, 0x1d, 0xff, 0x67, 0xea, 0xf7, 0x18,
    0x6b, 0xcf, 0x01, 0xf2, 0xe1, 0xad, 0xbf, 0x1a, 0xa0, 0x67, 0x4e, 0xfe, 0xe9, 0xfa, 0x39, 0x87, 0xc7, 0x85, 0x7f, 0xe3,
    0x75, 0x05, 0xf7, 0x0f, 0x20, 0xfa, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xbe, 0x5e, 0x37,
    0xb8, 0xbe, 0x16, 0xb1, 0x3b, 0x4b, 0x6b, 0xe5, 0xfd, 0x7e, 0x2f, 0x1d, 0xbd, 0x47, 0xf5, 0x68, 0x2b, 0xb9, 0xa0, 0x33,
    0xf5, 0xdd, 0xb3, 0xbc, 0xa2, 0x73, 0x74, 0x34, 0xf9, 0xc7, 0x1a, 0xd5, 0x99, 0x73, 0xba, 0x73, 0x5d, 0xc6, 0x99, 0x77,
    0x57, 0xf2, 0xfb, 0xae, 0xad, 0x06, 0x5e, 0x5d, 0x21, 0xd0, 0x99, 0xed, 0x60, 0xf6, 0xfa, 0x56, 0xee, 0xa8, 0x95, 0x4f,
    0xdb, 0x59, 0x8b, 0x78, 0x9f, 0x81, 0xf9, 0x1a, 0x66, 0x88, 0xee, 0xca, 0x51, 0x97, 0x8d, 0x35, 0xfb, 0xbf, 0xdf, 0xc9,
    0x95, 0x55, 0xdb, 0xe3, 0x7b, 0xaa, 0x92, 0x77, 0xa9, 0x9a, 0xb3, 0x39, 0x2d, 0x9f, 0x3b, 0xf3, 0xcd, 0xe6, 0x32, 0xfa,
    0xd4, 0x33, 0xb6, 0x5f, 0x8b, 0xfb, 0x30, 0xac, 0xad, 0xe5, 0xce, 0xf2, 0x5a, 0xf8, 0xb4, 0xe5, 0x8b, 0x48, 0xf1, 0x3d,
    0x6b, 0xf7, 0xda, 0x99, 0xec, 0x3f, 0xd5, 0x2c, 0x59, 0x67, 0xe2, 0x3f, 0xe5, 0xef, 0x92, 0xdb, 0x7b, 0xe2, 0x1a, 0x66,
    0x28, 0xaa, 0x66, 0x5e, 0xca, 0x46, 0xbd, 0x96, 0x8d, 0xb5, 0xee, 0x5d, 0xf1, 0xbf, 0x13, 0xe1, 0xb3, 0xf9, 0x7b, 0xd3,
    0xb2, 0xba, 0x7f, 0x25, 0x1b, 0x7a, 0xb5, 0x1f, 0xdc, 0x19, 0x21, 0x77, 0xc7, 0x9e, 0x8d, 0x33, 0x73, 0x26, 0xfe, 0xf3,
    0x01, 0xf1, 0xbf, 0x53, 0x17, 0x7d, 0xcf, 0xf8, 0x4f, 0x43, 0xed, 0x9c, 0xd2, 0x15, 0xfa, 0x3d, 0x76, 0x2b, 0x7b, 0x59,
    0x5c, 0xe5, 0x8c, 0xce, 0x69, 0x6e, 0x8f, 0x3a, 0xd6, 0x14, 0x3f, 0x19, 0xff, 0xeb, 0xf5, 0xcd, 0xa9, 0xf8, 0xbf, 0xdb,
    0xad, 0x23, 0xa5, 0xdd, 0x9e, 0xfa, 0xf6, 0xc1, 0x5a, 0xa9, 0x8b, 0x32, 0x9d, 0x5b, 0xb4, 0x12, 0xff, 0x19, 0xee, 0xa0,
    0x51, 0xd9, 0xb7, 0xa0, 0x9a, 0x0d, 0xb9, 0x23, 0xfe, 0xe7, 0xf3, 0x9b, 0x67, 0xb2, 0xee, 0xed, 0x88, 0xf3, 0x77, 0xe2,
    0x7f, 0x74, 0x05, 0x53, 0xcc, 0xd6, 0xb7, 0x9e, 0xe5, 0x7b, 0xfc, 0x69, 0xbd, 0x59, 0xd4, 0x67, 0xf6, 0x9a, 0xc9, 0x37,
    0x68, 0xff, 0xcf, 0xc7, 0x7f, 0xe5, 0x5d, 0x67, 0xe7, 0x66, 0xf2, 0x5a, 0xfc, 0x67, 0xbb, 0x85, 0x4f, 0xf3, 0xe8, 0xf2,
    0x8d, 0xbc, 0x5f, 0x33, 0xf3, 0x05, 0xb5, 0x18, 0x4f, 0xeb, 0x78, 0xa3, 0xf6, 0x69, 0x27, 0x7a, 0x98, 0xeb, 0xf1, 0x9f,
    0xa3, 0xe3, 0xff, 0x95, 0x4f, 0xa8, 0xf7, 0xff, 0xef, 0x3e, 0xbb, 0x77, 0xfe, 0xaf, 0x6b, 0xee, 0x69, 0xa6, 0xed, 0x4e,
    0x43, 0x2f, 0xe2, 0x7c, 0xcd, 0x90, 0xd7, 0x9e, 0x91, 0x55, 0x3e, 0xff, 0x44, 0x44, 0x56, 0x63, 0xab, 0x1a, 0xff, 0xbd,
    0xf3, 0xff, 0x1d, 0xf3, 0xcc, 0x73, 0x47, 0x9f, 0x42, 0xa4, 0xa6, 0x38, 0xbe, 0xca, 0xd6, 0x0c, 0x79, 0x36, 0xe2, 0x3f,
    0x0d, 0xf1, 0x7f, 0xf7, 0xfc, 0x6e, 0x37, 0xfe, 0x33, 0x78, 0xbe, 0x91, 0x6f, 0x13, 0xff, 0x29, 0xc5, 0x7f, 0x9a, 0x23,
    0x32, 0xe5, 0xd8, 0xba, 0x96, 0x9f, 0x4f, 0x9e, 0x79, 0xfe, 0x3f, 0x7e, 0xca, 0xba, 0xf3, 0x24, 0x79, 0xf6, 0x3b, 0xd5,
    0x7f, 0xed, 0x30, 0x3a, 0x4b, 0x59, 0x8e, 0xb0, 0x94, 0x72, 0xf3, 0xcf, 0x8f, 0xf9, 0xb2, 0xd9, 0x4a, 0x8d, 0x6b, 0x88,
    0x6a, 0x4e, 0xea, 0xd5, 0x7d, 0xd5, 0xf3, 0xfa, 0xbe, 0x36, 0xcf, 0xbc, 0x72, 0x67, 0xaf, 0x06, 0x39, 0x89, 0xf9, 0x19,
    0xbf, 0x49, 0x73, 0x16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7a, 0xd6, 0x60,
    0xa6, 0x94, 0xd5, 0x6b, 0xf6, 0x7f, 0x55, 0x73, 0x90, 0xe5, 0x36, 0xcb, 0xf4, 0xda, 0x5a, 0xdf, 0x0c, 0x8f, 0xb1, 0x63,
    0xa5, 0xf4, 0xd9, 0x2c, 0xdc, 0xf3, 0xe7, 0xb6, 0x76, 0xf5, 0xb3, 0x98, 0xcf, 0x32, 0xed, 0x2b, 0xd3, 0xc7, 0xeb, 0xad,
    0xef, 0xd7, 0xd0, 0xd7, 0x5f, 0x77, 0x15, 0x56, 0x38, 0xaf, 0x5e, 0xad, 0x99, 0x5c, 0xf1, 0x6f, 0xd4, 0x15, 0xd7, 0x44,
    0x86, 0xbb, 0x9d, 0x1c, 0xfa, 0x77, 0xe7, 0xfe, 0xeb, 0xfb, 0xf5, 0xee, 0x7b, 0xf5, 0xe5, 0x2d, 0xbc, 0xb6, 0x33, 0xe8,
    0x5e, 0x8f, 0x64, 0xe1, 0xce, 0xe2, 0x7d, 0x38, 0xfb, 0x3f, 0x47, 0x59, 0x04, 0x53, 0xc8, 0xf4, 0x71, 0xee, 0x78, 0x67,
    0xf2, 0x3f, 0x8d, 0xf2, 0x3c, 0xfe, 0xf9, 0xef, 0x2b, 0xf7, 0x53, 0x2d, 0x67, 0x72, 0x06, 0xb9, 0x24, 0x7b, 0xd7, 0x5a,
    0xe7, 0xf6, 0x5e, 0x5d, 0xef, 0x47, 0x9c, 0xb9, 0xa2, 0xf5, 0xf8, 0x5f, 0x6f, 0x77, 0x4e, 0xc5, 0xff, 0x7e, 0x16, 0xde,
    0x9d, 0x1c, 0x3d, 0xfb, 0x7f, 0xbf, 0x6f, 0xfd, 0xaf, 0xe5, 0xde, 0xd9, 0xb5, 0x95, 0xeb, 0x76, 0x9c, 0x09, 0x67, 0x9c,
    0x61, 0x6a, 0xf5, 0x38, 0xae, 0xc5, 0xfc, 0xce, 0x9f, 0x13, 0xff, 0x57, 0x29, 0xfe, 0xaf, 0x0f, 0x8a, 0xff, 0xbb, 0x76,
    0xe7, 0x2a, 0xee, 0x27, 0x72, 0xd7, 0x33, 0xbb, 0x1a, 0xdb, 0x9c, 0xdf, 0x6b, 0xd5, 0x94, 0xfa, 0xc3, 0x29, 0x67, 0x4f,
    0x7c, 0x2b, 0x07, 0xd7, 0x78, 0x77, 0x93, 0x71, 0xdf, 0xbf, 0x56, 0x53, 0xd6, 0x32, 0x31, 0xdd, 0x8f, 0x28, 0xb2, 0xb4,
    0x3b, 0x41, 0x3d, 0x2f, 0x58, 0x0e, 0x64, 0x47, 0x59, 0xad, 0xe9, 0x53, 0xe8, 0xff, 0x5f, 0x5b, 0xfb, 0x48, 0x54, 0xf3,
    0x1e, 0xd7, 0x72, 0xac, 0xa7, 0xd0, 0xee, 0xcc, 0xc4, 0xdf, 0x5e, 0x16, 0xde, 0x4c, 0x8e, 0xb2, 0xae, 0xc5, 0x3a, 0xf2,
    0x6a, 0xab, 0x31, 0xd6, 0x7a, 0x98, 0xd9, 0x1a, 0x6d, 0xcd, 0xd4, 0x0d, 0x59, 0xdc, 0xab, 0xa1, 0xde, 0x5e, 0x54, 0xf2,
    0xc9, 0xd5, 0x6b, 0x80, 0xbc, 0x36, 0xff, 0x77, 0x15, 0x32, 0xd5, 0xaf, 0xe5, 0xe6, 0xab, 0xcc, 0xbd, 0x55, 0x8e, 0xaf,
    0x96, 0x73, 0x6f, 0x26, 0x6b, 0x7b, 0x4f, 0xfe, 0xe2, 0xd5, 0xf3, 0x73, 0x4d, 0xcd, 0x6a, 0xe5, 0xa5, 0xf6, 0x7f, 0x3d,
    0x02, 0xe6, 0x76, 0xa5, 0xdc, 0xe9, 0xd5, 0x54, 0x33, 0x76, 0xf7, 0xf7, 0x7e, 0xde, 0x9f, 0xff, 0x5f, 0xcb, 0xe0, 0xfd,
    0x59, 0xd9, 0x59, 0xd3, 0xf0, 0x3f, 0xfa, 0x3e, 0xeb, 0xed, 0x67, 0x38, 0x39, 0x5a, 0xfb, 0xf7, 0xc6, 0x7f, 0x8a, 0xe3,
    0xc9, 0xd9, 0x7a, 0x38, 0x4b, 0x39, 0x87, 0xc7, 0xf3, 0x5b, 0xe7, 0xc6, 0x3f, 0x9f, 0x78, 0x3f, 0xed, 0xe4, 0xb2, 0x7f,
    0xf6, 0x7b, 0xe6, 0xb1, 0x1e, 0xd3, 0x89, 0xd9, 0x97, 0xe7, 0xce, 0xc4, 0xda, 0x31, 0xa5, 0xf1, 0x8e, 0xad, 0xcd, 0xff,
    0x65, 0x63, 0x8e, 0x6f, 0x77, 0xbf, 0xde, 0x14, 0x66, 0x15, 0xff, 0x86, 0x5f, 0x0a, 0x7c, 0x3d, 0x03, 0x91, 0xbf, 0x22,
    0xf7, 0xf0, 0x4f, 0x3c, 0xc6, 0x8e, 0xe7, 0xff, 0xd5, 0x7e, 0x53, 0x6d, 0xe7, 0x80, 0xb9, 0x79, 0x9f, 0xca, 0xfc, 0x6e,
    0x75, 0xcc, 0x08, 0x54, 0x9e, 0x31, 0x57, 0x76, 0x0e, 0xe8, 0x18, 0xc1, 0x65, 0xf9, 0xf9, 0x3f, 0xf0, 0x53, 0x6a, 0xa2,
    0xda, 0xbc, 0x22, 0xf0, 0xfd, 0x47, 0x3b, 0x22, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf8,
    0x9e, 0xbf, 0x88, 0x5e, 0x5f, 0xeb, 0xba, 0x9e, 0xeb, 0xb0, 0x9e, 0x71, 0x65, 0x76, 0x7d, 0xea, 0x55, 0xca, 0x1a, 0xb9,
    0x97, 0x9b, 0x66, 0x2e, 0x5b, 0x73, 0x3d, 0x5b, 0x5d, 0x35, 0x43, 0xd6, 0x5e, 0xe9, 0xf8, 0x95, 0xf5, 0x57, 0x5f, 0xd3,
    0xe7, 0x2d, 0xaf, 0x1c, 0x77, 0x16, 0x73, 0x18, 0xac, 0xdc, 0x53, 0xfd, 0xc7, 0xba, 0x77, 0x2e, 0xae, 0x62, 0x46, 0x9f,
    0x4a, 0xb6, 0xe3, 0x4a, 0xbc, 0xde, 0xe5, 0x3b, 0xcd, 0xe2, 0x67, 0x65, 0x39, 0xa7, 0xf3, 0xa8, 0x16, 0xc9, 0x60, 0xc5,
    0x68, 0x26, 0xd6, 0x9c, 0xee, 0xe5, 0x1b, 0xa8, 0x96, 0x8d, 0xaf, 0x7a, 0x3d, 0xcf, 0x49, 0x16, 0xeb, 0x8f, 0xb5, 0x1c,
    0x7d, 0x27, 0x8f, 0x7b, 0x7d, 0x0d, 0x73, 0x96, 0x73, 0x64, 0x5d, 0x8b, 0xad, 0x4d, 0x26, 0xda, 0x87, 0xea, 0xb9, 0x98,
    0x6d, 0x01, 0x57, 0xdb, 0xcd, 0xd5, 0x9a, 0xa4, 0x1a, 0xff, 0xd5, 0xcf, 0x3a, 0x13, 0xff, 0x77, 0xc7, 0x96, 0xdb, 0x9c,
    0x13, 0xd9, 0xcc, 0x6f, 0xf8, 0x6c, 0xaf, 0xb0, 0xa7, 0xfd, 0x4d, 0x71, 0x8d, 0xfe, 0xf9, 0x75, 0x81, 0xa7, 0x56, 0x07,
    0xd6, 0x73, 0x47, 0xbf, 0x71, 0x0f, 0xa4, 0x2d, 0x6b, 0xe4, 0x5c, 0x3e, 0xd6, 0xf5, 0xf8, 0x5f, 0x1d, 0x2f, 0xac, 0xe6,
    0x33, 0xcc, 0x44, 0xeb, 0x34, 0xdb, 0xfe, 0x67, 0xeb, 0xea, 0x3f, 0xdf, 0xff, 0xbf, 0x36, 0xda, 0xd0, 0xb9, 0xd1, 0xc1,
    0x6c, 0x1e, 0x8e, 0xd5, 0xbb, 0xa9, 0x5e, 0x3a, 0xce, 0x0d, 0xbc, 0xf7, 0xd7, 0xf1, 0xfd, 0x77, 0xf7, 0x4e, 0x95, 0x91,
    0x52, 0xb6, 0x33, 0x36, 0x65, 0xf9, 0x6c, 0xdc, 0x1f, 0xf5, 0x7a, 0xce, 0xe5, 0xd5, 0xf8, 0x1f, 0xd5, 0x26, 0x6b, 0x23,
    0xb8, 0x71, 0xfb, 0x3f, 0x93, 0x6b, 0x72, 0x6f, 0xb7, 0x8a, 0x1c, 0x89, 0xc3, 0x7a, 0xe9, 0xce, 0x4e, 0x27, 0x7f, 0xaa,
    0x13, 0x53, 0xae, 0x99, 0x72, 0xac, 0xf4, 0xc4, 0xf8, 0x7f, 0x9c, 0x71, 0x24, 0x85, 0x7c, 0x25, 0x3b, 0xa3, 0xa8, 0xdd,
    0xf6, 0xa5, 0xe3, 0xdd, 0xb2, 0xb5, 0x97, 0xc3, 0xb9, 0x6f, 0xdd, 0x31, 0xfe, 0x3f, 0x3b, 0xff, 0xb7, 0xbf, 0xe3, 0x58,
    0xcf, 0x6e, 0x45, 0xab, 0xb5, 0xd9, 0xaf, 0xe7, 0x22, 0x1f, 0xd2, 0xab, 0xa9, 0xd5, 0x0e, 0xfb, 0x7f, 0x1d, 0xcf, 0x59,
    0xe7, 0xa5, 0xf8, 0xef, 0x1d, 0x09, 0xe5, 0xc0, 0xfc, 0xe4, 0xf3, 0xd1, 0xbf, 0x32, 0xfe, 0xef, 0x98, 0x31, 0xab, 0xee,
    0x38, 0x72, 0xb6, 0xb4, 0xb2, 0xe3, 0xea, 0xfc, 0x3d, 0xf9, 0x44, 0x0b, 0xdf, 0xb5, 0x4f, 0xc2, 0x4f, 0x8d, 0xff, 0x37,
    0xf7, 0x18, 0xd9, 0x89, 0xff, 0xf3, 0x59, 0x9a, 0xf3, 0x87, 0x79, 0xbd, 0xdd, 0x4f, 0x1c, 0xed, 0x11, 0x9b, 0xf6, 0x38,
    0xdc, 0x8f, 0xe1, 0x9d, 0xd2, 0xb9, 0x7d, 0x78, 0x6a, 0x51, 0xba, 0x53, 0xfa, 0x56, 0xfb, 0x3f, 0x33, 0x0b, 0xf5, 0x74,
    0xfc, 0x77, 0xce, 0x86, 0xe6, 0x50, 0xeb, 0xb8, 0x3e, 0x9a, 0xe8, 0x9f, 0x1b, 0xed, 0xf8, 0xc4, 0x6a, 0xcb, 0xf0, 0x4e,
    0xff, 0xbf, 0xfe, 0xfb, 0x8b, 0x7f, 0xce, 0x66, 0xa5, 0x38, 0xab, 0xf5, 0x93, 0xc6, 0xff, 0xd7, 0xd4, 0xae, 0x51, 0x79,
    0x69, 0xfc, 0xff, 0x19, 0xaf, 0xff, 0x7b, 0x7f, 0x81, 0x75, 0x1d, 0x6e, 0x87, 0x9f, 0x2e, 0x3d, 0xdf, 0x63, 0xdc, 0x2b,
    0xcd, 0x2b, 0xed, 0xff, 0xdc, 0x48, 0xf4, 0xbd, 0xf8, 0xef, 0xea, 0x2f, 0xab, 0x09, 0x3a, 0xe7, 0x59, 0xde, 0x6d, 0xc3,
    0x6b, 0xbb, 0x38, 0xee, 0xfd, 0xda, 0x66, 0x76, 0x74, 0x50, 0x2b, 0xcd, 0xe1, 0xf1, 0xff, 0xee, 0x55, 0xae, 0x1c, 0xcf,
    0xa7, 0xc4, 0xbf, 0xbc, 0xea, 0xa7, 0xea, 0x8c, 0x4a, 0x1c, 0x3e, 0x15, 0xc3, 0xcf, 0xdf, 0x4d, 0x7b, 0xcf, 0xff, 0xd7,
    0xeb, 0xe8, 0xb5, 0xe7, 0xff, 0x3b, 0x2d, 0xc3, 0xd3, 0xcf, 0xff, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x80, 0xef, 0xb7, 0xfe, 0x6c, 0x9c, 0x99, 0xa6, 0x9e, 0xd5, 0x7b, 0x37, 0x2b, 0xc0, 0xde, 0x11, 0xa5, 0xb4, 0xf6,
    0x6c, 0x36, 0xb7, 0x75, 0xf7, 0xfa, 0xb4, 0x7a, 0x7e, 0xf0, 0x6c, 0xac, 0x3a, 0xac, 0xff, 0xba, 0xfc, 0xd4, 0x71, 0x9e,
    0xca, 0xc2, 0x55, 0xb9, 0x1f, 0x9e, 0xbb, 0x96, 0x69, 0xbf, 0xc2, 0xb3, 0xef, 0x51, 0xcd, 0x05, 0x9d, 0xa5, 0x1c, 0x10,
    0xab, 0x71, 0x96, 0xcd, 0x0c, 0xf5, 0xf5, 0xb5, 0x67, 0xb3, 0xb5, 0x4e, 0x6f, 0xe6, 0xea, 0x6c, 0xe4, 0x87, 0xae, 0x9f,
    0xa3, 0x9d, 0xd5, 0xa5, 0xdd, 0xc7, 0xb9, 0x7e, 0xc5, 0x3a, 0x72, 0x73, 0x67, 0xe3, 0xcc, 0x67, 0xf9, 0xcc, 0x64, 0x50,
    0x3b, 0xe5, 0x91, 0x75, 0xa5, 0xbd, 0x99, 0x0b, 0x56, 0x57, 0x34, 0x3e, 0xb7, 0xd6, 0xb6, 0xbe, 0x0a, 0x6c, 0x37, 0xbf,
    0xd5, 0x73, 0xfd, 0xb7, 0x6a, 0x5f, 0xe4, 0xd7, 0xa3, 0xcc, 0x07, 0xe4, 0x74, 0x38, 0xbb, 0x9a, 0xed, 0xcc, 0x5e, 0x23,
    0xe7, 0xbf, 0xe1, 0xde, 0xde, 0x21, 0x3b, 0x6b, 0x08, 0x53, 0xec, 0x51, 0x8d, 0x32, 0x1a, 0xdc, 0xc7, 0xe7, 0x6e, 0xf9,
    0x5c, 0x0e, 0xb8, 0x6b, 0x22, 0x33, 0x6d, 0x0a, 0xd9, 0x2f, 0x32, 0x58, 0xd7, 0xde, 0x5d, 0x56, 0xbb, 0x47, 0x67, 0xf2,
    0x96, 0xe7, 0xc0, 0x1d, 0x75, 0xbd, 0x98, 0x9b, 0xeb, 0x5a, 0x6e, 0x93, 0x53, 0x6c, 0x7b, 0x3b, 0x4b, 0x3a, 0xea, 0xe7,
    0x6a, 0x2f, 0x6f, 0xa6, 0x6c, 0x3d, 0xa3, 0xe1, 0x4c, 0xcf, 0xf2, 0x99, 0xf2, 0xf5, 0x5c, 0xe6, 0xb3, 0xd9, 0x6f, 0xf2,
    0x58, 0x59, 0xca, 0x77, 0xdb, 0x35, 0x91, 0x87, 0xff, 0xd4, 0x5d, 0xf3, 0x7c, 0x36, 0x8b, 0x4a, 0x0d, 0x5a, 0xcb, 0x91,
    0xf8, 0x5c, 0xc9, 0x6c, 0xae, 0x83, 0x13, 0x57, 0xeb, 0x2a, 0xde, 0x39, 0x9f, 0x11, 0xff, 0xb9, 0xbd, 0xe6, 0xd7, 0x56,
    0xdd, 0xd6, 0xdd, 0x2e, 0xce, 0xb4, 0x99, 0xf5, 0x7a, 0xa3, 0xfa, 0xb9, 0xb5, 0xac, 0x34, 0x73, 0xd9, 0x79, 0xae, 0xe9,
    0x91, 0x7e, 0x65, 0x8f, 0xca, 0x95, 0x4f, 0xad, 0xb4, 0x03, 0x4f, 0x95, 0x54, 0x46, 0x30, 0x4f, 0xc5, 0xff, 0x67, 0xb4,
    0xef, 0xb5, 0xdd, 0x0d, 0xc7, 0xe3, 0xff, 0x94, 0x7b, 0x45, 0xfd, 0x65, 0x29, 0xcf, 0xde, 0x74, 0xcc, 0x0b, 0xa5, 0xb5,
    0xec, 0x6a, 0x9a, 0x9f, 0xaf, 0xec, 0x66, 0xf7, 0xb9, 0xf1, 0x5f, 0xdd, 0x3b, 0xe6, 0xad, 0xf8, 0xcf, 0xc7, 0xb7, 0xff,
    0xeb, 0xbb, 0x9b, 0xfe, 0xf9, 0x19, 0x55, 0x4a, 0x3d, 0x8b, 0xce, 0xb2, 0xab, 0xb8, 0xef, 0xda, 0x6e, 0xaf, 0xf9, 0xc4,
    0xf8, 0x66, 0x36, 0x27, 0xf0, 0x93, 0xf1, 0x5f, 0xb9, 0x2a, 0xbd, 0x25, 0xbb, 0x33, 0x43, 0x6f, 0xb4, 0xff, 0xf3, 0xcf,
    0x0d, 0xde, 0x8a, 0xff, 0xea, 0xf3, 0xff, 0x99, 0xbd, 0x3c, 0x4f, 0xb4, 0x8c, 0x95, 0x96, 0xfc, 0xec, 0x3e, 0x09, 0x27,
    0xc6, 0x39, 0xa7, 0xdb, 0xff, 0xca, 0x78, 0xe4, 0x1a, 0xee, 0xfc, 0x7e, 0xba, 0xe4, 0xda, 0x9e, 0xf9, 0xfd, 0xb4, 0x19,
    0x99, 0xa7, 0xc6, 0xf7, 0x9f, 0xb5, 0xdf, 0xea, 0xf5, 0xda, 0xf3, 0xb4, 0x9f, 0x70, 0xac, 0x1d, 0x33, 0x00, 0xcf, 0x3f,
    0x73, 0xfc, 0xb4, 0x73, 0x57, 0xdd, 0x89, 0xe5, 0xb9, 0xef, 0xd3, 0x51, 0x3e, 0xf3, 0xbd, 0xe5, 0x4c, 0xe5, 0x6f, 0xfa,
    0xf5, 0xef, 0x67, 0xe5, 0x10, 0x1e, 0xff, 0x86, 0x76, 0xaf, 0xfc, 0xb9, 0xdf, 0x4d, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xa9, 0xdf, 0xde, 0xd7, 0xd7, 0xbd, 0x57, 0xd7, 0x7c, 0xf7, 0x67, 0xe2, 0x8e, 0x35,
    0x3c, 0xd0, 0xb6, 0x16, 0x34, 0x93, 0xb9, 0xe0, 0xba, 0x63, 0x31, 0x5b, 0x99, 0x4d, 0x80, 0xf9, 0x36, 0xff, 0x8d, 0x75,
    0x7e, 0xd5, 0xcf, 0xcd, 0x30, 0xf3, 0x82, 0x55, 0x7c, 0x30, 0x1f, 0xff, 0x19, 0xe6, 0x32, 0xea, 0x2e, 0xbd, 0x26, 0xb2,
    0x0b, 0x5c, 0x85, 0xfc, 0x55, 0xd1, 0x47, 0x80, 0xa5, 0xf8, 0x9f, 0xc9, 0xc8, 0xfd, 0x49, 0xa5, 0x29, 0xef, 0x3e, 0x06,
    0xfc, 0x79, 0x94, 0xfd, 0xbd, 0xe2, 0x7f, 0x27, 0x7f, 0x3d, 0xf0, 0x7e, 0xfc, 0xa7, 0x58, 0x5a, 0xcf, 0x15, 0x0b, 0xfc,
    0xda, 0xfb, 0x9f, 0x99, 0xfd, 0x4f, 0x7b, 0xe9, 0xd5, 0xb0, 0xc7, 0x44, 0xf5, 0xa9, 0x24, 0xd0, 0xf1, 0x7c, 0x70, 0xa7,
    0xb4, 0xfe, 0x9b, 0x84, 0x99, 0xe7, 0x19, 0xae, 0x1c, 0x7c, 0xff, 0xe7, 0x92, 0xb5, 0xfa, 0xca, 0x19, 0x84, 0xef, 0xdf,
    0xef, 0x70, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe0, 0x79, 0xff, 0xf9, 0xe7, 0x3c, 0x80, 0xf8, 0x07, 0xfe, 0xba, 0xf8, 0xff, 0x17 };

// Font glyphs rectangles data (on atlas)
static const rlRectangle cherryFontRecs[189] = {
    { 4, 4, 5 , 15 },
    { 17, 4, 3 , 10 },
    { 28, 4, 5 , 2 },
    { 41, 4, 10 , 10 },
    { 59, 4, 7 , 11 },
    { 74, 4, 7 , 10 },
    { 89, 4, 8 , 10 },
    { 105, 4, 1 , 2 },
    { 114, 4, 3 , 10 },
    { 125, 4, 3 , 10 },
    { 136, 4, 3 , 3 },
    { 147, 4, 7 , 7 },
    { 162, 4, 2 , 2 },
    { 172, 4, 6 , 3 },
    { 186, 4, 1 , 1 },
    { 195, 4, 4 , 10 },
    { 207, 4, 5 , 8 },
    { 220, 4, 5 , 8 },
    { 233, 4, 5 , 8 },
    { 246, 4, 5 , 8 },
    { 259, 4, 5 , 8 },
    { 272, 4, 5 , 8 },
    { 285, 4, 5 , 8 },
    { 298, 4, 5 , 8 },
    { 311, 4, 5 , 8 },
    { 324, 4, 5 , 8 },
    { 337, 4, 3 , 10 },
    { 348, 4, 3 , 12 },
    { 359, 4, 6 , 7 },
    { 373, 4, 6 , 4 },
    { 387, 4, 6 , 7 },
    { 401, 4, 5 , 10 },
    { 414, 4, 8 , 10 },
    { 430, 4, 7 , 9 },
    { 445, 4, 7 , 9 },
    { 460, 4, 6 , 9 },
    { 474, 4, 6 , 9 },
    { 488, 4, 7 , 9 },
    { 4, 27, 6 , 9 },
    { 18, 27, 6 , 9 },
    { 32, 27, 7 , 9 },
    { 47, 27, 3 , 9 },
    { 58, 27, 6 , 9 },
    { 72, 27, 7 , 9 },
    { 87, 27, 7 , 9 },
    { 102, 27, 11 , 9 },
    { 121, 27, 8 , 9 },
    { 137, 27, 6 , 9 },
    { 151, 27, 6 , 9 },
    { 165, 27, 7 , 9 },
    { 180, 27, 7 , 9 },
    { 195, 27, 6 , 9 },
    { 209, 27, 7 , 9 },
    { 224, 27, 8 , 9 },
    { 240, 27, 9 , 9 },
    { 257, 27, 11 , 9 },
    { 276, 27, 7 , 9 },
    { 291, 27, 7 , 9 },
    { 306, 27, 7 , 9 },
    { 321, 27, 3 , 9 },
    { 332, 27, 4 , 10 },
    { 344, 27, 3 , 9 },
    { 355, 27, 3 , 3 },
    { 366, 27, 7 , 2 },
    { 381, 27, 2 , 2 },
    { 391, 27, 6 , 6 },
    { 405, 27, 6 , 9 },
    { 419, 27, 6 , 6 },
    { 433, 27, 6 , 9 },
    { 447, 27, 6 , 6 },
    { 461, 27, 5 , 9 },
    { 474, 27, 5 , 9 },
    { 487, 27, 7 , 9 },
    { 4, 50, 3 , 7 },
    { 15, 50, 3 , 8 },
    { 26, 50, 6 , 9 },
    { 40, 50, 4 , 9 },
    { 52, 50, 11 , 6 },
    { 71, 50, 7 , 6 },
    { 86, 50, 5 , 6 },
    { 99, 50, 6 , 8 },
    { 113, 50, 6 , 8 },
    { 127, 50, 5 , 6 },
    { 140, 50, 5 , 6 },
    { 153, 50, 5 , 9 },
    { 166, 50, 7 , 6 },
    { 181, 50, 7 , 6 },
    { 196, 50, 11 , 6 },
    { 215, 50, 7 , 6 },
    { 230, 50, 7 , 8 },
    { 245, 50, 6 , 6 },
    { 259, 50, 5 , 9 },
    { 272, 50, 1 , 9 },
    { 281, 50, 5 , 9 },
    { 294, 50, 7 , 3 },
    { 309, 50, 3 , 10 },
    { 320, 50, 7 , 10 },
    { 335, 50, 7 , 10 },
    { 350, 50, 6 , 9 },
    { 364, 50, 7 , 9 },
    { 379, 50, 6 , 12 },
    { 393, 50, 7 , 11 },
    { 408, 50, 5 , 9 },
    { 421, 50, 5 , 5 },
    { 434, 50, 4 , 5 },
    { 446, 50, 6 , 7 },
    { 460, 50, 6 , 3 },
    { 474, 50, 5 , 5 },
    { 487, 50, 6 , 1 },
    { 4, 73, 3 , 3 },
    { 15, 73, 7 , 10 },
    { 30, 73, 3 , 5 },
    { 41, 73, 3 , 5 },
    { 52, 73, 7 , 12 },
    { 67, 73, 6 , 8 },
    { 81, 73, 7 , 9 },
    { 96, 73, 2 , 3 },
    { 106, 73, 6 , 9 },
    { 120, 73, 3 , 5 },
    { 131, 73, 3 , 5 },
    { 142, 73, 6 , 7 },
    { 156, 73, 13 , 9 },
    { 177, 73, 10 , 6 },
    { 195, 73, 7 , 11 },
    { 210, 73, 5 , 10 },
    { 223, 73, 7 , 12 },
    { 238, 73, 7 , 12 },
    { 253, 73, 7 , 12 },
    { 268, 73, 7 , 12 },
    { 283, 73, 7 , 11 },
    { 298, 73, 7 , 11 },
    { 313, 73, 12 , 9 },
    { 333, 73, 6 , 11 },
    { 347, 73, 7 , 12 },
    { 362, 73, 7 , 12 },
    { 377, 73, 7 , 12 },
    { 392, 73, 7 , 11 },
    { 407, 73, 3 , 12 },
    { 418, 73, 3 , 12 },
    { 429, 73, 3 , 12 },
    { 440, 73, 3 , 11 },
    { 451, 73, 7 , 9 },
    { 466, 73, 8 , 12 },
    { 482, 73, 6 , 12 },
    { 496, 73, 6 , 12 },
    { 4, 96, 6 , 12 },
    { 18, 96, 6 , 12 },
    { 32, 96, 6 , 11 },
    { 46, 96, 5 , 5 },
    { 59, 96, 8 , 9 },
    { 75, 96, 8 , 12 },
    { 91, 96, 8 , 12 },
    { 107, 96, 8 , 12 },
    { 123, 96, 8 , 11 },
    { 139, 96, 7 , 12 },
    { 154, 96, 7 , 9 },
    { 169, 96, 8 , 9 },
    { 185, 96, 6 , 9 },
    { 199, 96, 6 , 9 },
    { 213, 96, 6 , 9 },
    { 227, 96, 6 , 9 },
    { 241, 96, 6 , 8 },
    { 255, 96, 6 , 10 },
    { 269, 96, 10 , 6 },
    { 287, 96, 6 , 8 },
    { 301, 96, 6 , 9 },
    { 315, 96, 6 , 9 },
    { 329, 96, 6 , 9 },
    { 343, 96, 6 , 8 },
    { 357, 96, 3 , 10 },
    { 368, 96, 3 , 10 },
    { 379, 96, 3 , 10 },
    { 390, 96, 3 , 9 },
    { 401, 96, 6 , 10 },
    { 415, 96, 7 , 9 },
    { 430, 96, 5 , 9 },
    { 443, 96, 5 , 9 },
    { 456, 96, 5 , 9 },
    { 469, 96, 5 , 9 },
    { 482, 96, 5 , 8 },
    { 495, 96, 7 , 9 },
    { 4, 119, 8 , 8 },
    { 20, 119, 7 , 9 },
    { 35, 119, 7 , 9 },
    { 50, 119, 7 , 9 },
    { 65, 119, 7 , 8 },
    { 80, 119, 7 , 11 },
    { 95, 119, 5 , 8 },
    { 108, 119, 7 , 10 },
};

// Font glyphs info data
// NOTE: No glyphs.image data provided
static const GlyphInfo cherryFontGlyphs[189] = {
    { 32, 0, 12, 5, { 0 }},
    { 33, 0, 2, 4, { 0 }},
    { 34, 0, 2, 6, { 0 }},
    { 35, 0, 2, 11, { 0 }},
    { 36, 0, 2, 8, { 0 }},
    { 37, 0, 2, 8, { 0 }},
    { 38, 0, 2, 9, { 0 }},
    { 39, 0, 2, 2, { 0 }},
    { 40, 0, 2, 4, { 0 }},
    { 41, 0, 2, 4, { 0 }},
    { 42, 0, 2, 4, { 0 }},
    { 43, 0, 4, 8, { 0 }},
    { 44, 0, 11, 3, { 0 }},
    { 45, 0, 6, 7, { 0 }},
    { 46, 0, 11, 2, { 0 }},
    { 47, 0, 2, 5, { 0 }},
    { 48, 0, 4, 6, { 0 }},
    { 49, 0, 4, 6, { 0 }},
    { 50, 0, 4, 6, { 0 }},
    { 51, 0, 4, 6, { 0 }},
    { 52, 0, 4, 6, { 0 }},
    { 53, 0, 4, 6, { 0 }},
    { 54, 0, 4, 6, { 0 }},
    { 55, 0, 4, 6, { 0 }},
    { 56, 0, 4, 6, { 0 }},
    { 57, 0, 4, 6, { 0 }},
    { 58, 0, 2, 4, { 0 }},
    { 59, 0, 2, 4, { 0 }},
    { 60, 0, 4, 7, { 0 }},
    { 61, 0, 5, 7, { 0 }},
    { 62, 0, 4, 7, { 0 }},
    { 63, 0, 2, 6, { 0 }},
    { 64, 0, 2, 9, { 0 }},
    { 65, 0, 3, 8, { 0 }},
    { 66, 0, 3, 8, { 0 }},
    { 67, 0, 3, 7, { 0 }},
    { 68, 0, 3, 7, { 0 }},
    { 69, 0, 3, 8, { 0 }},
    { 70, 0, 3, 7, { 0 }},
    { 71, 0, 3, 7, { 0 }},
    { 72, 0, 3, 8, { 0 }},
    { 73, 0, 3, 4, { 0 }},
    { 74, 0, 3, 7, { 0 }},
    { 75, 0, 3, 8, { 0 }},
    { 76, 0, 3, 8, { 0 }},
    { 77, 0, 3, 12, { 0 }},
    { 78, 0, 3, 9, { 0 }},
    { 79, 0, 3, 7, { 0 }},
    { 80, 0, 3, 7, { 0 }},
    { 81, 0, 3, 8, { 0 }},
    { 82, 0, 3, 8, { 0 }},
    { 83, 0, 3, 7, { 0 }},
    { 84, 0, 3, 8, { 0 }},
    { 85, 0, 3, 9, { 0 }},
    { 86, 0, 3, 10, { 0 }},
    { 87, 0, 3, 12, { 0 }},
    { 88, 0, 3, 8, { 0 }},
    { 89, 0, 3, 8, { 0 }},
    { 90, 0, 3, 8, { 0 }},
    { 91, 0, 3, 4, { 0 }},
    { 92, 0, 2, 5, { 0 }},
    { 93, 0, 3, 4, { 0 }},
    { 94, 0, 3, 4, { 0 }},
    { 95, 0, 10, 8, { 0 }},
    { 96, 0, 2, 3, { 0 }},
    { 97, 0, 6, 7, { 0 }},
    { 98, 0, 3, 7, { 0 }},
    { 99, 0, 6, 7, { 0 }},
    { 100, 0, 3, 7, { 0 }},
    { 101, 0, 6, 7, { 0 }},
    { 102, 0, 3, 6, { 0 }},
    { 103, 0, 5, 6, { 0 }},
    { 104, 0, 3, 8, { 0 }},
    { 105, 0, 5, 4, { 0 }},
    { 106, 0, 5, 4, { 0 }},
    { 107, 0, 3, 7, { 0 }},
    { 108, 0, 3, 5, { 0 }},
    { 109, 0, 6, 12, { 0 }},
    { 110, 0, 6, 8, { 0 }},
    { 111, 0, 6, 6, { 0 }},
    { 112, 0, 6, 7, { 0 }},
    { 113, 0, 6, 7, { 0 }},
    { 114, 0, 6, 6, { 0 }},
    { 115, 0, 6, 6, { 0 }},
    { 116, 0, 3, 6, { 0 }},
    { 117, 0, 6, 8, { 0 }},
    { 118, 0, 6, 8, { 0 }},
    { 119, 0, 6, 12, { 0 }},
    { 120, 0, 6, 8, { 0 }},
    { 121, 0, 6, 8, { 0 }},
    { 122, 0, 6, 7, { 0 }},
    { 123, 0, 3, 6, { 0 }},
    { 124, 0, 3, 2, { 0 }},
    { 125, 0, 3, 6, { 0 }},
    { 126, 0, 6, 8, { 0 }},
    { 161, 0, 4, 4, { 0 }},
    { 162, 0, 4, 8, { 0 }},
    { 163, 0, 2, 8, { 0 }},
    { 8364, 0, 3, 7, { 0 }},
    { 165, 0, 3, 8, { 0 }},
    { 352, 0, 0, 7, { 0 }},
    { 167, 0, 2, 8, { 0 }},
    { 353, 0, 3, 6, { 0 }},
    { 169, 0, 1, 6, { 0 }},
    { 170, 0, 2, 5, { 0 }},
    { 171, 0, 5, 7, { 0 }},
    { 172, 0, 6, 7, { 0 }},
    { 174, 0, 1, 6, { 0 }},
    { 175, 0, 2, 7, { 0 }},
    { 176, 0, 2, 4, { 0 }},
    { 177, 0, 3, 8, { 0 }},
    { 178, 0, 2, 4, { 0 }},
    { 179, 0, 2, 4, { 0 }},
    { 381, 0, 0, 8, { 0 }},
    { 181, 0, 6, 7, { 0 }},
    { 182, 0, 3, 8, { 0 }},
    { 183, 0, 6, 3, { 0 }},
    { 382, 0, 3, 7, { 0 }},
    { 185, 0, 2, 4, { 0 }},
    { 186, 0, 2, 4, { 0 }},
    { 187, 0, 5, 7, { 0 }},
    { 338, 0, 3, 14, { 0 }},
    { 339, 0, 6, 11, { 0 }},
    { 376, 0, 1, 8, { 0 }},
    { 191, 0, 4, 6, { 0 }},
    { 192, 0, 0, 8, { 0 }},
    { 193, 0, 0, 8, { 0 }},
    { 194, 0, 0, 8, { 0 }},
    { 195, 0, 0, 8, { 0 }},
    { 196, 0, 1, 8, { 0 }},
    { 197, 0, 1, 8, { 0 }},
    { 198, 0, 3, 13, { 0 }},
    { 199, 0, 3, 7, { 0 }},
    { 200, 0, 0, 8, { 0 }},
    { 201, 0, 0, 8, { 0 }},
    { 202, 0, 0, 8, { 0 }},
    { 203, 0, 1, 8, { 0 }},
    { 204, 0, 0, 4, { 0 }},
    { 205, 0, 0, 4, { 0 }},
    { 206, 0, 0, 4, { 0 }},
    { 207, 0, 1, 4, { 0 }},
    { 208, 0, 3, 8, { 0 }},
    { 209, 0, 0, 9, { 0 }},
    { 210, 0, 0, 7, { 0 }},
    { 211, 0, 0, 7, { 0 }},
    { 212, 0, 0, 7, { 0 }},
    { 213, 0, 0, 7, { 0 }},
    { 214, 0, 1, 7, { 0 }},
    { 215, 1, 5, 7, { 0 }},
    { 216, 0, 3, 9, { 0 }},
    { 217, 0, 0, 9, { 0 }},
    { 218, 0, 0, 9, { 0 }},
    { 219, 0, 0, 9, { 0 }},
    { 220, 0, 1, 9, { 0 }},
    { 221, 0, 0, 8, { 0 }},
    { 222, 0, 2, 8, { 0 }},
    { 223, 0, 3, 9, { 0 }},
    { 224, 0, 3, 7, { 0 }},
    { 225, 0, 3, 7, { 0 }},
    { 226, 0, 3, 7, { 0 }},
    { 227, 0, 3, 7, { 0 }},
    { 228, 0, 4, 7, { 0 }},
    { 229, 0, 2, 7, { 0 }},
    { 230, 0, 6, 11, { 0 }},
    { 231, 0, 6, 7, { 0 }},
    { 232, 0, 3, 7, { 0 }},
    { 233, 0, 3, 7, { 0 }},
    { 234, 0, 3, 7, { 0 }},
    { 235, 0, 4, 7, { 0 }},
    { 236, 0, 2, 4, { 0 }},
    { 237, 0, 2, 4, { 0 }},
    { 238, 0, 2, 4, { 0 }},
    { 239, 0, 3, 4, { 0 }},
    { 240, 0, 2, 7, { 0 }},
    { 241, 0, 3, 8, { 0 }},
    { 242, 0, 3, 6, { 0 }},
    { 243, 0, 3, 6, { 0 }},
    { 244, 0, 3, 6, { 0 }},
    { 245, 0, 3, 6, { 0 }},
    { 246, 0, 4, 6, { 0 }},
    { 247, 0, 3, 8, { 0 }},
    { 248, 0, 4, 9, { 0 }},
    { 249, 0, 3, 8, { 0 }},
    { 250, 0, 3, 8, { 0 }},
    { 251, 0, 3, 8, { 0 }},
    { 252, 0, 4, 8, { 0 }},
    { 253, 0, 3, 8, { 0 }},
    { 254, 0, 4, 6, { 0 }},
    { 255, 0, 4, 8, { 0 }},
};

// Style loading function: Cherry
static void GuiLoadStyleCherry(void)
{
    // Load style properties provided
    // NOTE: Default properties are propagated
    for (int i = 0; i < CHERRY_STYLE_PROPS_COUNT; i++)
    {
        GuiSetStyle(cherryStyleProps[i].controlId, cherryStyleProps[i].propertyId, cherryStyleProps[i].propertyValue);
    }

    // Custom font loading
    // NOTE: Compressed font image data (DEFLATE), it requires DecompressData() function
    int cherryFontDataSize = 0;
    unsigned char *data = DecompressData(cherryFontData, CHERRY_STYLE_FONT_ATLAS_COMP_SIZE, &cherryFontDataSize);
    Image imFont = { data, 512, 256, 1, 2 };

    Font font = { 0 };
    font.baseSize = 15;
    font.glyphCount = 189;

    // Load texture from image
    font.texture = LoadTextureFromImage(imFont);
    UnloadImage(imFont);  // Uncompressed image data can be unloaded from memory

    // Copy char recs data from global fontRecs
    // NOTE: Required to avoid issues if trying to free font
    font.recs = (rlRectangle *)RAYGUI_MALLOC(font.glyphCount*sizeof(rlRectangle));
    memcpy(font.recs, cherryFontRecs, font.glyphCount*sizeof(rlRectangle));

    // Copy font char info data from global fontChars
    // NOTE: Required to avoid issues if trying to free font
    font.glyphs = (GlyphInfo *)RAYGUI_MALLOC(font.glyphCount*sizeof(GlyphInfo));
    memcpy(font.glyphs, cherryFontGlyphs, font.glyphCount*sizeof(GlyphInfo));

    GuiSetFont(font);

    // Setup a white rectangle on the font to be used on shapes drawing,
    // it makes possible to draw shapes and text (full UI) in a single draw call
    rlRectangle fontWhiteRec = { 510, 254, 1, 1 };
    SetShapesTexture(font.texture, fontWhiteRec);

    //-----------------------------------------------------------------

    // TODO: Custom user style setup: Set specific properties here (if required)
    // i.e. Controls specific BORDER_WIDTH, TEXT_PADDING, TEXT_ALIGNMENT
}