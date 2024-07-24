declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @testParam8( i32 %t290, i32 %t292, i32 %t294, i32 %t296, i32 %t298, i32 %t300, i32 %t302, i32 %t304) {
B288:
  %t303 = alloca i32, align 4
  %t301 = alloca i32, align 4
  %t299 = alloca i32, align 4
  %t297 = alloca i32, align 4
  %t295 = alloca i32, align 4
  %t293 = alloca i32, align 4
  %t291 = alloca i32, align 4
  %t289 = alloca i32, align 4
  store i32 %t290, i32* %t289, align 4
  store i32 %t292, i32* %t291, align 4
  store i32 %t294, i32* %t293, align 4
  store i32 %t296, i32* %t295, align 4
  store i32 %t298, i32* %t297, align 4
  store i32 %t300, i32* %t299, align 4
  store i32 %t302, i32* %t301, align 4
  store i32 %t304, i32* %t303, align 4
  %t8 = load i32, i32* %t289, align 4
  %t9 = load i32, i32* %t291, align 4
  %t10 = sub i32 %t8, %t9
  %t11 = load i32, i32* %t293, align 4
  %t12 = add i32 %t10, %t11
  %t13 = load i32, i32* %t295, align 4
  %t14 = sub i32 %t12, %t13
  %t15 = load i32, i32* %t297, align 4
  %t16 = sub i32 %t14, %t15
  %t17 = load i32, i32* %t299, align 4
  %t18 = sub i32 %t16, %t17
  %t19 = load i32, i32* %t301, align 4
  %t20 = add i32 %t18, %t19
  %t21 = load i32, i32* %t303, align 4
  %t22 = add i32 %t20, %t21
  ret i32 %t22
}
define i32 @testParam16( i32 %t307, i32 %t309, i32 %t311, i32 %t313, i32 %t315, i32 %t317, i32 %t319, i32 %t321, i32 %t323, i32 %t325, i32 %t327, i32 %t329, i32 %t331, i32 %t333, i32 %t335, i32 %t337) {
B305:
  %t336 = alloca i32, align 4
  %t334 = alloca i32, align 4
  %t332 = alloca i32, align 4
  %t330 = alloca i32, align 4
  %t328 = alloca i32, align 4
  %t326 = alloca i32, align 4
  %t324 = alloca i32, align 4
  %t322 = alloca i32, align 4
  %t320 = alloca i32, align 4
  %t318 = alloca i32, align 4
  %t316 = alloca i32, align 4
  %t314 = alloca i32, align 4
  %t312 = alloca i32, align 4
  %t310 = alloca i32, align 4
  %t308 = alloca i32, align 4
  %t306 = alloca i32, align 4
  store i32 %t307, i32* %t306, align 4
  store i32 %t309, i32* %t308, align 4
  store i32 %t311, i32* %t310, align 4
  store i32 %t313, i32* %t312, align 4
  store i32 %t315, i32* %t314, align 4
  store i32 %t317, i32* %t316, align 4
  store i32 %t319, i32* %t318, align 4
  store i32 %t321, i32* %t320, align 4
  store i32 %t323, i32* %t322, align 4
  store i32 %t325, i32* %t324, align 4
  store i32 %t327, i32* %t326, align 4
  store i32 %t329, i32* %t328, align 4
  store i32 %t331, i32* %t330, align 4
  store i32 %t333, i32* %t332, align 4
  store i32 %t335, i32* %t334, align 4
  store i32 %t337, i32* %t336, align 4
  %t39 = load i32, i32* %t306, align 4
  %t40 = load i32, i32* %t308, align 4
  %t41 = add i32 %t39, %t40
  %t42 = load i32, i32* %t310, align 4
  %t43 = add i32 %t41, %t42
  %t44 = load i32, i32* %t312, align 4
  %t45 = add i32 %t43, %t44
  %t46 = load i32, i32* %t314, align 4
  %t47 = sub i32 %t45, %t46
  %t48 = load i32, i32* %t316, align 4
  %t49 = add i32 %t47, %t48
  %t50 = load i32, i32* %t318, align 4
  %t51 = add i32 %t49, %t50
  %t52 = load i32, i32* %t320, align 4
  %t53 = add i32 %t51, %t52
  %t54 = load i32, i32* %t322, align 4
  %t55 = sub i32 %t53, %t54
  %t56 = load i32, i32* %t324, align 4
  %t57 = add i32 %t55, %t56
  %t58 = load i32, i32* %t326, align 4
  %t59 = sub i32 %t57, %t58
  %t60 = load i32, i32* %t328, align 4
  %t61 = add i32 %t59, %t60
  %t62 = load i32, i32* %t330, align 4
  %t63 = add i32 %t61, %t62
  %t64 = load i32, i32* %t332, align 4
  %t65 = add i32 %t63, %t64
  %t66 = load i32, i32* %t334, align 4
  %t67 = add i32 %t65, %t66
  %t68 = load i32, i32* %t336, align 4
  %t69 = add i32 %t67, %t68
  ret i32 %t69
}
define i32 @testParam32( i32 %t340, i32 %t342, i32 %t344, i32 %t346, i32 %t348, i32 %t350, i32 %t352, i32 %t354, i32 %t356, i32 %t358, i32 %t360, i32 %t362, i32 %t364, i32 %t366, i32 %t368, i32 %t370, i32 %t372, i32 %t374, i32 %t376, i32 %t378, i32 %t380, i32 %t382, i32 %t384, i32 %t386, i32 %t388, i32 %t390, i32 %t392, i32 %t394, i32 %t396, i32 %t398, i32 %t400, i32 %t402) {
B338:
  %t401 = alloca i32, align 4
  %t399 = alloca i32, align 4
  %t397 = alloca i32, align 4
  %t395 = alloca i32, align 4
  %t393 = alloca i32, align 4
  %t391 = alloca i32, align 4
  %t389 = alloca i32, align 4
  %t387 = alloca i32, align 4
  %t385 = alloca i32, align 4
  %t383 = alloca i32, align 4
  %t381 = alloca i32, align 4
  %t379 = alloca i32, align 4
  %t377 = alloca i32, align 4
  %t375 = alloca i32, align 4
  %t373 = alloca i32, align 4
  %t371 = alloca i32, align 4
  %t369 = alloca i32, align 4
  %t367 = alloca i32, align 4
  %t365 = alloca i32, align 4
  %t363 = alloca i32, align 4
  %t361 = alloca i32, align 4
  %t359 = alloca i32, align 4
  %t357 = alloca i32, align 4
  %t355 = alloca i32, align 4
  %t353 = alloca i32, align 4
  %t351 = alloca i32, align 4
  %t349 = alloca i32, align 4
  %t347 = alloca i32, align 4
  %t345 = alloca i32, align 4
  %t343 = alloca i32, align 4
  %t341 = alloca i32, align 4
  %t339 = alloca i32, align 4
  store i32 %t340, i32* %t339, align 4
  store i32 %t342, i32* %t341, align 4
  store i32 %t344, i32* %t343, align 4
  store i32 %t346, i32* %t345, align 4
  store i32 %t348, i32* %t347, align 4
  store i32 %t350, i32* %t349, align 4
  store i32 %t352, i32* %t351, align 4
  store i32 %t354, i32* %t353, align 4
  store i32 %t356, i32* %t355, align 4
  store i32 %t358, i32* %t357, align 4
  store i32 %t360, i32* %t359, align 4
  store i32 %t362, i32* %t361, align 4
  store i32 %t364, i32* %t363, align 4
  store i32 %t366, i32* %t365, align 4
  store i32 %t368, i32* %t367, align 4
  store i32 %t370, i32* %t369, align 4
  store i32 %t372, i32* %t371, align 4
  store i32 %t374, i32* %t373, align 4
  store i32 %t376, i32* %t375, align 4
  store i32 %t378, i32* %t377, align 4
  store i32 %t380, i32* %t379, align 4
  store i32 %t382, i32* %t381, align 4
  store i32 %t384, i32* %t383, align 4
  store i32 %t386, i32* %t385, align 4
  store i32 %t388, i32* %t387, align 4
  store i32 %t390, i32* %t389, align 4
  store i32 %t392, i32* %t391, align 4
  store i32 %t394, i32* %t393, align 4
  store i32 %t396, i32* %t395, align 4
  store i32 %t398, i32* %t397, align 4
  store i32 %t400, i32* %t399, align 4
  store i32 %t402, i32* %t401, align 4
  %t102 = load i32, i32* %t339, align 4
  %t103 = load i32, i32* %t341, align 4
  %t104 = load i32, i32* %t343, align 4
  %t105 = mul i32 %t103, %t104
  %t106 = add i32 %t102, %t105
  %t107 = load i32, i32* %t345, align 4
  %t108 = add i32 %t106, %t107
  %t109 = load i32, i32* %t347, align 4
  %t110 = add i32 %t108, %t109
  %t111 = load i32, i32* %t349, align 4
  %t112 = add i32 %t110, %t111
  %t113 = load i32, i32* %t351, align 4
  %t114 = add i32 %t112, %t113
  %t115 = load i32, i32* %t353, align 4
  %t116 = add i32 %t114, %t115
  %t117 = load i32, i32* %t355, align 4
  %t118 = add i32 %t116, %t117
  %t119 = load i32, i32* %t357, align 4
  %t120 = add i32 %t118, %t119
  %t121 = load i32, i32* %t359, align 4
  %t122 = add i32 %t120, %t121
  %t123 = load i32, i32* %t361, align 4
  %t124 = add i32 %t122, %t123
  %t125 = load i32, i32* %t363, align 4
  %t126 = sub i32 %t124, %t125
  %t127 = load i32, i32* %t365, align 4
  %t128 = sub i32 %t126, %t127
  %t129 = load i32, i32* %t367, align 4
  %t130 = sub i32 %t128, %t129
  %t131 = load i32, i32* %t369, align 4
  %t132 = sub i32 %t130, %t131
  %t133 = load i32, i32* %t371, align 4
  %t134 = sub i32 %t132, %t133
  %t135 = load i32, i32* %t373, align 4
  %t136 = sub i32 %t134, %t135
  %t137 = load i32, i32* %t375, align 4
  %t138 = sub i32 %t136, %t137
  %t139 = load i32, i32* %t377, align 4
  %t140 = sub i32 %t138, %t139
  %t141 = load i32, i32* %t379, align 4
  %t142 = sub i32 %t140, %t141
  %t143 = load i32, i32* %t381, align 4
  %t144 = sub i32 %t142, %t143
  %t145 = load i32, i32* %t383, align 4
  %t146 = add i32 %t144, %t145
  %t147 = load i32, i32* %t385, align 4
  %t148 = add i32 %t146, %t147
  %t149 = load i32, i32* %t387, align 4
  %t150 = add i32 %t148, %t149
  %t151 = load i32, i32* %t389, align 4
  %t152 = add i32 %t150, %t151
  %t153 = load i32, i32* %t391, align 4
  %t154 = add i32 %t152, %t153
  %t155 = load i32, i32* %t393, align 4
  %t156 = add i32 %t154, %t155
  %t157 = load i32, i32* %t395, align 4
  %t158 = add i32 %t156, %t157
  %t159 = load i32, i32* %t397, align 4
  %t160 = add i32 %t158, %t159
  %t161 = load i32, i32* %t399, align 4
  %t162 = add i32 %t160, %t161
  %t163 = load i32, i32* %t401, align 4
  %t164 = add i32 %t162, %t163
  ret i32 %t164
}
define i32 @main() {
B403:
  %t435 = alloca i32, align 4
  %t434 = alloca i32, align 4
  %t433 = alloca i32, align 4
  %t432 = alloca i32, align 4
  %t431 = alloca i32, align 4
  %t430 = alloca i32, align 4
  %t429 = alloca i32, align 4
  %t428 = alloca i32, align 4
  %t427 = alloca i32, align 4
  %t426 = alloca i32, align 4
  %t425 = alloca i32, align 4
  %t424 = alloca i32, align 4
  %t423 = alloca i32, align 4
  %t422 = alloca i32, align 4
  %t421 = alloca i32, align 4
  %t420 = alloca i32, align 4
  %t419 = alloca i32, align 4
  %t418 = alloca i32, align 4
  %t417 = alloca i32, align 4
  %t416 = alloca i32, align 4
  %t415 = alloca i32, align 4
  %t414 = alloca i32, align 4
  %t413 = alloca i32, align 4
  %t412 = alloca i32, align 4
  %t411 = alloca i32, align 4
  %t410 = alloca i32, align 4
  %t409 = alloca i32, align 4
  %t408 = alloca i32, align 4
  %t407 = alloca i32, align 4
  %t406 = alloca i32, align 4
  %t405 = alloca i32, align 4
  %t404 = alloca i32, align 4
  store i32 0, i32* %t404, align 4
  store i32 1, i32* %t405, align 4
  store i32 2, i32* %t406, align 4
  store i32 3, i32* %t407, align 4
  store i32 4, i32* %t408, align 4
  store i32 5, i32* %t409, align 4
  store i32 6, i32* %t410, align 4
  store i32 7, i32* %t411, align 4
  store i32 8, i32* %t412, align 4
  store i32 9, i32* %t413, align 4
  store i32 0, i32* %t414, align 4
  store i32 1, i32* %t415, align 4
  store i32 2, i32* %t416, align 4
  store i32 3, i32* %t417, align 4
  store i32 4, i32* %t418, align 4
  store i32 5, i32* %t419, align 4
  store i32 6, i32* %t420, align 4
  store i32 7, i32* %t421, align 4
  store i32 8, i32* %t422, align 4
  store i32 9, i32* %t423, align 4
  store i32 0, i32* %t424, align 4
  store i32 1, i32* %t425, align 4
  store i32 2, i32* %t426, align 4
  store i32 3, i32* %t427, align 4
  store i32 4, i32* %t428, align 4
  store i32 5, i32* %t429, align 4
  store i32 6, i32* %t430, align 4
  store i32 7, i32* %t431, align 4
  store i32 8, i32* %t432, align 4
  store i32 9, i32* %t433, align 4
  store i32 0, i32* %t434, align 4
  store i32 1, i32* %t435, align 4
  %t230 = load i32, i32* %t404, align 4
  %t231 = load i32, i32* %t405, align 4
  %t232 = load i32, i32* %t406, align 4
  %t233 = load i32, i32* %t407, align 4
  %t234 = load i32, i32* %t408, align 4
  %t235 = load i32, i32* %t409, align 4
  %t236 = load i32, i32* %t410, align 4
  %t237 = load i32, i32* %t411, align 4
  %t238 = call i32 @testParam8(i32 %t230, i32 %t231, i32 %t232, i32 %t233, i32 %t234, i32 %t235, i32 %t236, i32 %t237)
  %t239 = load i32, i32* %t405, align 4
  %t240 = load i32, i32* %t406, align 4
  %t241 = load i32, i32* %t407, align 4
  %t242 = load i32, i32* %t408, align 4
  %t243 = load i32, i32* %t409, align 4
  %t244 = load i32, i32* %t410, align 4
  %t245 = load i32, i32* %t411, align 4
  %t246 = load i32, i32* %t412, align 4
  %t247 = load i32, i32* %t413, align 4
  %t248 = load i32, i32* %t414, align 4
  %t249 = load i32, i32* %t415, align 4
  %t250 = load i32, i32* %t416, align 4
  %t251 = load i32, i32* %t417, align 4
  %t252 = load i32, i32* %t418, align 4
  %t253 = load i32, i32* %t419, align 4
  %t254 = call i32 @testParam16(i32 %t238, i32 %t239, i32 %t240, i32 %t241, i32 %t242, i32 %t243, i32 %t244, i32 %t245, i32 %t246, i32 %t247, i32 %t248, i32 %t249, i32 %t250, i32 %t251, i32 %t252, i32 %t253)
  %t255 = load i32, i32* %t405, align 4
  %t256 = load i32, i32* %t406, align 4
  %t257 = load i32, i32* %t407, align 4
  %t258 = load i32, i32* %t408, align 4
  %t259 = load i32, i32* %t409, align 4
  %t260 = load i32, i32* %t410, align 4
  %t261 = load i32, i32* %t411, align 4
  %t262 = load i32, i32* %t412, align 4
  %t263 = load i32, i32* %t413, align 4
  %t264 = load i32, i32* %t414, align 4
  %t265 = load i32, i32* %t415, align 4
  %t266 = load i32, i32* %t416, align 4
  %t267 = load i32, i32* %t417, align 4
  %t268 = load i32, i32* %t418, align 4
  %t269 = load i32, i32* %t419, align 4
  %t270 = load i32, i32* %t420, align 4
  %t271 = load i32, i32* %t421, align 4
  %t272 = load i32, i32* %t422, align 4
  %t273 = load i32, i32* %t423, align 4
  %t274 = load i32, i32* %t424, align 4
  %t275 = load i32, i32* %t425, align 4
  %t276 = load i32, i32* %t426, align 4
  %t277 = load i32, i32* %t427, align 4
  %t278 = load i32, i32* %t428, align 4
  %t279 = load i32, i32* %t429, align 4
  %t280 = load i32, i32* %t430, align 4
  %t281 = load i32, i32* %t431, align 4
  %t282 = load i32, i32* %t432, align 4
  %t283 = load i32, i32* %t433, align 4
  %t284 = load i32, i32* %t434, align 4
  %t285 = load i32, i32* %t435, align 4
  %t286 = call i32 @testParam32(i32 %t254, i32 %t255, i32 %t256, i32 %t257, i32 %t258, i32 %t259, i32 %t260, i32 %t261, i32 %t262, i32 %t263, i32 %t264, i32 %t265, i32 %t266, i32 %t267, i32 %t268, i32 %t269, i32 %t270, i32 %t271, i32 %t272, i32 %t273, i32 %t274, i32 %t275, i32 %t276, i32 %t277, i32 %t278, i32 %t279, i32 %t280, i32 %t281, i32 %t282, i32 %t283, i32 %t284, i32 %t285)
  store i32 %t286, i32* %t404, align 4
  %t287 = load i32, i32* %t404, align 4
  call void @putint(i32 %t287)
  ret i32 0
}
