-record (todo, {status = reminder, who = shuai, text}).

% 3> rr("records.hrl").
% [todo]
% 4> #todo
% {}.
% #todo{status = reminder,who = shuai,text = undefined}
% 5> #todo{}.
% #todo{status = reminder,who = shuai,text = undefined}
% 6> X1 = #todo{status=urgent, text="Study Erlang."}.
% #todo{status = urgent,who = shuai,text = "Study Erlang."}
% 7> X2 = X1#todo{status=done}.
% #todo{status = done,who = shuai,text = "Study Erlang."}
% 8> #todo{who=W, text=Txt} = X2.
% #todo{status = done,who = shuai,text = "Study Erlang."}
% 9> W.
% shuai
% 10> Txt.
% "Study Erlang."
% 11> X1#todo.text.
% "Study Erlang."
% 12> rf(todo).
% ok
% 13> X2.
% {todo,done,shuai,"Study Erlang."}