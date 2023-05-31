
# Purescript - prelude 6.0.0

## Data.Eq

```purescript
class Eq a where
    eq   :: a -> a -> Boolean -- (==)
```

Laws:
- Reflexivity: `x == x = true`
- Symmetry: `x == y = y == x`
- Transitivity: `if x == y and y == z then x == z`

```purescript
notEq :: forall a. Eq a => a -> a -> Boolean -- (/=)
```


## Data.Ord

```purescript
class (Eq a) <= Ord a where
    compare :: a -> a -> Ordering
```

Laws:
- Reflexivity: `a <= a`
- Antisymmetry: `if a <= b and b <= a then a = b`
- Transitivity: `if a <= b and b <= c then a <= c`

```purescript
lessThan :: forall a. Ord a => a -> a -> Boolean -- (<)
lessThanOrEq :: forall a. Ord a => a -> a -> Boolean -- (<=)
greaterThan :: forall a. Ord a => a -> a -> Boolean -- (>)
greaterThanOrEq :: forall a. Ord a => a -> a -> Boolean -- (>=)
comparing :: forall a b. Ord b => (a -> b) -> (a -> a -> Ordering)
min :: forall a. Ord a => a -> a -> a
max :: forall a. Ord a => a -> a -> a
clamp :: forall a. Ord a => a -> a -> a -> a
between :: forall a. Ord a => a -> a -> a -> Boolean
abs :: forall a. Ord a => Ring a => a -> a
signum :: forall a. Ord a => Ring a => a -> a
```


## Data.Bounded

```purescript
class (Ord a) <= Bounded a where
    top :: a
    bottom :: a
```


## Data.Ordering

```purescript
data Ordering = LT | GT | EQ

invert :: Ordering -> Ordering
```

## Data.Functor

```purescript
class Functor f where
    map :: forall a b. (a -> b) -> f a -> f b -- (<$>)
```

Laws:
- Identity: `map identity = identity`
- Composition: `map (f <<< g) = map f <<< map g`

```purescript
mapFlipped :: forall f a b. Functor f => f a -> (a -> b) -> f b -- (<#>)
void :: forall f a. Functor f => f a -> f Unit
voidRight :: forall f a b. Functor f => a -> f b -> f a -- (<$)
voidLeft :: forall f a b. Functor f => f a -> b -> f b -- ($>)
flap :: forall f a b. Functor f => f (a -> b) -> a -> f b -- (<@>)
```


## Control.Applicative

```purescript
class (Functor f) <= Apply f where
    apply :: forall a b. f (a -> b) -> f a -> f b   -- (<*>)
```

```purescript
liftA1 :: forall f a b. Applicative f => (a -> b) -> f a -> f b
unless :: forall m. Applicative m => Boolean -> m Unit -> m Unit
when :: forall m. Applicative m => Boolean -> m Unit -> m Unit
```


## Control.Apply

```purescript
class (Apply f) <= Applicative f where
    pure :: forall a. a -> f a
```

```purescript
applyFirst :: forall a b f. Apply f => f a -> f b -> f a -- (<*)
applySecond :: forall a b f. Apply f => f a -> f b -> f b -- (*>)
lift2 :: forall a b c f. Apply f => (a -> b -> c) -> f a -> f b -> f c
lift3 :: forall a b c d f. Apply f => (a -> b -> c -> d) -> f a -> f b -> f c -> f d
lift4 :: forall a b c d e f. Apply f => (a -> b -> c -> d -> e) -> f a -> f b -> f c -> f d -> f e
lift5 :: forall a b c d e f g. Apply f => (a -> b -> c -> d -> e -> g) -> f a -> f b -> f c -> f d -> f e -> f g
```


## Control.Bind

```purescript
class (Apply m) <= Bind m where
    bind :: forall a b. m a -> (a -> m b) -> m b -- (>>=)
```

```purescript
bindFlipped :: forall m a b. Bind m => (a -> m b) -> m a -> m b -- (=<<)
join :: forall a m. Bind m => m (m a) -> m a
composeKleisli :: forall a b c m. Bind m => (a -> m b) -> (b -> m c) -> a -> m c -- (>=>)
composeKleisliFlipped :: forall a b c m. Bind m => (b -> m c) -> (a -> m b) -> a -> m c -- (<=<)
ifM :: forall a m. Bind m => m Boolean -> m a -> m a -> m a
```

```purescript
class Discard a where
    discard :: forall f b. Bind f => f a -> (a -> f b) -> f b
```


## Control.Monad

```purescript
class (Applicative m, Bind m) <= Monad m

```purescript
liftM1 :: forall m a b. Monad m => (a -> b) -> m a -> m b
whenM :: forall m. Monad m => m Boolean -> m Unit -> m Unit
unlessM :: forall m. Monad m => m Boolean -> m Unit -> m Unit
ap :: forall m a b. Monad m => m (a -> b) -> m a -> m b
```


## Data.Semigroup

```purescript
class Semigroup a where
    append :: a -> a -> a -- (<>)
```

law:
- Associativity: `(x <> y) <> z = x <> (y <> z)`


## Data.Monoid

```purescript
class (Semigroup m) <= Monoid m where
    mempty :: m
