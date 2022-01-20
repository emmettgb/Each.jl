# Each.jl
A collection of simple functions to iterate over elements in a collection or a single
element, even if that single element would normally be iterable by itself.
The name is chosen for the mnemonic "for each a of Type T in collection" => for
 a in each(T, collection).

## Using each in iterative contexts
Iterates over any type of collection, type or data-structure.
```@eval
function printstrings_without_each(a)
   for s in a
      println(s)
      end
end

function printstrings_with_each(a)
   for s in each(String,a)
      println(s)
   end
end

printstrings_without_each(("apples","oranges"))

printstrings_with_each(("apples","oranges"))

printstrings_without_each("apples")
```

```@docs
each
```
## Using each in conditional contexts
In order to use each in a conditional contexts, we instead call to the macro
@each. We can do so inside of any statement that expects a boolean in return.
```@eval
using Each
x = [5, 10, 15]
if @each x % 5 < 0
   println("Each value in $x is less than 0.")
end
```

```@docs
@each
```
