# Purescript

Aff: asynchronous effect monad: handle and sequence effectful asynchronous code, like AJAX requests, timeouts, and network and file IO. It can also perform synchronous effects by using liftEff. And it also provides a nice mechanism for handling errors.

Eff: synchronous effect monad: It is used to sequence effectful foreign JavaScript code - things like random number generation, reading and writing mutable values, writing to the console and throwing and catching exceptions.

## Proxy

Phantom type pour transmettre un type.

```purescript
myValue :: Int
myValye = 5

-- ici myValue (et 5) sont des valeurs et Int le type. Si on veut passer un type à une fonction, on ne peut pas faire:

myFunc Int 

-- ou comme en haskell
myFunc @Int

-- On utilise un proxy

data Proxy a = Proxy

intProxy :: Proxy Int
intProxy = Proxy

-- ici intProxy est une valeur qui permet de porter l'info que l'on souhaite
myFunc intProxy


-- exemple concret
getRange :: forall a. Bounded a => {lowest :: a , highest :: a }
getRange  = { lowest :  bottom
            , highest :  top
            }
-- compiler can decide which top, bottom we want..? 
-- solution 1:
getRange :: forall a.(Bounded a) => a -> {lowest :: a,highest :: a }
getRange _ = { lowest :  bottom
             ,  highest :  top
             }
             
-- solution 2
getRange :: forall a. (Bounded a) -> Proxy a => {lowest :: a , highest :: a }
getRange _ = { lowest :  bottom
             ,  highest :  top
             }
```


## Bounded

The Bounded type class represents totally ordered types that have an upper and lower boundary.

```purescript
class (Ord a) <= Bounded a where
    top :: a
    bottom :: a
```
