-module (code_lock).
-behaviour (gen_statem).

-define (NAME, code_lock).

-export ([start_link/1, stop/0]).
-export ([button/1]).
-export ([init/1, callback_mode/0, terminate/3]).
-export ([locked/3, open/3]).

start_link(Code) ->
	gen_statem:start_link({local, ?NAME}, ?MODULE, Code, []).


stop() ->
	gen_statem:stop(?NAME).

button(Button) ->
	io:format("push Button.~n"),
	gen_statem:cast(?NAME, {button, Button}).


init(Code) ->
	do_lock(),
	Data = #{code => Code, length => length(Code), buttons => []},
	{ok, locked, Data}.

callback_mode() ->
	state_functions.

% locked(cast, stop) ->
% 	io:format("locked stop."),
% 	ok.

locked(cast, {button, Button},
	#{code := Code, length := Length, buttons := Buttons} = Data) ->
	io:format("push Button locked.~n"),
	NewButtons = 
	if
		length(Buttons) < Length ->
			Buttons;
		true ->
			tl(Button) %% 返回列表的最后一个元素
	end 
	++ [Buttons],
	if
		NewButtons =:= Code -> %% Correct
			do_unlock(),
			{next_state, open, Data#{buttons := []}, [{start_timeout, 10000, lock}]}; % Time in milliseconds
		true -> % Incomplete | Incorrect
			{next_state, locked, Data#{buttons := NewButtons}}
	end.

open(start_timeout, lock, Data) ->
	do_lock(),
	{next_state, locked, Data};

open(cast, {buttons, _}, Data) ->
	{next_state, open, Data}.


do_lock() ->
	io:format("Lock ~n").

do_unlock() ->
	io:format("Unlock ~n").

terminate(_Reason, State, _Data) ->
	State =/= locked andalso do_lock(),
	ok.