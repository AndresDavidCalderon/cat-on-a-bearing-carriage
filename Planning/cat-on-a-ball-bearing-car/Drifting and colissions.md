The issue with a characterBody, is that rotation isnt handled by the engine. Raycasts may fix it, however its pretty hard to simulate sliding.

The main issue is that movement is totally forced when drifting, instead of using move and slide(), this is done becase it's easier to calculate a new position that it is to calculate the _direction_ at any given moment. It may not even make sense, the position stays relatively the same, the most wild movement is steering.

The first step is accepting that moving the pinpoint means to indirectly move the position, so it should be done with move and slide, the first goal is for the center of the character to never be submerged. disabling the drift slide achieves that, so indeed that is gonna be our attack vector. New note: That only fixed it because drifting was not implemented actually. It just rotated.

The position= thing must be gone. 

Physics problems arise quite rarely. Only 1 issue: The game is terribly boring. We need more stimuli the player can get, buying powerups might be one, making boosters more noticeable, adding more objectives. Because right now, the game feels like a boolean between having lost and not having lost I think a time constraint would go pretty well, aditionally to not repeating delivery positons immediately. We could also add a win condition.