# Purescript

Aff: asynchronous effect monad: handle and sequence effectful asynchronous code, like AJAX requests, timeouts, and network and file IO. It can also perform synchronous effects by using liftEff. And it also provides a nice mechanism for handling errors.

Eff: synchronous effect monad: It is used to sequence effectful foreign JavaScript code - things like random number generation, reading and writing mutable values, writing to the console and throwing and catching exceptions.