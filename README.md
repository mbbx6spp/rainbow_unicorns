# rainbow_unicorns: a riak\_core OTP application #

A sample riak\_core application for the Strange Loop 'Dynamo: not just for 
datastores' session on 09/19/2011 @ 1PM CDT:

https://thestrangeloop.com/sessions/dynamo-is-not-just-for-datastores

More to come, just a placeholder until then.

## Application Structure ##

This is a blank riak\_core application. To get started, you'll want to edit the
following files:

* `src/riak_rainbow_unicorns_vnode.erl`
  * an implementation of the riak\_core\_vnode behaviour
* `src/rainbow_unicorns.erl`
  * the public API for interacting with your vnode
