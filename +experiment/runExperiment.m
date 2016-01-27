function runExperiment()


PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Display experiment text

line1 = 'Hello World';
line2 = '\n This is the second line';
line3 = '\n\n This is the third line';

expText1 = 'On each trial, a frame will appear.\n\n';
expText2 = 'Press "f" for target present and "j" for no target present\n\n';
expText3 = 'Press Spacebar to see a sample stimulus.\n\n Press Spacebar again to begin.\n';

Screen('TextSize', window, 30);
DrawFormattedText(window, [expText1 expText2 expText3], 'center', 'center', black);

Screen('Flip', window);

KbStrokeWait;

% Presentation Time for the Gabor in seconds and frames
ifi = Screen('GetFlipInterval', window);

presTimeSecs = 0.2;
presTimeFrames = round(presTimeSecs / ifi);

% Interstimulus interval time in seconds and frames
isiTimeSecs = 1;
isiTimeFrames = round(isiTimeSecs / ifi);

% Numer of frames to wait before re-drawing
waitframes = 1;

% Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key
escapeKey = KbName('ESCAPE');
leftKey = KbName('f');
rightKey = KbName('j');
spaceKey = KbName('space');

Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
Screen('Flip', window);

KbStrokeWait;

sca;


%% 
% for iTrials = 1:nTrials
	
% 	background = addTargetFunction(background, @targetFunction, TargetParams);

% 	% display image

% 	% wait for response

% 	% give feedbacl
% 	% store response
% end