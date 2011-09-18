%%%'   LICENSE

%%%.
%%%'   HEADER
%%% @copyright  
%%% @doc 
%%% @end
-module(rainbow_unicorns_sup).

-behaviour(supervisor).

%% Public API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%%%.
%%%'   PUBLIC API

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%%.
%%%'   CALLBACKS

%% @private
init(_Args) ->
    VMaster = { rainbow_unicorns_vnode_master,
                  {riak_core_vnode_master, start_link, [rainbow_unicorns_vnode]},
                  permanent, 5000, worker, [riak_core_vnode_master]},

    { ok,
        { {one_for_one, 5, 10},
          [VMaster]}}.

%%%.
%%% vim: set filetype=erlang tabstop=4 foldmarker=%%%',%%%. foldmethod=marker:
