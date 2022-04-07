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
            {"/",{currrency_controller,index},#{methods=>[get,options]}},
            {"/get",{currency_controller,get_currency},#{methods=>[get,options]}},
            {"/add",{currency_controller,add_currency},#{methods=>[post,options]}},
             {"/delete",{currency_controller,remove_currency},#{methods=>[post,options]}},
             {"/update",{currency_controller,update_currency},#{methods=>[post,options]}}
          ]}].
