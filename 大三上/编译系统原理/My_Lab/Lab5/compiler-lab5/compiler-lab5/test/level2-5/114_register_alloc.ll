declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a1 = global i32 1, align 4 
@a2 = global i32 2, align 4 
@a3 = global i32 3, align 4 
@a4 = global i32 4, align 4 
@a5 = global i32 5, align 4 
@a6 = global i32 6, align 4 
@a7 = global i32 7, align 4 
@a8 = global i32 8, align 4 
@a9 = global i32 9, align 4 
@a10 = global i32 10, align 4 
@a11 = global i32 11, align 4 
@a12 = global i32 12, align 4 
@a13 = global i32 13, align 4 
@a14 = global i32 14, align 4 
@a15 = global i32 15, align 4 
@a16 = global i32 16, align 4 
@a17 = global i32 1, align 4 
@a18 = global i32 2, align 4 
@a19 = global i32 3, align 4 
@a20 = global i32 4, align 4 
@a21 = global i32 5, align 4 
@a22 = global i32 6, align 4 
@a23 = global i32 7, align 4 
@a24 = global i32 8, align 4 
@a25 = global i32 9, align 4 
@a26 = global i32 10, align 4 
@a27 = global i32 11, align 4 
@a28 = global i32 12, align 4 
@a29 = global i32 13, align 4 
@a30 = global i32 14, align 4 
@a31 = global i32 15, align 4 
@a32 = global i32 16, align 4 
define i32 @func( i32 %t581, i32 %t583) {
B579:
  %t620 = alloca i32, align 4
  %t619 = alloca i32, align 4
  %t618 = alloca i32, align 4
  %t617 = alloca i32, align 4
  %t616 = alloca i32, align 4
  %t615 = alloca i32, align 4
  %t614 = alloca i32, align 4
  %t613 = alloca i32, align 4
  %t612 = alloca i32, align 4
  %t611 = alloca i32, align 4
  %t610 = alloca i32, align 4
  %t609 = alloca i32, align 4
  %t608 = alloca i32, align 4
  %t607 = alloca i32, align 4
  %t606 = alloca i32, align 4
  %t605 = alloca i32, align 4
  %t604 = alloca i32, align 4
  %t603 = alloca i32, align 4
  %t602 = alloca i32, align 4
  %t601 = alloca i32, align 4
  %t600 = alloca i32, align 4
  %t599 = alloca i32, align 4
  %t598 = alloca i32, align 4
  %t597 = alloca i32, align 4
  %t596 = alloca i32, align 4
  %t595 = alloca i32, align 4
  %t594 = alloca i32, align 4
  %t593 = alloca i32, align 4
  %t592 = alloca i32, align 4
  %t591 = alloca i32, align 4
  %t590 = alloca i32, align 4
  %t589 = alloca i32, align 4
  %t588 = alloca i32, align 4
  %t587 = alloca i32, align 4
  %t586 = alloca i32, align 4
  %t585 = alloca i32, align 4
  %t584 = alloca i32, align 4
  %t582 = alloca i32, align 4
  %t580 = alloca i32, align 4
  store i32 %t581, i32* %t580, align 4
  store i32 %t583, i32* %t582, align 4
  %t36 = load i32, i32* %t580, align 4
  %t37 = load i32, i32* %t582, align 4
  %t38 = add i32 %t36, %t37
  store i32 %t38, i32* %t584, align 4
  %t76 = call i32 @getint()
  store i32 %t76, i32* %t585, align 4
  %t78 = call i32 @getint()
  store i32 %t78, i32* %t586, align 4
  %t80 = call i32 @getint()
  store i32 %t80, i32* %t587, align 4
  %t82 = call i32 @getint()
  store i32 %t82, i32* %t588, align 4
  %t84 = load i32, i32* %t585, align 4
  %t85 = add i32 1, %t84
  %t86 = load i32, i32* @a1, align 4
  %t87 = add i32 %t85, %t86
  store i32 %t87, i32* %t589, align 4
  %t89 = load i32, i32* %t586, align 4
  %t90 = add i32 2, %t89
  %t91 = load i32, i32* @a2, align 4
  %t92 = add i32 %t90, %t91
  store i32 %t92, i32* %t590, align 4
  %t94 = load i32, i32* %t587, align 4
  %t95 = add i32 3, %t94
  %t96 = load i32, i32* @a3, align 4
  %t97 = add i32 %t95, %t96
  store i32 %t97, i32* %t591, align 4
  %t99 = load i32, i32* %t588, align 4
  %t100 = add i32 4, %t99
  %t101 = load i32, i32* @a4, align 4
  %t102 = add i32 %t100, %t101
  store i32 %t102, i32* %t592, align 4
  %t104 = load i32, i32* %t589, align 4
  %t105 = add i32 1, %t104
  %t106 = load i32, i32* @a5, align 4
  %t107 = add i32 %t105, %t106
  store i32 %t107, i32* %t593, align 4
  %t109 = load i32, i32* %t590, align 4
  %t110 = add i32 2, %t109
  %t111 = load i32, i32* @a6, align 4
  %t112 = add i32 %t110, %t111
  store i32 %t112, i32* %t594, align 4
  %t114 = load i32, i32* %t591, align 4
  %t115 = add i32 3, %t114
  %t116 = load i32, i32* @a7, align 4
  %t117 = add i32 %t115, %t116
  store i32 %t117, i32* %t595, align 4
  %t119 = load i32, i32* %t592, align 4
  %t120 = add i32 4, %t119
  %t121 = load i32, i32* @a8, align 4
  %t122 = add i32 %t120, %t121
  store i32 %t122, i32* %t596, align 4
  %t124 = load i32, i32* %t593, align 4
  %t125 = add i32 1, %t124
  %t126 = load i32, i32* @a9, align 4
  %t127 = add i32 %t125, %t126
  store i32 %t127, i32* %t597, align 4
  %t129 = load i32, i32* %t594, align 4
  %t130 = add i32 2, %t129
  %t131 = load i32, i32* @a10, align 4
  %t132 = add i32 %t130, %t131
  store i32 %t132, i32* %t598, align 4
  %t134 = load i32, i32* %t595, align 4
  %t135 = add i32 3, %t134
  %t136 = load i32, i32* @a11, align 4
  %t137 = add i32 %t135, %t136
  store i32 %t137, i32* %t599, align 4
  %t139 = load i32, i32* %t596, align 4
  %t140 = add i32 4, %t139
  %t141 = load i32, i32* @a12, align 4
  %t142 = add i32 %t140, %t141
  store i32 %t142, i32* %t600, align 4
  %t144 = load i32, i32* %t597, align 4
  %t145 = add i32 1, %t144
  %t146 = load i32, i32* @a13, align 4
  %t147 = add i32 %t145, %t146
  store i32 %t147, i32* %t601, align 4
  %t149 = load i32, i32* %t598, align 4
  %t150 = add i32 2, %t149
  %t151 = load i32, i32* @a14, align 4
  %t152 = add i32 %t150, %t151
  store i32 %t152, i32* %t602, align 4
  %t154 = load i32, i32* %t599, align 4
  %t155 = add i32 3, %t154
  %t156 = load i32, i32* @a15, align 4
  %t157 = add i32 %t155, %t156
  store i32 %t157, i32* %t603, align 4
  %t159 = load i32, i32* %t600, align 4
  %t160 = add i32 4, %t159
  %t161 = load i32, i32* @a16, align 4
  %t162 = add i32 %t160, %t161
  store i32 %t162, i32* %t604, align 4
  %t164 = load i32, i32* %t601, align 4
  %t165 = add i32 1, %t164
  %t166 = load i32, i32* @a17, align 4
  %t167 = add i32 %t165, %t166
  store i32 %t167, i32* %t605, align 4
  %t169 = load i32, i32* %t602, align 4
  %t170 = add i32 2, %t169
  %t171 = load i32, i32* @a18, align 4
  %t172 = add i32 %t170, %t171
  store i32 %t172, i32* %t606, align 4
  %t174 = load i32, i32* %t603, align 4
  %t175 = add i32 3, %t174
  %t176 = load i32, i32* @a19, align 4
  %t177 = add i32 %t175, %t176
  store i32 %t177, i32* %t607, align 4
  %t179 = load i32, i32* %t604, align 4
  %t180 = add i32 4, %t179
  %t181 = load i32, i32* @a20, align 4
  %t182 = add i32 %t180, %t181
  store i32 %t182, i32* %t608, align 4
  %t184 = load i32, i32* %t605, align 4
  %t185 = add i32 1, %t184
  %t186 = load i32, i32* @a21, align 4
  %t187 = add i32 %t185, %t186
  store i32 %t187, i32* %t609, align 4
  %t189 = load i32, i32* %t606, align 4
  %t190 = add i32 2, %t189
  %t191 = load i32, i32* @a22, align 4
  %t192 = add i32 %t190, %t191
  store i32 %t192, i32* %t610, align 4
  %t194 = load i32, i32* %t607, align 4
  %t195 = add i32 3, %t194
  %t196 = load i32, i32* @a23, align 4
  %t197 = add i32 %t195, %t196
  store i32 %t197, i32* %t611, align 4
  %t199 = load i32, i32* %t608, align 4
  %t200 = add i32 4, %t199
  %t201 = load i32, i32* @a24, align 4
  %t202 = add i32 %t200, %t201
  store i32 %t202, i32* %t612, align 4
  %t204 = load i32, i32* %t609, align 4
  %t205 = add i32 1, %t204
  %t206 = load i32, i32* @a25, align 4
  %t207 = add i32 %t205, %t206
  store i32 %t207, i32* %t613, align 4
  %t209 = load i32, i32* %t610, align 4
  %t210 = add i32 2, %t209
  %t211 = load i32, i32* @a26, align 4
  %t212 = add i32 %t210, %t211
  store i32 %t212, i32* %t614, align 4
  %t214 = load i32, i32* %t611, align 4
  %t215 = add i32 3, %t214
  %t216 = load i32, i32* @a27, align 4
  %t217 = add i32 %t215, %t216
  store i32 %t217, i32* %t615, align 4
  %t219 = load i32, i32* %t612, align 4
  %t220 = add i32 4, %t219
  %t221 = load i32, i32* @a28, align 4
  %t222 = add i32 %t220, %t221
  store i32 %t222, i32* %t616, align 4
  %t224 = load i32, i32* %t613, align 4
  %t225 = add i32 1, %t224
  %t226 = load i32, i32* @a29, align 4
  %t227 = add i32 %t225, %t226
  store i32 %t227, i32* %t617, align 4
  %t229 = load i32, i32* %t614, align 4
  %t230 = add i32 2, %t229
  %t231 = load i32, i32* @a30, align 4
  %t232 = add i32 %t230, %t231
  store i32 %t232, i32* %t618, align 4
  %t234 = load i32, i32* %t615, align 4
  %t235 = add i32 3, %t234
  %t236 = load i32, i32* @a31, align 4
  %t237 = add i32 %t235, %t236
  store i32 %t237, i32* %t619, align 4
  %t239 = load i32, i32* %t616, align 4
  %t240 = add i32 4, %t239
  %t241 = load i32, i32* @a32, align 4
  %t242 = add i32 %t240, %t241
  store i32 %t242, i32* %t620, align 4
  %t244 = load i32, i32* %t580, align 4
  %t245 = load i32, i32* %t582, align 4
  %t246 = sub i32 %t244, %t245
  %t247 = add i32 %t246, 10
  store i32 %t247, i32* %t584, align 4
  %t249 = load i32, i32* %t613, align 4
  %t250 = add i32 1, %t249
  %t251 = load i32, i32* @a29, align 4
  %t252 = add i32 %t250, %t251
  store i32 %t252, i32* %t617, align 4
  %t254 = load i32, i32* %t614, align 4
  %t255 = add i32 2, %t254
  %t256 = load i32, i32* @a30, align 4
  %t257 = add i32 %t255, %t256
  store i32 %t257, i32* %t618, align 4
  %t259 = load i32, i32* %t615, align 4
  %t260 = add i32 3, %t259
  %t261 = load i32, i32* @a31, align 4
  %t262 = add i32 %t260, %t261
  store i32 %t262, i32* %t619, align 4
  %t264 = load i32, i32* %t616, align 4
  %t265 = add i32 4, %t264
  %t266 = load i32, i32* @a32, align 4
  %t267 = add i32 %t265, %t266
  store i32 %t267, i32* %t620, align 4
  %t269 = load i32, i32* %t609, align 4
  %t270 = add i32 1, %t269
  %t271 = load i32, i32* @a25, align 4
  %t272 = add i32 %t270, %t271
  store i32 %t272, i32* %t613, align 4
  %t274 = load i32, i32* %t610, align 4
  %t275 = add i32 2, %t274
  %t276 = load i32, i32* @a26, align 4
  %t277 = add i32 %t275, %t276
  store i32 %t277, i32* %t614, align 4
  %t279 = load i32, i32* %t611, align 4
  %t280 = add i32 3, %t279
  %t281 = load i32, i32* @a27, align 4
  %t282 = add i32 %t280, %t281
  store i32 %t282, i32* %t615, align 4
  %t284 = load i32, i32* %t612, align 4
  %t285 = add i32 4, %t284
  %t286 = load i32, i32* @a28, align 4
  %t287 = add i32 %t285, %t286
  store i32 %t287, i32* %t616, align 4
  %t289 = load i32, i32* %t605, align 4
  %t290 = add i32 1, %t289
  %t291 = load i32, i32* @a21, align 4
  %t292 = add i32 %t290, %t291
  store i32 %t292, i32* %t609, align 4
  %t294 = load i32, i32* %t606, align 4
  %t295 = add i32 2, %t294
  %t296 = load i32, i32* @a22, align 4
  %t297 = add i32 %t295, %t296
  store i32 %t297, i32* %t610, align 4
  %t299 = load i32, i32* %t607, align 4
  %t300 = add i32 3, %t299
  %t301 = load i32, i32* @a23, align 4
  %t302 = add i32 %t300, %t301
  store i32 %t302, i32* %t611, align 4
  %t304 = load i32, i32* %t608, align 4
  %t305 = add i32 4, %t304
  %t306 = load i32, i32* @a24, align 4
  %t307 = add i32 %t305, %t306
  store i32 %t307, i32* %t612, align 4
  %t309 = load i32, i32* %t601, align 4
  %t310 = add i32 1, %t309
  %t311 = load i32, i32* @a17, align 4
  %t312 = add i32 %t310, %t311
  store i32 %t312, i32* %t605, align 4
  %t314 = load i32, i32* %t602, align 4
  %t315 = add i32 2, %t314
  %t316 = load i32, i32* @a18, align 4
  %t317 = add i32 %t315, %t316
  store i32 %t317, i32* %t606, align 4
  %t319 = load i32, i32* %t603, align 4
  %t320 = add i32 3, %t319
  %t321 = load i32, i32* @a19, align 4
  %t322 = add i32 %t320, %t321
  store i32 %t322, i32* %t607, align 4
  %t324 = load i32, i32* %t604, align 4
  %t325 = add i32 4, %t324
  %t326 = load i32, i32* @a20, align 4
  %t327 = add i32 %t325, %t326
  store i32 %t327, i32* %t608, align 4
  %t329 = load i32, i32* %t597, align 4
  %t330 = add i32 1, %t329
  %t331 = load i32, i32* @a13, align 4
  %t332 = add i32 %t330, %t331
  store i32 %t332, i32* %t601, align 4
  %t334 = load i32, i32* %t598, align 4
  %t335 = add i32 2, %t334
  %t336 = load i32, i32* @a14, align 4
  %t337 = add i32 %t335, %t336
  store i32 %t337, i32* %t602, align 4
  %t339 = load i32, i32* %t599, align 4
  %t340 = add i32 3, %t339
  %t341 = load i32, i32* @a15, align 4
  %t342 = add i32 %t340, %t341
  store i32 %t342, i32* %t603, align 4
  %t344 = load i32, i32* %t600, align 4
  %t345 = add i32 4, %t344
  %t346 = load i32, i32* @a16, align 4
  %t347 = add i32 %t345, %t346
  store i32 %t347, i32* %t604, align 4
  %t349 = load i32, i32* %t593, align 4
  %t350 = add i32 1, %t349
  %t351 = load i32, i32* @a9, align 4
  %t352 = add i32 %t350, %t351
  store i32 %t352, i32* %t597, align 4
  %t354 = load i32, i32* %t594, align 4
  %t355 = add i32 2, %t354
  %t356 = load i32, i32* @a10, align 4
  %t357 = add i32 %t355, %t356
  store i32 %t357, i32* %t598, align 4
  %t359 = load i32, i32* %t595, align 4
  %t360 = add i32 3, %t359
  %t361 = load i32, i32* @a11, align 4
  %t362 = add i32 %t360, %t361
  store i32 %t362, i32* %t599, align 4
  %t364 = load i32, i32* %t596, align 4
  %t365 = add i32 4, %t364
  %t366 = load i32, i32* @a12, align 4
  %t367 = add i32 %t365, %t366
  store i32 %t367, i32* %t600, align 4
  %t369 = load i32, i32* %t589, align 4
  %t370 = add i32 1, %t369
  %t371 = load i32, i32* @a5, align 4
  %t372 = add i32 %t370, %t371
  store i32 %t372, i32* %t593, align 4
  %t374 = load i32, i32* %t590, align 4
  %t375 = add i32 2, %t374
  %t376 = load i32, i32* @a6, align 4
  %t377 = add i32 %t375, %t376
  store i32 %t377, i32* %t594, align 4
  %t379 = load i32, i32* %t591, align 4
  %t380 = add i32 3, %t379
  %t381 = load i32, i32* @a7, align 4
  %t382 = add i32 %t380, %t381
  store i32 %t382, i32* %t595, align 4
  %t384 = load i32, i32* %t592, align 4
  %t385 = add i32 4, %t384
  %t386 = load i32, i32* @a8, align 4
  %t387 = add i32 %t385, %t386
  store i32 %t387, i32* %t596, align 4
  %t389 = load i32, i32* %t585, align 4
  %t390 = add i32 1, %t389
  %t391 = load i32, i32* @a1, align 4
  %t392 = add i32 %t390, %t391
  store i32 %t392, i32* %t589, align 4
  %t394 = load i32, i32* %t586, align 4
  %t395 = add i32 2, %t394
  %t396 = load i32, i32* @a2, align 4
  %t397 = add i32 %t395, %t396
  store i32 %t397, i32* %t590, align 4
  %t399 = load i32, i32* %t587, align 4
  %t400 = add i32 3, %t399
  %t401 = load i32, i32* @a3, align 4
  %t402 = add i32 %t400, %t401
  store i32 %t402, i32* %t591, align 4
  %t404 = load i32, i32* %t588, align 4
  %t405 = add i32 4, %t404
  %t406 = load i32, i32* @a4, align 4
  %t407 = add i32 %t405, %t406
  store i32 %t407, i32* %t592, align 4
  %t409 = load i32, i32* %t585, align 4
  %t410 = add i32 1, %t409
  %t411 = load i32, i32* @a1, align 4
  %t412 = add i32 %t410, %t411
  store i32 %t412, i32* %t589, align 4
  %t414 = load i32, i32* %t586, align 4
  %t415 = add i32 2, %t414
  %t416 = load i32, i32* @a2, align 4
  %t417 = add i32 %t415, %t416
  store i32 %t417, i32* %t590, align 4
  %t419 = load i32, i32* %t587, align 4
  %t420 = add i32 3, %t419
  %t421 = load i32, i32* @a3, align 4
  %t422 = add i32 %t420, %t421
  store i32 %t422, i32* %t591, align 4
  %t424 = load i32, i32* %t588, align 4
  %t425 = add i32 4, %t424
  %t426 = load i32, i32* @a4, align 4
  %t427 = add i32 %t425, %t426
  store i32 %t427, i32* %t592, align 4
  %t428 = load i32, i32* %t584, align 4
  %t429 = load i32, i32* %t585, align 4
  %t430 = add i32 %t428, %t429
  %t431 = load i32, i32* %t586, align 4
  %t432 = add i32 %t430, %t431
  %t433 = load i32, i32* %t587, align 4
  %t434 = add i32 %t432, %t433
  %t435 = load i32, i32* %t588, align 4
  %t436 = add i32 %t434, %t435
  %t437 = load i32, i32* %t589, align 4
  %t438 = sub i32 %t436, %t437
  %t439 = load i32, i32* %t590, align 4
  %t440 = sub i32 %t438, %t439
  %t441 = load i32, i32* %t591, align 4
  %t442 = sub i32 %t440, %t441
  %t443 = load i32, i32* %t592, align 4
  %t444 = sub i32 %t442, %t443
  %t445 = load i32, i32* %t593, align 4
  %t446 = add i32 %t444, %t445
  %t447 = load i32, i32* %t594, align 4
  %t448 = add i32 %t446, %t447
  %t449 = load i32, i32* %t595, align 4
  %t450 = add i32 %t448, %t449
  %t451 = load i32, i32* %t596, align 4
  %t452 = add i32 %t450, %t451
  %t453 = load i32, i32* %t597, align 4
  %t454 = sub i32 %t452, %t453
  %t455 = load i32, i32* %t598, align 4
  %t456 = sub i32 %t454, %t455
  %t457 = load i32, i32* %t599, align 4
  %t458 = sub i32 %t456, %t457
  %t459 = load i32, i32* %t600, align 4
  %t460 = sub i32 %t458, %t459
  %t461 = load i32, i32* %t601, align 4
  %t462 = add i32 %t460, %t461
  %t463 = load i32, i32* %t602, align 4
  %t464 = add i32 %t462, %t463
  %t465 = load i32, i32* %t603, align 4
  %t466 = add i32 %t464, %t465
  %t467 = load i32, i32* %t604, align 4
  %t468 = add i32 %t466, %t467
  %t469 = load i32, i32* %t605, align 4
  %t470 = sub i32 %t468, %t469
  %t471 = load i32, i32* %t606, align 4
  %t472 = sub i32 %t470, %t471
  %t473 = load i32, i32* %t607, align 4
  %t474 = sub i32 %t472, %t473
  %t475 = load i32, i32* %t608, align 4
  %t476 = sub i32 %t474, %t475
  %t477 = load i32, i32* %t609, align 4
  %t478 = add i32 %t476, %t477
  %t479 = load i32, i32* %t610, align 4
  %t480 = add i32 %t478, %t479
  %t481 = load i32, i32* %t611, align 4
  %t482 = add i32 %t480, %t481
  %t483 = load i32, i32* %t612, align 4
  %t484 = add i32 %t482, %t483
  %t485 = load i32, i32* %t613, align 4
  %t486 = sub i32 %t484, %t485
  %t487 = load i32, i32* %t614, align 4
  %t488 = sub i32 %t486, %t487
  %t489 = load i32, i32* %t615, align 4
  %t490 = sub i32 %t488, %t489
  %t491 = load i32, i32* %t616, align 4
  %t492 = sub i32 %t490, %t491
  %t493 = load i32, i32* %t617, align 4
  %t494 = add i32 %t492, %t493
  %t495 = load i32, i32* %t618, align 4
  %t496 = add i32 %t494, %t495
  %t497 = load i32, i32* %t619, align 4
  %t498 = add i32 %t496, %t497
  %t499 = load i32, i32* %t620, align 4
  %t500 = add i32 %t498, %t499
  %t501 = load i32, i32* @a1, align 4
  %t502 = add i32 %t500, %t501
  %t503 = load i32, i32* @a2, align 4
  %t504 = sub i32 %t502, %t503
  %t505 = load i32, i32* @a3, align 4
  %t506 = add i32 %t504, %t505
  %t507 = load i32, i32* @a4, align 4
  %t508 = sub i32 %t506, %t507
  %t509 = load i32, i32* @a5, align 4
  %t510 = add i32 %t508, %t509
  %t511 = load i32, i32* @a6, align 4
  %t512 = sub i32 %t510, %t511
  %t513 = load i32, i32* @a7, align 4
  %t514 = add i32 %t512, %t513
  %t515 = load i32, i32* @a8, align 4
  %t516 = sub i32 %t514, %t515
  %t517 = load i32, i32* @a9, align 4
  %t518 = add i32 %t516, %t517
  %t519 = load i32, i32* @a10, align 4
  %t520 = sub i32 %t518, %t519
  %t521 = load i32, i32* @a11, align 4
  %t522 = add i32 %t520, %t521
  %t523 = load i32, i32* @a12, align 4
  %t524 = sub i32 %t522, %t523
  %t525 = load i32, i32* @a13, align 4
  %t526 = add i32 %t524, %t525
  %t527 = load i32, i32* @a14, align 4
  %t528 = sub i32 %t526, %t527
  %t529 = load i32, i32* @a15, align 4
  %t530 = add i32 %t528, %t529
  %t531 = load i32, i32* @a16, align 4
  %t532 = sub i32 %t530, %t531
  %t533 = load i32, i32* @a17, align 4
  %t534 = add i32 %t532, %t533
  %t535 = load i32, i32* @a18, align 4
  %t536 = sub i32 %t534, %t535
  %t537 = load i32, i32* @a19, align 4
  %t538 = add i32 %t536, %t537
  %t539 = load i32, i32* @a20, align 4
  %t540 = sub i32 %t538, %t539
  %t541 = load i32, i32* @a21, align 4
  %t542 = add i32 %t540, %t541
  %t543 = load i32, i32* @a22, align 4
  %t544 = sub i32 %t542, %t543
  %t545 = load i32, i32* @a23, align 4
  %t546 = add i32 %t544, %t545
  %t547 = load i32, i32* @a24, align 4
  %t548 = sub i32 %t546, %t547
  %t549 = load i32, i32* @a25, align 4
  %t550 = add i32 %t548, %t549
  %t551 = load i32, i32* @a26, align 4
  %t552 = sub i32 %t550, %t551
  %t553 = load i32, i32* @a27, align 4
  %t554 = add i32 %t552, %t553
  %t555 = load i32, i32* @a28, align 4
  %t556 = sub i32 %t554, %t555
  %t557 = load i32, i32* @a29, align 4
  %t558 = add i32 %t556, %t557
  %t559 = load i32, i32* @a30, align 4
  %t560 = sub i32 %t558, %t559
  %t561 = load i32, i32* @a31, align 4
  %t562 = add i32 %t560, %t561
  %t563 = load i32, i32* @a32, align 4
  %t564 = sub i32 %t562, %t563
  ret i32 %t564
}
define i32 @main() {
B621:
  %t623 = alloca i32, align 4
  %t622 = alloca i32, align 4
  %t568 = call i32 @getint()
  store i32 %t568, i32* %t622, align 4
  %t570 = load i32, i32* %t622, align 4
  %t571 = mul i32 2, 9
  %t572 = add i32 %t570, %t571
  store i32 %t572, i32* %t623, align 4
  %t574 = load i32, i32* %t622, align 4
  %t575 = load i32, i32* %t623, align 4
  %t576 = call i32 @func(i32 %t574, i32 %t575)
  store i32 %t576, i32* %t622, align 4
  %t577 = load i32, i32* %t622, align 4
  call void @putint(i32 %t577)
  %t578 = load i32, i32* %t622, align 4
  ret i32 %t578
}
