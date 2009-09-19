# 760 Grid System

Being an avid lover the [960 Grid System][1], I decided to make a 760 pixel wide version when I started working with Facebook applications.

It was instantly obvious it would be easier creating a generator for the grid system. The first version was written in PHP, and took less than an hour to create. I've now replaced it with a Ruby version, which technically creates identical output, only it's configured with a YAML file.

## Grid Usage

760 works exactly the same way as [960.gs][1]. The only difference is that instead of 12 and 16 columns, 760.gs has 20, 38, and 76 column layouts, and due to how thin the columns are, they don't have any margins by default.

## Generator Usage

The generator is an easy to use shell script. Just edit grids.yml to your needs, and run:

    ./generate-grid.rb > new_grids.css

## Notes

* By default columns don't have any margins, cause the columns are already __very__ thin. But you can use `760.margin.css` which has a 5 pixel margin. Or you could just generate your own new grid css with custom margins.
* Any suggestions are greatly appreciated.

## Legal

* Released under MIT license, of course.
* Included Eric Meyer's comprehensive browser [reset stylesheet][2], which [960.gs][1] also uses.
* I stole the `text.css` file from [960.gs][1], I hope nobody minds :)

[1]: http://960.gs/
[2]: http://meyerweb.com/eric/tools/css/reset/