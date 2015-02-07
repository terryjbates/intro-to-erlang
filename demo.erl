-module(demo).
-export([double/1,times/2,launch/0,echo/0]).

% This is a comment.
% Rest of line after % is ignored.


double(X) -> 
    times(X, 2).

times(X, N) ->
    X * N.


launch() -> register(echo, spawn(demo,echo,[])).

echo() ->
    receive
        {Pid,Msg} ->
            Pid ! Msg,
            echo()
    end.