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
	InnCards = hunter:get_cards_of_type_for_set(wrq:path_info(subtype, ReqData), "Innistrad"),
	DkaCards = hunter:get_cards_of_type_for_set(wrq:path_info(subtype, ReqData), "Dark Ascension"),
	AvrCards = hunter:get_cards_of_type_for_set(wrq:path_info(subtype, ReqData), "Avacyn Restored"),
	
	CardMapper = fun(Card) ->
			{_, Name} = lists:keyfind("checklistName", 1, Card),
			{_, Color} = lists:keyfind("checklistColor", 1, Card),
			{struct, [{"name", Name}, {"color", Color}]}
			end,
	
	MappedCards = {array, 
		lists:map(CardMapper, InnCards) ++
		lists:map(CardMapper, DkaCards) ++
		lists:map(CardMapper, AvrCards)	
	},

	{mochijson:encode(MappedCards), ReqData, Context}.
