module enums;
import std::io;

enum Color
{
    RED,
    GREEN,
    BLUE
}

enum Direction
{
    NORTH,
    SOUTH,
    EAST,
    WEST
}

fn String color_name(Color c)
{
    switch (c)
    {
        case Color.RED: return "red";
        case Color.GREEN: return "green";
        case Color.BLUE: return "blue";
    }
}

fn void main()
{
    // Enum declaration and usage
    Color c = Color.RED;
    io::printfn("color: %s", color_name(c));

    // Enum in switch
    Direction d = Direction.NORTH;
    switch (d)
    {
        case Direction.NORTH: io::printn("going north");
        case Direction.SOUTH: io::printn("going south");
        case Direction.EAST: io::printn("going east");
        case Direction.WEST: io::printn("going west");
    }

    // Enum with values
    io::printfn("color RED value: %d", (int)Color.RED);
    io::printfn("color GREEN value: %d", (int)Color.GREEN);
    io::printfn("color BLUE value: %d", (int)Color.BLUE);
}
