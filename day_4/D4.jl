open("input_4.txt", "r") do f
    global passports = split(read(f, String), "\n\n")
end 

function hgt_parse(hgt)
    num = hgt[1:end-2]
    unit = hgt[end - 1:end]
    if unit == "in"
        tryparse(Int, num) !== nothing && 59 <= parse(Int, num) <= 76
    elseif unit == "cm"
        tryparse(Int, num) !== nothing && 150 <= parse(Int, num) <= 193
    else 
        false
    end
end

mandatoryfields = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
rules = Dict(
    "byr" => (x -> tryparse(Int, x) !== nothing && 1920 <= parse(Int, x) <= 2002),
    "iyr" => (x -> tryparse(Int, x) !== nothing && 2010 <= parse(Int, x) <= 2020),
    "eyr" => (x -> tryparse(Int, x) !== nothing && 2020 <= parse(Int, x) <= 2030),
    "hgt" => hgt_parse,
    "hcl" => (x -> length(x) == 7 && x[1] == '#' && !occursin(r"[^0-9a-f]",x[2:end])),
    "ecl" => (x -> x in Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])),
    "pid" => (x -> tryparse(Int, x) !== nothing && length(x) == 9),
    "cid" => (x -> true)
    )

function find_keywords(passport)
    pattern = r"(\w{3}):([^ \n]+)"
    Dict([x.captures[1] => x.captures[2]  for x in eachmatch(pattern, passport)])
end

function validate_keys(key_dict, mandatoryfields)
    all([mf ∈ keys(key_dict) for mf ∈ mandatoryfields])
end

function validate_fields(key_dict, rules)
    all([rules[first(x)](last(x)) for x in collect(key_dict)])
end

validkeys = validfields  = 0
for passport in passports
    key_dict = find_keywords(passport)

    if (vk = validate_keys(key_dict, mandatoryfields))
        global validkeys += 1
        validate_fields(key_dict, rules) && global validfields += 1
    end
end

println("A - Valid: ", validkeys)
println("B - Valid: ", validfields)
