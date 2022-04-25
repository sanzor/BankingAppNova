-module(bankingapi_router).
-behaviour(nova_router).

-export([
         routes/1
        ]).

%% The Environment-variable is defined in your sys.config in {nova, [{environment, Value}]}
routes(_Environment) ->
    [
      #{prefix=>"/currency",
        security=>false,
        routes=>[
            {"/",{currency_controller,index},#{methods=>[get,options]}},
            {"/get",{currency_controller,get},#{methods=>[get,options]}},
            {"/add",{currency_controller,add_currency},#{methods=>[post,options]}},
             {"/remove",{currency_controller,remove_currency},#{methods=>[delete,options]}},
             {"/update",{currency_controller,update_currency},#{methods=>[put,options]}}
          ]}].
