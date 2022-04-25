-module(currency_controller).
-export([index/1,get/1,add_currency/1,remove_currency/1,update_currency/1]).


index(_Req)->
    Currencies=ets:tab2list(currency),
    Data=[#{<<"id">>=>Id,<<"name">>=>Name}||{Id,Name}<-Currencies],
    {json,200,#{},Data}.

get(#{parsed_qs:=#{<<"name">>:=Name}})->
    case ets:lookup(currency,Name) of
        []->{status,404};
        [{Name,Value}] ->{json,200,#{},#{<<"name">>=>Name,<<"value">>=>Value}}
    end.

add_currency(#{json:=#{<<"name">>:=Name,<<"value">>:=Value}}=_Req)->

    try ets:insert(currency,{Name,Value}) of
        true -> {status,200}
    catch
        ErrorType:Error->{json,500,#{},#{<<"err_type">>=>atom_to_binary(ErrorType, utf8),<<"err">>=>atom_to_binary(Error, utf8)}}
    end.
   
update_currency(#{json:=#{<<"name">>:=Name,<<"value">>:=Value}}=_Req)->
    ets:delete(currency,Name),
    ets:insert(currency, {Name,Value}),
    {status,200}.
remove_currency(#{parsed_qs:=#{<<"name">>:=Id}}=_Req)->
    true=ets:delete(currency, Id),
    {status,200}.