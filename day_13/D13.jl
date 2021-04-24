file = readlines("input_13.txt")

timestamp = parse(Int, file[1])
busses =  split(file[2],",")



function part1(timestamp, buss_list)
    busses = map(x->parse(Int,x), (filter(!=("x"), buss_list)))

    buss_diff = [cld(timestamp, bus)*bus - timestamp for bus in busses]

    min_diff, indx = findmin(buss_diff)

    @show min_diff * busses[indx]

end

part1(timestamp, busses)


function part2(busses)
    i = 1
    while true
        t = busses[1] * i

        i % 1000000 == 0 && println(i, "  ", t)
        all_true = true
        for (j, bus) in enumerate(busses)
            if bus != "x"
                if (cld(t, bus) * bus) - t != j-1
                    all_true = false
                    break
            end end
        end

        if all_true
            println("Wohoo $i is correct at time $t")
            return
        end
        i += 1
    end

end

new_bus = []
for b in busses
    if b != "x"
        push!(new_bus, parse(Int, b))
    else
        push!(new_bus, b)
    end
end
part2(new_bus)