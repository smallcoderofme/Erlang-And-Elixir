-module (pushbutton).
-behaviour (gen_statem).

-export ([start/0, push/0, get_count/0, stop/0]).
-export ([terminate/3, code_change/4, init/1, callback_mode/0]).
-export ([on/3, off/3]).

% The registered server name
name() ->
	pushbutton_statem.

%% API.  This example uses a registered name name()
%% and does not link to the caller.
start() ->
	gen_statem:start({local, name()}, ?MODULE, [], []).

push() ->
	gen_statem:call(name(), push).

get_count() ->
	gen_statem:call(name(), get_count).

stop() ->
	gen_statem:stop(name()).

%% Mandatory callback functions
terminate(_Reason, _State, _Data) ->
	void.

code_change(_Vsn, State, Data, _Extra) ->
	{ok, State, Data}.

%% Set the initial state + data.  Data is used only as a counter.
init([]) ->
	State = off, 
	Data = 0,
	{ok, State, Data}.

callback_mode() ->
	state_functions.

%%% state callback(s)

off({call, From}, push, Data) ->
    %% Go to 'on', increment count and reply
    %% that the resulting status is 'on'
    io:format('off -> From:~w Data ~w. ~n', [From, Data]),
	{next_state, on, Data + 1, [{reply, From, on}]};

off(EventType, EventContent, Data) ->
	io:format('off EventType :~w EventContent: ~w. ~n', [EventType, EventContent]),
	handle_event(EventType, EventContent, Data).

on({call, From}, push, Data) ->
	%% Go to 'off' and reply that the resulting status is 'off'
	io:format('on -> From:~w Data ~w. ~n', [From, Data]),
	{next_state, off, Data, [{reply, From, off}]};

on(EventType, EventContent, Data) ->
	io:format('on EventType :~w EventContent: ~w. ~n', [EventType, EventContent]),
	handle_event(EventType, EventContent, Data).

%% Handle events common to all states
handle_event({call, From}, get_count, Data) ->
    %% Reply with the current count
    io:format('handle_event call -> From:~w. ~n', [From]),
    {keep_state, Data, [{reply, From, Data}]};
handle_event(_, _, Data) ->
    %% Ignore all other events
    io:format('handle_event ignore -> Data:~w. ~n', [Data]),
    {keep_state, Data}.