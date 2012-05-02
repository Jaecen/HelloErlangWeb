-module(hunter).

-export([get_cards_for_set/1]).

get_cards_for_set(set_name) ->
	inets:start(),
	{ok, {{Version, 200, ReasonPhrase}, Headers, Body}} = httpc:request("http://www.google.com").
