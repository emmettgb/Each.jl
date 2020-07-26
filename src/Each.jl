module Each


export each

"""
    each(Type, collection)

Return the collection unchanged.

    each(Type, element::Type)

Return the element wrapped in a tuple.

Useful for functions where the arguments can be a list or a single element which should be
iterated over, but the elements could be iterable themselves. 
Extra care should be taken when the list and the elements are similar types: When working
with tuples of tuples of integers, use `each(Tuple{Vararg{Integer}},collection)` rather than
`each(Tuple,collection)` as the latter will always use the entire list as one element.

# Examples
```julia-repl
julia>  function f(a::Union{String,AbstractArray{String}})
            # This will fail for "scalar" Strings
            for s in a
                println(s)
            end
        end
julia>  f(["apples","oranges"])
apples
oranges
julia>  f("apples")
a
p
p
l
e
s
julia>  function f(a::Union{String,AbstractArray{String}})
            # This handles strings correctly
            for s in each(String,a)
                println(s)
            end
        end
julia>  f(["apples","oranges"])
apples
oranges
julia>  f("apples")
apples

julia>  function f(a::Tuple)
            for t in each(Tuple,a)
                println(t)
            end
        end
julia>  f( (1, 2) ) # argument is a tuple, wrap in tuple
(1, 2)
julia>  f( ( (1, 2), (3, 4) ) ) # same thing
((1, 2), (3, 4))
julia>  function f(a::Tuple)
            for t in each(Tuple{Vararg{Number}},a)
                println(t)
            end
        end
julia>  f( (1, 2) )
(1, 2)
julia>  f( ( (1,2), (3, 4) ) )
(1, 2)
(3, 4)
```
"""
function each(::Type{T}, collection) where T
    eltype(collection) <:T && return collection
    error(typeof(collection)," does not contain elements of type ",T)
end

each(::Type{T}, element::T) where T = (element,)

end # Module
