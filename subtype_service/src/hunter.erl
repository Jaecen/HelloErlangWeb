-module(hunter).
-export([get_cards_of_type_for_set/2]).

build_auth_header(Username, Password) ->
	Encoded = base64:encode_to_string(lists:append([Username,":",Password])),
	{"Authorization","Basic " ++ Encoded}.

build_content_type_header(Content_Type) ->
	{"Content-Type", Content_Type}.

get_cards_for_set(Set) ->
	Uri = string:concat("http://hunter.cardnex.us/sets/", http_uri:encode(Set)),
	Headers = [
		build_auth_header("auth", "0r1z3d"), 
		build_content_type_header("application/json")],
	inets:start(),
	{ok, {200, Body}} = httpc:request(get, {Uri, Headers}, [], [{full_result, false}]),
	
	{struct,[_|[{"cards", {array, Cards}}|_]]} = mochijson:decode(Body),
	Cards.

get_cards_of_type_for_set(Type, Set) ->
	Cards = get_cards_for_set(Set),
	CardsOfType = lists:filter(
		fun({struct, Details}) -> 
			lists:any(
				fun({"spoilerType",Value}) ->
					string:str(string:to_lower(Value), string:to_lower(Type)) =/= 0;
				({_,_}) ->
					false
				end,
				Details) 
		end, 
		Cards),
	lists:map(fun({struct, Card}) -> Card end, CardsOfType).
