type_error() ->
    A = 1,
    B = "b",
    A + B.

no_type_error() ->
    A = 1,
    B = "b",
    try throw(B)
    catch _:T -> A + T
    end.

prop_encode_decode() ->
    ?FORALL(Data, json(),
            Data == decode(encode(Data))).

assert_tuple(X) ->
    {_, _} = X.

read_input(Str) ->
    {ok, X} = parse_input(Str),
    ok = do_something(X).

handle(Data) ->
    {ok, FooResult} = foo(Data),
    {ok, BarResult} = bar(FooResult),
    baz(BarResult).
