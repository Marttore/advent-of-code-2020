open("input_1.txt") do file
    global lines = readlines(file)
    lines = parse.(Int, lines)
end

numbers = Set(lines)

function find_complement(target)
    for l in lines
        complement = target - l
        if complement ∈ numbers
	        return l * complement 
        end 
    end
    return 0
end

println("A: ", find_complement(2020))
println("B: ", filter(x -> x!=0, map(l -> l * find_complement(2020 - l), lines)) |> first)


