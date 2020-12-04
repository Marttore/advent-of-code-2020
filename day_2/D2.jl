using DelimitedFiles

a = readdlm("input_2.txt")

function is_valid_a(password, letter, lower, upper)
    return lower <= count(x -> x == letter, password) <= upper
end

function is_valid_b(password, letter, lower, upper)
    return (password[lower] == letter || password[upper] == letter) && !(password[lower] == letter && password[upper] == letter)
end

function parse_line(line)
    lower, upper = parse.(Int, split(line[1], "-"))
    letter = line[2][1]
    password = line[3]
    return (password, letter, lower, upper)
end

count_a = count(x -> x==true, [is_valid_a(x...) for x in parse_line.(eachrow(a))] )
count_b = count(x -> x==true, [is_valid_b(x...) for x in parse_line.(eachrow(a))] ) 

println("count of a: ", count_a)
println("count of b: ", count_b)
