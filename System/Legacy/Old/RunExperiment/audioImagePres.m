function audioPres(soundDir, imageDir, duration, display)

%Screen('FrameRect', display, 'black', monPos(1,:), 3);
frame = imread(imageDir);
texture = Screen('MakeTexture', display, frame);
Screen('DrawTexture', display,texture);
Screen('Flip', display)
audio = audioread(soundDir);
sound(audio)
pause(duration/1000)
Screen('Flip', display)
clear sound