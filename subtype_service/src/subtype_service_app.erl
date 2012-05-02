%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the subtype_service application.

-module(subtype_service_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for subtype_service.
start(_Type, _StartArgs) ->
    subtype_service_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for subtype_service.
stop(_State) ->
    ok.
