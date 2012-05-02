%% @author author <author@example.com>
%% @copyright YYYY author.
%% @doc Example webmachine_resource.

-module(subtype_service_resource).
-export([init/1, content_types_provided/2, to_json/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

content_types_provided(ReqData, Context) ->
	{[{"application/json",to_json}, {"text/html",to_json}], ReqData, Context}.

to_json(ReqData, Context) ->
	{"blorb", ReqData, Context}.
