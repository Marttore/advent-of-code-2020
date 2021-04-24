input = readlines("input_11.txt")

mapping = Dict('.' => 0, 'L' => 1, '#' =>2)



plan_raw = [[mapping[x] for x in inp] for inp in input]

h = length(plan_raw); w=length(plan_raw[1])

plan = Matrix{Int8}(undef, h, w)

for x in 1:h, y in 1:w
    plan[x, y] = plan_raw[x][y]
end

neighbors(i,j, heigth, width) = [(x,y) for x in i-1:i+1, y in j-1:j+1  if 1<=x<=heigth && 1<=y<=width && !(x==i && y==j)]

function sight(i, j, h, w, plan)

    neighs = []

    dirs = [(i, j) for i = -1:1, j=-1:1 if (i!=0 || j!=0)]

    
    for dir in dirs
        x = i; y = j
        while true
            x, y = (x, y) .+ dir

            1 <= x <= h && 1 <= y <= w || break

            if plan[x, y] != 0
                push!(neighs, (x,y))
                break
            end
        end
    end
    neighs
end


function iterate(plan)
   new_plan = deepcopy(plan)
   for i in 1:h, j in 1:w
        neighs = neighbors(i, j, h, w)
        if plan[i, j] == 1
            if count(==(2), [plan[x, y] for (x,y) in neighs]) == 0
                new_plan[i, j]  = 2
            end
        elseif plan[i, j] == 2
            if count(==(2), [plan[x, y] for (x,y) in neighs]) >= 4
                new_plan[i, j]  = 1
            end
        end
    end
    new_plan
end

plan_c =  deepcopy(plan)
while true
    new_plan = iterate(plan_c)
    new_plan == plan_c && break
    global plan_c = new_plan
end

println(plan_c)
@show count(==(2), plan_c)


function iterate_sight(plan)
    new_plan = deepcopy(plan)
    for i in 1:h, j in 1:w
         neighs = sight(i, j, h, w, plan)
         if plan[i, j] == 1
             if count(==(2), [plan[x, y] for (x,y) in neighs]) == 0
                 new_plan[i, j]  = 2
             end
         elseif plan[i, j] == 2
             if count(==(2), [plan[x, y] for (x,y) in neighs]) >= 5
                 new_plan[i, j]  = 1
             end
         end
     end
     new_plan
 end
 
 
 while true
     new_plan = iterate_sight(plan)
     new_plan == plan && break
     global plan = new_plan
 end
 
 println(plan)
 @show count(==(2), plan)
 