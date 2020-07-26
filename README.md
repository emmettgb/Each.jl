# Each
A simple function to iterate over elements in a collection or a single element, even if that single element would normally be iterable by itself. 

## Example
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
