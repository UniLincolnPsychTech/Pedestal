function [fig, ax] = pedwindow(sDim, col)


if ~exist('sDim', 'var') % If user did not specify screen dim...
    sDim = get(groot, 'ScreenSize'); % Get screen dimensions
end
if ~exist('col', 'var') % If user did not specify colour...
    col = [0.5 0.5 0.5]; % Default to 0.5 grey
end

fig = figure(... % Create full screen figure
    'InnerPosition', sDim, ... % Fullscreen figure
    'KeyPressFcn', @keyFcn, ... % Create keypress listener
    'WindowButtonDownFcn', @clickFcn, ... % Create click listener 
    'SizeChangedFcn', @sizeFcn ... % Function to match axis limits of fullscreen axes to figure size
    );

ax = axes(fig, ... % Create axis within figure
    'Position', [0, 0, 1, 1], ... % Occupy entire figure
    'XLim', [0, sDim(3)], ... % X limits are width of screen in pixels
    'YLim', [0, sDim(4)], ... % Y limits are height of screen in pixels
    'Color', col, ... % Colour defined by user
    'TickLength', [0 0], ... % Remove ticks
    'Box', 'off' ... % Remove box
    );



    function keyFcn(app, event)
        try
            app.UserData = [app.UserData, {event.Key}]; % Append last key to user data
        catch
            app.UderData = event.Key; % Set the UserData of the figure to equal the key which was just pressed
        end
    end
    function clickFcn(app, ~)
        try
            app.UserData = [app.UserData, {get(app.Children(1), 'CurrentPoint')}]; % Append mouse position to user data
        catch
            app.UserData = get(app.Children(1), 'CurrentPoint'); % Set the UserData of the figure to equal the coords of mouse
        end
    end
    function sizeFcn(app, ~)
        axArray = findobj(app.Children, 'Type', 'axes', 'Position', [0 0 1 1]);
        for a = axArray'
            set(a, ...
                'XLim', [0, app.Position(3)], ...
                'YLim', [0, app.Position(4)] ...
                );
        end
    end
end