using DelimitedFiles

function downhill(hill, slope)
    width = length(hill[1])

    pos = (row=1, column=1)
    global treecount = 0

    while pos.row <= length(hill)
        hill[pos.row][pos.column] == '#' && global treecount += 1
        pos = (row = pos.row + slope.Δy, column = mod1(pos.column + slope.Δx, width))
    end

    treecount
end

hill = readdlm("input_3.txt")

slopes = [
    (Δx=1, Δy=1),
    (Δx=3, Δy=1),
    (Δx=5, Δy=1),
    (Δx=7, Δy=1),
    (Δx=1, Δy=2)
    ]

println("Trees A: $(downhill(hill, slopes[2]))")
println("Trees B: ", prod([downhill(hill, slope) for slope in slopes]))


