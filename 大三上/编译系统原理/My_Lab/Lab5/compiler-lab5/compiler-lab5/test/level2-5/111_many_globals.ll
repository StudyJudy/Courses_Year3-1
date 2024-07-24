declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a0 = global i32 0, align 4 
@a1 = global i32 0, align 4 
@a2 = global i32 0, align 4 
@a3 = global i32 0, align 4 
@a4 = global i32 0, align 4 
@a5 = global i32 0, align 4 
@a6 = global i32 0, align 4 
@a7 = global i32 0, align 4 
@a8 = global i32 0, align 4 
@a9 = global i32 0, align 4 
@a10 = global i32 0, align 4 
@a11 = global i32 0, align 4 
@a12 = global i32 0, align 4 
@a13 = global i32 0, align 4 
@a14 = global i32 0, align 4 
@a15 = global i32 0, align 4 
@a16 = global i32 0, align 4 
@a17 = global i32 0, align 4 
@a18 = global i32 0, align 4 
@a19 = global i32 0, align 4 
@a20 = global i32 0, align 4 
@a21 = global i32 0, align 4 
@a22 = global i32 0, align 4 
@a23 = global i32 0, align 4 
@a24 = global i32 0, align 4 
@a25 = global i32 0, align 4 
@a26 = global i32 0, align 4 
@a27 = global i32 0, align 4 
@a28 = global i32 0, align 4 
@a29 = global i32 0, align 4 
@a30 = global i32 0, align 4 
@a31 = global i32 0, align 4 
@a32 = global i32 0, align 4 
@a33 = global i32 0, align 4 
@a34 = global i32 0, align 4 
@a35 = global i32 0, align 4 
@a36 = global i32 0, align 4 
@a37 = global i32 0, align 4 
@a38 = global i32 0, align 4 
@a39 = global i32 0, align 4 
define i32 @testParam8( i32 %t312, i32 %t314, i32 %t316, i32 %t318, i32 %t320, i32 %t322, i32 %t324, i32 %t326) {
B310:
  %t325 = alloca i32, align 4
  %t323 = alloca i32, align 4
  %t321 = alloca i32, align 4
  %t319 = alloca i32, align 4
  %t317 = alloca i32, align 4
  %t315 = alloca i32, align 4
  %t313 = alloca i32, align 4
  %t311 = alloca i32, align 4
  store i32 %t312, i32* %t311, align 4
  store i32 %t314, i32* %t313, align 4
  store i32 %t316, i32* %t315, align 4
  store i32 %t318, i32* %t317, align 4
  store i32 %t320, i32* %t319, align 4
  store i32 %t322, i32* %t321, align 4
  store i32 %t324, i32* %t323, align 4
  store i32 %t326, i32* %t325, align 4
  %t48 = load i32, i32* %t311, align 4
  %t49 = load i32, i32* %t313, align 4
  %t50 = add i32 %t48, %t49
  %t51 = load i32, i32* %t315, align 4
  %t52 = add i32 %t50, %t51
  %t53 = load i32, i32* %t317, align 4
  %t54 = add i32 %t52, %t53
  %t55 = load i32, i32* %t319, align 4
  %t56 = add i32 %t54, %t55
  %t57 = load i32, i32* %t321, align 4
  %t58 = add i32 %t56, %t57
  %t59 = load i32, i32* %t323, align 4
  %t60 = add i32 %t58, %t59
  %t61 = load i32, i32* %t325, align 4
  %t62 = add i32 %t60, %t61
  ret i32 %t62
}
define i32 @testParam16( i32 %t329, i32 %t331, i32 %t333, i32 %t335, i32 %t337, i32 %t339, i32 %t341, i32 %t343, i32 %t345, i32 %t347, i32 %t349, i32 %t351, i32 %t353, i32 %t355, i32 %t357, i32 %t359) {
B327:
  %t358 = alloca i32, align 4
  %t356 = alloca i32, align 4
  %t354 = alloca i32, align 4
  %t352 = alloca i32, align 4
  %t350 = alloca i32, align 4
  %t348 = alloca i32, align 4
  %t346 = alloca i32, align 4
  %t344 = alloca i32, align 4
  %t342 = alloca i32, align 4
  %t340 = alloca i32, align 4
  %t338 = alloca i32, align 4
  %t336 = alloca i32, align 4
  %t334 = alloca i32, align 4
  %t332 = alloca i32, align 4
  %t330 = alloca i32, align 4
  %t328 = alloca i32, align 4
  store i32 %t329, i32* %t328, align 4
  store i32 %t331, i32* %t330, align 4
  store i32 %t333, i32* %t332, align 4
  store i32 %t335, i32* %t334, align 4
  store i32 %t337, i32* %t336, align 4
  store i32 %t339, i32* %t338, align 4
  store i32 %t341, i32* %t340, align 4
  store i32 %t343, i32* %t342, align 4
  store i32 %t345, i32* %t344, align 4
  store i32 %t347, i32* %t346, align 4
  store i32 %t349, i32* %t348, align 4
  store i32 %t351, i32* %t350, align 4
  store i32 %t353, i32* %t352, align 4
  store i32 %t355, i32* %t354, align 4
  store i32 %t357, i32* %t356, align 4
  store i32 %t359, i32* %t358, align 4
  %t79 = load i32, i32* %t328, align 4
  %t80 = load i32, i32* %t330, align 4
  %t81 = add i32 %t79, %t80
  %t82 = load i32, i32* %t332, align 4
  %t83 = add i32 %t81, %t82
  %t84 = load i32, i32* %t334, align 4
  %t85 = sub i32 %t83, %t84
  %t86 = load i32, i32* %t336, align 4
  %t87 = sub i32 %t85, %t86
  %t88 = load i32, i32* %t338, align 4
  %t89 = sub i32 %t87, %t88
  %t90 = load i32, i32* %t340, align 4
  %t91 = sub i32 %t89, %t90
  %t92 = load i32, i32* %t342, align 4
  %t93 = sub i32 %t91, %t92
  %t94 = load i32, i32* %t344, align 4
  %t95 = add i32 %t93, %t94
  %t96 = load i32, i32* %t346, align 4
  %t97 = add i32 %t95, %t96
  %t98 = load i32, i32* %t348, align 4
  %t99 = add i32 %t97, %t98
  %t100 = load i32, i32* %t350, align 4
  %t101 = add i32 %t99, %t100
  %t102 = load i32, i32* %t352, align 4
  %t103 = add i32 %t101, %t102
  %t104 = load i32, i32* %t354, align 4
  %t105 = add i32 %t103, %t104
  %t106 = load i32, i32* %t356, align 4
  %t107 = add i32 %t105, %t106
  %t108 = load i32, i32* %t358, align 4
  %t109 = add i32 %t107, %t108
  ret i32 %t109
}
define i32 @testParam32( i32 %t362, i32 %t364, i32 %t366, i32 %t368, i32 %t370, i32 %t372, i32 %t374, i32 %t376, i32 %t378, i32 %t380, i32 %t382, i32 %t384, i32 %t386, i32 %t388, i32 %t390, i32 %t392, i32 %t394, i32 %t396, i32 %t398, i32 %t400, i32 %t402, i32 %t404, i32 %t406, i32 %t408, i32 %t410, i32 %t412, i32 %t414, i32 %t416, i32 %t418, i32 %t420, i32 %t422, i32 %t424) {
B360:
  %t423 = alloca i32, align 4
  %t421 = alloca i32, align 4
  %t419 = alloca i32, align 4
  %t417 = alloca i32, align 4
  %t415 = alloca i32, align 4
  %t413 = alloca i32, align 4
  %t411 = alloca i32, align 4
  %t409 = alloca i32, align 4
  %t407 = alloca i32, align 4
  %t405 = alloca i32, align 4
  %t403 = alloca i32, align 4
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
  store i32 %t404, i32* %t403, align 4
  store i32 %t406, i32* %t405, align 4
  store i32 %t408, i32* %t407, align 4
  store i32 %t410, i32* %t409, align 4
  store i32 %t412, i32* %t411, align 4
  store i32 %t414, i32* %t413, align 4
  store i32 %t416, i32* %t415, align 4
  store i32 %t418, i32* %t417, align 4
  store i32 %t420, i32* %t419, align 4
  store i32 %t422, i32* %t421, align 4
  store i32 %t424, i32* %t423, align 4
  %t142 = load i32, i32* %t361, align 4
  %t143 = load i32, i32* %t363, align 4
  %t144 = add i32 %t142, %t143
  %t145 = load i32, i32* %t365, align 4
  %t146 = add i32 %t144, %t145
  %t147 = load i32, i32* %t367, align 4
  %t148 = add i32 %t146, %t147
  %t149 = load i32, i32* %t369, align 4
  %t150 = add i32 %t148, %t149
  %t151 = load i32, i32* %t371, align 4
  %t152 = add i32 %t150, %t151
  %t153 = load i32, i32* %t373, align 4
  %t154 = add i32 %t152, %t153
  %t155 = load i32, i32* %t375, align 4
  %t156 = add i32 %t154, %t155
  %t157 = load i32, i32* %t377, align 4
  %t158 = add i32 %t156, %t157
  %t159 = load i32, i32* %t379, align 4
  %t160 = add i32 %t158, %t159
  %t161 = load i32, i32* %t381, align 4
  %t162 = add i32 %t160, %t161
  %t163 = load i32, i32* %t383, align 4
  %t164 = add i32 %t162, %t163
  %t165 = load i32, i32* %t385, align 4
  %t166 = add i32 %t164, %t165
  %t167 = load i32, i32* %t387, align 4
  %t168 = add i32 %t166, %t167
  %t169 = load i32, i32* %t389, align 4
  %t170 = add i32 %t168, %t169
  %t171 = load i32, i32* %t391, align 4
  %t172 = add i32 %t170, %t171
  %t173 = load i32, i32* %t393, align 4
  %t174 = add i32 %t172, %t173
  %t175 = load i32, i32* %t395, align 4
  %t176 = add i32 %t174, %t175
  %t177 = load i32, i32* %t397, align 4
  %t178 = sub i32 %t176, %t177
  %t179 = load i32, i32* %t399, align 4
  %t180 = sub i32 %t178, %t179
  %t181 = load i32, i32* %t401, align 4
  %t182 = sub i32 %t180, %t181
  %t183 = load i32, i32* %t403, align 4
  %t184 = sub i32 %t182, %t183
  %t185 = load i32, i32* %t405, align 4
  %t186 = sub i32 %t184, %t185
  %t187 = load i32, i32* %t407, align 4
  %t188 = add i32 %t186, %t187
  %t189 = load i32, i32* %t409, align 4
  %t190 = add i32 %t188, %t189
  %t191 = load i32, i32* %t411, align 4
  %t192 = add i32 %t190, %t191
  %t193 = load i32, i32* %t413, align 4
  %t194 = add i32 %t192, %t193
  %t195 = load i32, i32* %t415, align 4
  %t196 = add i32 %t194, %t195
  %t197 = load i32, i32* %t417, align 4
  %t198 = add i32 %t196, %t197
  %t199 = load i32, i32* %t419, align 4
  %t200 = add i32 %t198, %t199
  %t201 = load i32, i32* %t421, align 4
  %t202 = add i32 %t200, %t201
  %t203 = load i32, i32* %t423, align 4
  %t204 = add i32 %t202, %t203
  ret i32 %t204
}
define i32 @main() {
B425:
  store i32 0, i32* @a0, align 4
  store i32 1, i32* @a1, align 4
  store i32 2, i32* @a2, align 4
  store i32 3, i32* @a3, align 4
  store i32 4, i32* @a4, align 4
  store i32 5, i32* @a5, align 4
  store i32 6, i32* @a6, align 4
  store i32 7, i32* @a7, align 4
  store i32 8, i32* @a8, align 4
  store i32 9, i32* @a9, align 4
  store i32 0, i32* @a10, align 4
  store i32 1, i32* @a11, align 4
  store i32 2, i32* @a12, align 4
  store i32 3, i32* @a13, align 4
  store i32 4, i32* @a14, align 4
  store i32 5, i32* @a15, align 4
  store i32 6, i32* @a16, align 4
  store i32 7, i32* @a17, align 4
  store i32 8, i32* @a18, align 4
  store i32 9, i32* @a19, align 4
  store i32 0, i32* @a20, align 4
  store i32 1, i32* @a21, align 4
  store i32 2, i32* @a22, align 4
  store i32 3, i32* @a23, align 4
  store i32 4, i32* @a24, align 4
  store i32 5, i32* @a25, align 4
  store i32 6, i32* @a26, align 4
  store i32 7, i32* @a27, align 4
  store i32 8, i32* @a28, align 4
  store i32 9, i32* @a29, align 4
  store i32 0, i32* @a30, align 4
  store i32 1, i32* @a31, align 4
  store i32 4, i32* @a32, align 4
  store i32 5, i32* @a33, align 4
  store i32 6, i32* @a34, align 4
  store i32 7, i32* @a35, align 4
  store i32 8, i32* @a36, align 4
  store i32 9, i32* @a37, align 4
  store i32 0, i32* @a38, align 4
  store i32 1, i32* @a39, align 4
  %t246 = load i32, i32* @a0, align 4
  %t247 = load i32, i32* @a1, align 4
  %t248 = load i32, i32* @a2, align 4
  %t249 = load i32, i32* @a3, align 4
  %t250 = load i32, i32* @a4, align 4
  %t251 = load i32, i32* @a5, align 4
  %t252 = load i32, i32* @a6, align 4
  %t253 = load i32, i32* @a7, align 4
  %t254 = call i32 @testParam8(i32 %t246, i32 %t247, i32 %t248, i32 %t249, i32 %t250, i32 %t251, i32 %t252, i32 %t253)
  store i32 %t254, i32* @a0, align 4
  %t255 = load i32, i32* @a0, align 4
  call void @putint(i32 %t255)
  %t257 = load i32, i32* @a32, align 4
  %t258 = load i32, i32* @a33, align 4
  %t259 = load i32, i32* @a34, align 4
  %t260 = load i32, i32* @a35, align 4
  %t261 = load i32, i32* @a36, align 4
  %t262 = load i32, i32* @a37, align 4
  %t263 = load i32, i32* @a38, align 4
  %t264 = load i32, i32* @a39, align 4
  %t265 = load i32, i32* @a8, align 4
  %t266 = load i32, i32* @a9, align 4
  %t267 = load i32, i32* @a10, align 4
  %t268 = load i32, i32* @a11, align 4
  %t269 = load i32, i32* @a12, align 4
  %t270 = load i32, i32* @a13, align 4
  %t271 = load i32, i32* @a14, align 4
  %t272 = load i32, i32* @a15, align 4
  %t273 = call i32 @testParam16(i32 %t257, i32 %t258, i32 %t259, i32 %t260, i32 %t261, i32 %t262, i32 %t263, i32 %t264, i32 %t265, i32 %t266, i32 %t267, i32 %t268, i32 %t269, i32 %t270, i32 %t271, i32 %t272)
  store i32 %t273, i32* @a0, align 4
  %t274 = load i32, i32* @a0, align 4
  call void @putint(i32 %t274)
  %t276 = load i32, i32* @a0, align 4
  %t277 = load i32, i32* @a1, align 4
  %t278 = load i32, i32* @a2, align 4
  %t279 = load i32, i32* @a3, align 4
  %t280 = load i32, i32* @a4, align 4
  %t281 = load i32, i32* @a5, align 4
  %t282 = load i32, i32* @a6, align 4
  %t283 = load i32, i32* @a7, align 4
  %t284 = load i32, i32* @a8, align 4
  %t285 = load i32, i32* @a9, align 4
  %t286 = load i32, i32* @a10, align 4
  %t287 = load i32, i32* @a11, align 4
  %t288 = load i32, i32* @a12, align 4
  %t289 = load i32, i32* @a13, align 4
  %t290 = load i32, i32* @a14, align 4
  %t291 = load i32, i32* @a15, align 4
  %t292 = load i32, i32* @a16, align 4
  %t293 = load i32, i32* @a17, align 4
  %t294 = load i32, i32* @a18, align 4
  %t295 = load i32, i32* @a19, align 4
  %t296 = load i32, i32* @a20, align 4
  %t297 = load i32, i32* @a21, align 4
  %t298 = load i32, i32* @a22, align 4
  %t299 = load i32, i32* @a23, align 4
  %t300 = load i32, i32* @a24, align 4
  %t301 = load i32, i32* @a25, align 4
  %t302 = load i32, i32* @a26, align 4
  %t303 = load i32, i32* @a27, align 4
  %t304 = load i32, i32* @a28, align 4
  %t305 = load i32, i32* @a29, align 4
  %t306 = load i32, i32* @a30, align 4
  %t307 = load i32, i32* @a31, align 4
  %t308 = call i32 @testParam32(i32 %t276, i32 %t277, i32 %t278, i32 %t279, i32 %t280, i32 %t281, i32 %t282, i32 %t283, i32 %t284, i32 %t285, i32 %t286, i32 %t287, i32 %t288, i32 %t289, i32 %t290, i32 %t291, i32 %t292, i32 %t293, i32 %t294, i32 %t295, i32 %t296, i32 %t297, i32 %t298, i32 %t299, i32 %t300, i32 %t301, i32 %t302, i32 %t303, i32 %t304, i32 %t305, i32 %t306, i32 %t307)
  store i32 %t308, i32* @a0, align 4
  %t309 = load i32, i32* @a0, align 4
  call void @putint(i32 %t309)
  ret i32 0
}
