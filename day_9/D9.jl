input = parse.(Int64, readlines("input_9.txt"))

function find_complement(target, numbers)
        for l in numbers
            complement = target - l
        if complement ∈ numbers
            return true
        end
    end
    return false
end


function find_wrong(input, preamble)
    for i in preamble+1:length(input)
        if find_complement(input[i], BitSet(input[i-preamble:i-1])) == false
            return input[i], i
        end
    end
end


function find_contiguos(input, wrong, index)
    for i in 1:length(input)-1
        println(i)
        i == index && continue
        current_sum = input[i]
        for j in i+1:length(input)
            j == index && break
            current_sum += input[j]
            current_sum == wrong && return i,j
        end
    end
    return (0, 0)
end

wrong, index = find_wrong(input, 25)
@show wrong, index
@show i, j = find_contiguos(input, wrong, index)
@show min(input[i:j]...) + max(input[i:j]...)