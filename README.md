# Each
A simple function to iterate over elements in a collection or a single element, even if that single element would normally be iterable by itself. The name is chosen for the mnemonic "for each `a` of Type `T` in `collection`" => `for a in each(T, collection)` Each can also be used in contexts where a boolean is anticipated as a return via the macro @each.

## Example
### each()
```julia
julia>  function printstrings_without_each(a)
            for s in a
                println(s)
            end
        end

julia>  function printstrings_with_each(a)
            for s in each(String,a)
                println(s)
            end
        end

julia>  printstrings_without_each(("apples","oranges"))
apples
oranges
julia>  printstrings_with_each(("apples","oranges"))
apples
oranges
julia>  printstrings_without_each("apples")
a
p
p
l
e
s
julia>  printstrings_with_each("apples")
apples
julia>  printstrings_without_each((1,2))
1
2
julia>  printstrings_with_each((1,2))
ERROR: Tuple{Int64,Int64} does not contain elements of type String
```
### @each
```julia
x = [5, 10, 15, 20]
if @each x % 5 == 0
   println("They are!")
end

They are!

if @each x > 25
    println("They are!")
end


if @each x < 25
    println("They are!")
end

They are!
```
