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

handle(Req, #state{...}=State) ->
    {Bindings, Req@} = cowboy_http_req:bindings(Req),
    {QSVals, Req@} = cowboy_http_req:qs_vals(Req@),
    Req@ = try
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
           end,
    {ok, Req@, State}.

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

-define(Z_CATCH(EXPR, ERROR),
        try
            EXPR
        catch
            _:_ -> throw({z_throw, {error, ERROR}})
        end).

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
