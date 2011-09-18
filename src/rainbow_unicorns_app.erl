%%%'   LICENSE

%%%.
%%%'   HEADER
%%% @copyright  
%%% @doc 
%%% @end

-module(rainbow_unicorns_app).

-behaviour(application).

-export([start/2, stop/1]).
%%%.
%%%'   CALLBACKS

start(_StartType, _StartArgs) ->
    case rainbow_unicorns_sup:start_link() of
        {ok, Pid} ->
            ok = riak_core:register_vnode_module(rainbow_unicorns_vnode),
            ok = riak_core_ring_events:add_guarded_handler(rainbow_unicorns_ring_event_handler, []),
            ok = riak_core_node_watcher_events:add_guarded_handler(rainbow_unicorns_node_event_handler, []),
            ok = riak_core_node_watcher:service_up(rainbow_unicorns, self()),
            {ok, Pid};
        {error, Reason} ->
            {error, Reason}
    end.

stop(_State) ->
    ok.
%%%.
%%% vim: set filetype=erlang tabstop=4 foldmarker=%%%',%%%. foldmethod=marker:
