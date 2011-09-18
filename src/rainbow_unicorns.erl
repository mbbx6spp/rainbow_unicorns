%%%'   LICENSE

%%%.
%%%'   HEADER
%%% @copyright  
%%% @doc 
%%% @end

-module(rainbow_unicorns).
-include("rainbow_unicorns.hrl").
-include_lib("riak_core/include/riak_core_vnode.hrl").

-export([
         ping/0
        ]).

%%%.
%%%'   PUBLIC API

% @doc Pings a random vnode to make sure communication is functional
ping() ->
    DocIdx = riak_core_util:chash_key({<<"ping">>, term_to_binary(now())}),
    PrefList = riak_core_apl:get_primary_apl(DocIdx, 1, rainbow_unicorns),
    [{IndexNode, _Type}] = PrefList,
    riak_core_vnode_master:sync_spawn_command(IndexNode, ping, rainbow_unicorns_vnode_master).
%%%.
%%% vim: set filetype=erlang tabstop=4 foldmarker=%%%',%%%. foldmethod=marker:
