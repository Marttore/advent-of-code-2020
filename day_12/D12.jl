
cardinal_directions = ['W', 'N', 'E', 'S']

mutable struct Ship
    x::Integer
    y::Integer
    curr_dir::Char
end

struct Move
    dir::Char
    magnitude::Integer
end

mutable struct Waypoint
    move_NS :: Move
    move_EW :: Move
end

function manhattan_distance(ship::Ship)
    abs(ship.x) + abs(ship.y)
end

function move_ship!(ship::Ship, move::Move)
    d = move.dir

    if d == 'F'
        d = ship.curr_dir
    end

    if d == 'N'
        ship.y += move.magnitude
    elseif d == 'S'
        ship.y -= move.magnitude
    elseif d == 'E'
        ship.x += move.magnitude
    elseif d == 'W'
        ship.x -= move.magnitude
    elseif d == 'R' || d == 'L'
        ind = findfirst(==(ship.curr_dir), cardinal_directions)
        val_turn = move.magnitude ÷ 90
        ship.curr_dir = cardinal_directions[mod1(ind + val_turn*(d=='R' ? 1 : -1), 4)]
    end
end

function move_waypoint!(waypoint::Waypoint, move::Move)
    d = move.dir

    if d == 'N' ||  d == 'S'
        NS = waypoint.move_NS.dir == 'N' ? waypoint.move_NS.magnitude : -waypoint.move_NS.magnitude
        new_NS = NS + (d == 'N' ? move.magnitude : -move.magnitude)
        waypoint.move_NS = Move( new_NS>=0 ? 'N' : 'S' , abs(new_NS))
    elseif d == 'E' || d == 'W'
        EW = waypoint.move_EW.dir == 'E' ? waypoint.move_EW.magnitude : -waypoint.move_EW.magnitude
        new_EW = EW + (d == 'E' ? move.magnitude : -move.magnitude)
        waypoint.move_EW = Move( new_EW>=0 ? 'E' : 'W' , abs(new_EW))
    elseif d == 'R' || d == 'L'
        val_turn = move.magnitude ÷ 90

        ind_NS = findfirst(==(waypoint.move_NS.dir), cardinal_directions)
        ind_EW = findfirst(==(waypoint.move_EW.dir), cardinal_directions)

        new_NS = Move(cardinal_directions[mod1(ind_NS + val_turn*(d=='R' ? 1 : -1), 4)], waypoint.move_NS.magnitude)
        new_EW = Move(cardinal_directions[mod1(ind_EW + val_turn*(d=='R' ? 1 : -1), 4)], waypoint.move_EW.magnitude)

        if new_NS.dir =='N' || new_NS.dir =='S'
            waypoint.move_NS = new_NS
            waypoint.move_EW = new_EW
        else
            waypoint.move_NS = new_EW
            waypoint.move_EW = new_NS
        end
    end
end



function part1(input)
    moves = [Move(dir[1], parse(Int, dir[2:end])) for dir in readlines(input)]
    ship = Ship(0,0,'E')
    for move in moves
        move_ship!(ship, move)
    end
    manhattan_distance(ship)
end

function part2(input)
    moves = [Move(dir[1], parse(Int, dir[2:end])) for dir in readlines(input)]
    ship = Ship(0,0,'E')
    waypoint = Waypoint(Move('N', 1), Move('E', 10), )

    for move in moves
        if move.dir == 'F'
            for i in 1:move.magnitude
                move_ship!(ship, waypoint.move_NS)
                move_ship!(ship, waypoint.move_EW)
            end
        else
            move_waypoint!(waypoint, move)
        end
    end

    manhattan_distance(ship)

end

inp = "input_12.txt"

@show part1(inp)
@show part2(inp)