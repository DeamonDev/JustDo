# Just do!

Let us assume that we have functor `m`. We say it is a *monad* when it comes with two transformations:
1. `pure :: a -> m a`, for every type `a`
2. `>>= :: m a -> (a -> m b) -> m b`, for every two types `a` and `b`.
