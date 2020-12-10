file = split.(readlines("input_8.txt"))

function part1(input)
    acc = 0
    runned_instructions = Set()
    index = 1
    while true
        if index > length(input)
            return ("success", acc)
        end

        instruction, value = input[index]
        index ∈ runned_instructions && return ("fail", acc)
        push!(runned_instructions, index)
        
        if instruction == "nop"
            index += 1
        elseif instruction == "acc"
            acc += parse(Int, value)
            index += 1
        else instruction == "jmp"
            index += parse(Int, value)
        end
    end
end
 

@show part1(file)

for i in 1:length(file)
    instruction, value = file[i]
    if instruction == "nop" || instruction == "jmp"
        file_copy = deepcopy(file)

        file_copy[i][1] = (instruction=="nop") ? "jmp" : "nop"

        tmp = part1(file_copy)
        tmp[1] == "success" && println(i, " ", tmp)
    end
end