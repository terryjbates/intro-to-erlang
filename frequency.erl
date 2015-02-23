-module(frequency).
-export([start/0, allocate/2, deallocate/2, reply/2]).
-export([init/0]).


start() ->
    register(frequency,
                spawn(?MODULE, init, [])).

init() ->
    Frequencies = {get_frequencies(), []},
    loop(Frequencies).

% Hard Coded

get_frequencies() -> [10,11,12,13,14,15].

loop(Frequencies) ->
    receive
        {request, Pid, allocate} ->
            {NewFrequencies, Reply} = allocate(Frequencies, Pid),
            reply(Pid, Reply),
            loop(NewFrequencies);
        {request, Pid, {deallocate, Freq}} ->
            NewFrequencies = deallocate(Frequencies, Freq),
            reply(Pid, ok),
            loop(NewFrequencies);
        {request, Pid, stop} ->
            reply(Pid, ok)
    end.


allocate({[], Allocated}, _Pid) ->
    {{[], Allocated},
        {error, no_frequency}};

allocate( { [Freq|Free], Allocated }, Pid      ) ->
        {{Free, [{Freq,Pid}|Allocated]},
        {ok, Freq }}.

deallocate({Free, Allocated}, Freq) ->
    NewAllocated
        =lists:keydelete(Freq, 1, Allocated),
    {[Freq|Free], NewAllocated}.


allocate() ->
    frequency ! {request, self()}


reply(Pid, Reply) ->
    Pid ! {reply, Reply}.
