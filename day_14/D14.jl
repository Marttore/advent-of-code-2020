
function part1()
  instructions = readlines("input_14.txt")
    
  address_space = Dict{String, Int}()

  mask = ""

  for line in instructions
      instruction, value = split(line, " = ")


      if instruction == "mask"
        mask = value
      else
        address =  first(match(r"\[(\d+)\]", instruction).captures)
        bit_value = reverse(string.(digits(parse(Int, value), base=2, pad=36)))

        for (i, bit) in enumerate(mask)
          if bit == 'X' continue end
          bit_value[i] = string(bit)
        end

        address_space[address] = parse(Int, reduce(*, bit_value), base=2)

      end
  end
  println(address_space)
  println(sum(values(address_space)))
end


function part2()
  instructions = readlines("input_14.txt")
    
  address_space = Dict{String, Int}()

  mask = ""

  for line in instructions
      instruction, value = split(line, " = ")


      if instruction == "mask"
        mask = value
      else
        address =  first(match(r"\[(\d+)\]", instruction).captures)
        bit_address = digits(parse(Int, address), base=2, pad=36) |> reverse

        for (i, bit) in enumerate(mask)
          if bit == '0' continue end
          println(i, bit)
          bit_address[i] = string(bit)
        end
        

        for add in get_addresses(reduce(*, bit_address))
          address_space[add] = parse(Int, value)
        end
      end
  end
  #println(address_space)
  println(sum(values(address_space)))
end


function get_addresses(addd)
  idx = findfirst("X", addd)

  if idx != nothing
    idx = first(idx)
    return vcat(
      get_addresses(addd[1:idx-1] * "0" * addd[idx+1:end]),
      get_addresses(addd[1:idx-1] * "1" * addd[idx+1:end]),
    )
  end

  return addd
end
part1()