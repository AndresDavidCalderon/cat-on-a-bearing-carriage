The issue with a characterBody, is that rotation isnt handled by the engine. Raycasts may fix it, however its pretty hard to simulate sliding.

The main issue is that movement is totally forced when drifting, instead of using move and slide(), this is done becase it's easier to calculate a new position that it is to calculate the _direction_ at any given moment. It may not even make sense, the position stays relatively the same, the most wild movement is steering.

The first step is accepting that moving the pinpoint means to indirectly move the position, so it should be done with move and slide