function partition_string(string)
    lower = 0 ; upper = 2^(length(string)) - 1
    for c in string
        if c == 'B' || c == 'R'
            lower = cld(upper + lower, 2)
        else
            upper = fld(upper + lower, 2)
        end
    end ; upper == lower || error()
    lower
end

seatID(s) = 8 * partition_string(s[1:7]) + partition_string(s[8:end])

seatIDs = seatID.(readlines("input_5.txt"))

@show max(seatIDs...)

seatIDs = sort(seatIDs)
for id in seatIDs[2]:seatIDs[end-1]
    id ∉ seatIDs && println(id)
end