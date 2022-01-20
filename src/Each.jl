module Each
using Base.Meta

export each, @each

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

"""
## @each exp::Expr -> ::Bool
Determines whether each element of an iterable meets a certain condition. Returns a boolean, true if all of the elements meet a condition, false if otherwise. 
Used in conditional contexts.
### example
```
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
"""
macro each(exp::Expr)
    strexpr = string(exp)
    comp = split(strexpr, ' ')
    for value in eval(Meta.parse(string(comp[1])))
        to_parse = string(value, " ", comp[2], " ", comp[3])
        state = eval(Meta.parse(to_parse))
        if state != true
            return(false)
        end
    end
    return(true)
end

end # Module
