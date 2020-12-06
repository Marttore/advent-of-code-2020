open("input_6.txt", "r") do f
    cdfs = split.(split(read(f, String), "\n\n"), "\n")

    @show sum(x -> length(reduce(∪, x)), cdfs)
    @show sum(x -> length(reduce(∩, x)), cdfs)
end



