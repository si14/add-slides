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

handle(Request) ->
    {ok, Prepared} = prepare(Request),
    {ok, Result} = process(Prepared),
    show(Result).

try
    {Method, TaskName, VarSpecs} =
      ?Z_CATCH({_, _, _} = lists:keyfind(Method, 1, TaskSpecs),
               bad_method),
    TaskVarsRoute =
      ?Z_CATCH([fetch_var(RouteVar, RouteVarType, Bindings)
                || {RouteVar, RouteVarType} <- RouteVars],
               bad_route),
    TaskVars = [?Z_CATCH(fetch_var(Var, VarType, QSVals),
                         {bad_var, Var})
                || {Var, VarType} <- VarSpecs],
    z_return(rnbwdash_task:create(...))
catch
    ?Z_OK(Task) -> form_reply(run_task(Task), Errors, Req@);
    ?Z_ERROR(Err) -> form_error(Err, Req@)
end

{Method, TaskName, VarSpecs} =
  ?Z_CATCH({_, _, _} = lists:keyfind(Method, 1, TaskSpecs)
           bad_method)

TaskVarsRoute =
  ?Z_CATCH([fetch_var(RouteVar, RouteVarType, Bindings)
            || {RouteVar, RouteVarType} <- RouteVars],
           bad_route)

TaskVars = [?Z_CATCH(fetch_var(Var, VarType, QSVals),
                     {bad_var, Var})
            || {Var, VarType} <- VarSpecs]

A = {1, 2, 3},
{B1, B2, B3} = A,
{C1, C2} = A,   %% ERROR
{D1, D2, 0} = A %% ERROR
