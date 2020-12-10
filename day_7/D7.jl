using LightGraphs
using SimpleWeightedGraphs

rules = readlines("input_7.txt")
weigths
function parse_line(line)
    split_line = split(line)
    node = join(split_line[1:2])

    if length(split_line) == 7
        return (node, [])
    end

    edges = [(join(split_line[i+1]*split_line[i+2]), String(split_line[i]))  for i = 5:4:length(split_line)]
    (node, edges)
end

wghts = zeros(Int8, length(rules), length(rules))
node_mapping = Dict()
g = SimpleDiGraph()
index = 1

for i in 1:length(rules)
    node, edges = parse_line(rules[i])

    if node ∉ keys(node_mapping)
        add_vertex!(g)
        node_mapping[node] = index
        global index += 1
    end
    
    for (edge, weigth) in edges
        if edge ∉ keys(node_mapping)
            add_vertex!(g)
            node_mapping[edge] = index
            global index += 1
        end
        global wghts[node_mapping[node], node_mapping[edge]] = parse(Int8, weigth)
        add_edge!(g, node_mapping[node], node_mapping[edge])
    end
end

shinygold = node_mapping["shinygold"]



filter(
    !=(0), 
    [length(a_star(g, node_index, shinygold)) for (node, node_index) in node_mapping]
    ) |>
   length |>
   println


function get_under_bags(index, g)
    length(outneighbors(g, index)) == 0 && return 1
    return 1 + sum([wghts[index, neigh] * get_under_bags(neigh, g) for neigh in outneighbors(g, index)])
end

println(get_under_bags(shinygold, g) - 1)
