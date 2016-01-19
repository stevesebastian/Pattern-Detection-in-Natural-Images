    % This script calls Psychtoolbox commands available only in OpenGL-based
    % versions of the Psychtoolbox. (So far, the OS X Psychtoolbox is the
    % only OpenGL-based Psychtoolbox.)  The Psychtoolbox command AssertOpenGL will issue
    % an error message if someone tries to execute this script on a computer without
    % an OpenGL Psychtoolbox
    AssertOpenGL;

    % Get the list of screens and choose the one with the highest screen number.
    % Screen 0 is, by definition, the display with the menu bar. Often when
    % two monitors are connected the one without the menu bar is used as
    % the stimulus display.  Chosing the display with the highest display number is
    % a best guess about where you want the stimulus displayed.
    screenNumber=max(Screen('Screens'));

    % Open a double buffered fullscreen window.
    [w, wRect]=Screen('OpenWindow',screenNumber, 127,[],32,2);
    
    Screen('Flip', w);
    
    experimentStruct.window = w;
    experimentStruct.fixcrossPosX = 100;
    experimentStruct.fixcrossPosY = 540;
    
    experimentStruct.stimulusPosX = 600;
    experimentStruct.stimulusPosY = 540;
    
    experimentStruct.stimulusDuration = 3;
    experimentStruct.ppd = 120;
    experimentStruct.correctResponse(1) = 0;
    experimentStruct.correctResponse(2) = 0;
    experimentStruct.MAX_TRIALS = 2;
    experimentStruct.target = zeros(21,21);
    experimentStruct.backgroundcolour = .5;
    

    [X, Y] = meshgrid(-120:120, -120:120);
    win = sqrt(X.^2 + Y.^2) < 100;
    bg = randn(241)*.5*127 + 127;
    bg(~win) = 127;    
    stimulus = bg;
    
    stimulusArray = zeros([size(stimulus),1]);
    stimulusArray(:,:,1) = stimulus;
    stimulusArray(:,:,2) = stimulus;
        