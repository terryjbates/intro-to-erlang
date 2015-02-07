-module(recursion).
-export([double/1, member/2, even/1]).

double([H|T])->
    [2*H|double(T)];
double([])->
    [].
    
member(H, [H|_]) ->
    true;
member(H, [_|T]) ->
    member(H,T);
member(_, []) ->
    false.
    
even([H|T]) when H rem 2 == 0 ->
    [H|even(T)];
even([_|T]) ->
    even(T);
even([]) ->
    [].