```

```purescript
power :: forall m. Monoid m => m -> Int -> m
guard :: forall m. Monoid m => Boolean -> m -> m
```


## Control.Semigroupoid

```purescript
class Semigroupoid a where
  compose :: forall b c d. a c d -> a b c -> a b d -- (<<<)
```

```purescript
composeFlipped :: forall a b c d. Semigroupoid a => a b c -> a c d -> a b d -- (>>>)
```


## Control.Category

```purescript
class (Semigroupoid a) <= Category a where
  identity :: forall t. a t t
```


## Data.Boolean

```purescript
otherwise :: Boolean
otherwise = true
```


## Data.HeytingAlgebra

```purescript
class HeytingAlgebra a where
      ff :: a
      tt :: a
      implies :: a -> a -> a
      conj :: a -> a -> a  -- (&&)
      disj :: a -> a -> a  -- (||)
      not :: a -> a
```

laws:
- Associativity:
    `a || (b || c) = (a || b) || c`
    `a && (b && c) = (a && b) && c`
- Commutativity:
    `a || b = b || a`
    `a && b = b && a`
- Absorption:
    `a || (a && b) = a`
    `a && (a || b) = a`
- Idempotent:
    `a || a = a`
    `a && a = a`
- Identity:
    `a || ff = a`
    `a && tt = a`
- Implication:
    ``a `implies` a = tt``
    ``a && (a `implies` b) = a && b``
    ``b && (a `implies` b) = b``
    ``a `implies` (b && c) = (a `implies` b) && (a `implies` c)``
- Complemented:
    ``not a = a `implies` ff``



## Data.BooleanAlgebra
```purescript
class (HeytingAlgebra a) <= BooleanAlgebra a
```


## Data.Semiring

```purescript
class Semiring a where
    add :: a -> a -> a -- (+)
    zero :: a
    mul :: a -> a -> a -- (*)
    one :: a
```

Laws:
- Commutative monoid under addition:
  - Associativity: `(a + b) + c = a + (b + c)`
  - Identity: `zero + a = a + zero = a`
  - Commutative: `a + b = b + a`
- Monoid under multiplication:
  - Associativity: `(a * b) * c = a * (b * c)`
  - Identity: `one * a = a * one = a`
- Multiplication distributes over addition:
  - Left distributivity:` a * (b + c) = (a * b) + (a * c)`
  -  Right distributivity: `(a + b) * c = (a * c) + (b * c)`
- Annihilation: `zero * a = a * zero = zero`



## Data.Ring

```purescript
class (Semiring a) <= Ring a where
    sub :: a -> a -> a  -- (-)
```

Laws:
- Additive inverse: `a - a = zero`
- Compatibility of sub and negate: `a - b = a + (zero - b)`

```purescript
negate :: forall a. Ring a => a -> a
```


## Data.CommutativeRing

```purescript
class (Ring a) <= CommutativeRing a
```

Law:
- Commutative multiplication: `a * b = b * a`


## Data.DivisionRing
```purescript
class (Ring a) <= DivisionRing a where
  recip :: a -> a
```

Laws:
- Non-zero ring: `one /= zero`
- Non-zero multiplicative inverse: `recip a * a = a * recip a = one for all non-zero a`

```purescript
leftDiv :: forall a. DivisionRing a => a -> a -> a
rightDiv :: forall a. DivisionRing a => a -> a -> a
```


## Data.EuclideanRing

```purescript
class (CommutativeRing a) <= EuclideanRing a where
    degree :: a -> Int
    div :: a -> a -> a  -- /
    mod :: a -> a -> a
```

laws:
- Integral domain: one /= zero, and if a and b are both nonzero then so is their product a * b
- Euclidean function degree:
  - Nonnegativity: For all nonzero a, degree a >= 0
  -  Quotient/remainder: For all a and b, where b is nonzero, let q = a / b and r = a `mod` b; then a = q*b + r, and also either r = zero or degree r < degree b
- Submultiplicative euclidean function:
  - For all nonzero a and b, degree a <= degree (a * b)

```purescript
gcd :: forall a. Eq a => EuclideanRing a => a -> a -> a
lcm :: forall a. Eq a => EuclideanRing a => a -> a -> a
```


## Data.Field

```purescript
class (EuclideanRing a, DivisionRing a) <= Field a
```


## Data.Generic.Rep

```purescript
class Generic a rep | a -> rep where
    to :: rep -> a
    from :: a -> rep
```

```purescript
repOf :: forall a rep. Generic a rep => Proxy a -> Proxy rep
```

```purescript
newtype NoConstructors

data NoArguments = NoArguments

data Sum a b =     Inl a | Inr b

data Product a b = Product a b

newtype Constructor (name :: Symbol) a = Constructor a

newtype Argument a = Argument a
```


## Data.NaturalTransformation

```purescript
type NaturalTransformation f g = forall a. f a -> g a -- (~>)
```


## Data.Show

```purescript
class Show a where
      show :: a -> String
```


## Data.Symbol

```purescript
class IsSymbol (sym :: Symbol) where
        reflectSymbol :: Proxy sym -> String
```

```purescript
reifySymbol :: forall r. String -> (forall sym. IsSymbol sym => Proxy sym -> r) -> r
```


## Data.Unit

```purescript
data Unit

unit :: Unit
```


## Data.Void

```purescript
newtype Void

absurd :: forall a. Void -> a
```


## Type.Proxy

```purescript
data Proxy a = Proxy
```