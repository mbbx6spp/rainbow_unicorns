%%%'   LICENSE

%%%.
%%%'   HEADER
%%% @copyright  
%%% @doc 
%%% @end
-module(rainbow_unicorns_vnode).
-behaviour(riak_core_vnode).
-include("rainbow_unicorns.hrl").

-export([start_vnode/1,
         init/1,
         terminate/2,
         handle_command/3,
         is_empty/1,
         delete/1,
         handle_coverage/4,
         handle_handoff_command/3,
         handoff_starting/2,
         handoff_cancelled/1,
         handoff_finished/2,
         handle_handoff_data/2,
         encode_handoff_item/2,
         handle_exit/3]).

-record(state, {partition}).
%%%.
%%%'   PUBLIC API

start_vnode(I) ->
    riak_core_vnode_master:get_vnode_pid(I, ?MODULE).

%%%.
%%%'   CALLBACKS

%% @private
init([Partition]) ->
    {ok, #state { partition=Partition }}.

%% @private
handle_command(ping, _Sender, State) ->
    {reply, {pong, State#state.partition}, State};
handle_command(Message, _Sender, State) ->
    ?PRINT({unhandled_command, Message}),
    {noreply, State}.

%% @private
handle_handoff_command(_Message, _Sender, State) ->
    {noreply, State}.

%% @private
handoff_starting(_TargetNode, State) ->
    {true, State}.

%% @private
handoff_cancelled(State) ->
    {ok, State}.

%% @private
handoff_finished(_TargetNode, State) ->
    {ok, State}.

%% @private
handle_handoff_data(_Data, State) ->
    {reply, ok, State}.

%% @private
encode_handoff_item(_ObjectName, _ObjectValue) ->
    <<>>.

%% @private
is_empty(State) ->
    {true, State}.

%% @private
delete(State) ->
    {ok, State}.

%% @private
handle_coverage(_Req, _KeySpaces, _Sender, State) ->
    {stop, not_implemented, State}.

%% @private
handle_exit(_Pid, _Reason, State) ->
    {noreply, State}.

%% @private
terminate(_Reason, _State) ->
    ok.
%%%.
%%% vim: set filetype=erlang tabstop=4 foldmarker=%%%',%%%. foldmethod=marker:
