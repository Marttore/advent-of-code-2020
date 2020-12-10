using Memoize

adapters = parse.(Int, readlines("input_10.txt"))
push!(adapters, 0)

adapters = sort(adapters)
diffs = diff(adapters)

@show (count(==(1), diffs)) * (count(==(3), diffs) + 1)

@memoize function calc_allowed_counts(ad)
    allowed_adapters = filter(x -> ad - 3 <= x < ad, adapters)
    length(allowed_adapters) == 0 && return 1
    return sum([calc_allowed_counts(x) for x in allowed_adapters])
end

@show calc_allowed_counts(maximum(adapters))