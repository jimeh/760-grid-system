#! /usr/bin/env ruby

require "yaml"
grids = YAML.load_file("grids.yml")

classes = {}
grids.each do |grid_name, value|
  width = value["width"].to_i
  cells = value["cells"].to_i
  margin = value["margin"].to_i
  cell_size = width / cells;
  
  # containers
  key  = "\tmargin-left: auto;\n"
  key << "\tmargin-right: auto;\n"
  key << "\twidth: " + width.to_s + "px;\n"
  val  = ".container_" + cells.to_s
  classes[key] = [] if !classes.has_key?(key)
  classes[key].push(val)
  
  # global
  key  = "\tdisplay: inline;\n"
  key << "\tfloat: left;\n"
  key << "\tposition: relative;\n"
  key << "\tmargin-left: " + margin.to_s + "px;\n"
  key << "\tmargin-right: " + margin.to_s + "px;\n"
  for i in 1..cells
    val = ".container_" + cells.to_s + " .grid_" + i.to_s
    classes[key] = [] if !classes.has_key?(key)
    classes[key].push(val)
  end
  
  # grid_*
  for i in 1..cells
    key = "\twidth: " + ((cell_size * i) - (margin * 2)).to_s + "px;\n"
    val = ".container_" + cells.to_s + " .grid_" + i.to_s
      classes[key] = [] if !classes.has_key?(key)
      classes[key].push(val)
  end
  
  # prefix_*
  for i in 1..(cells-1)
    key = "\tpadding-left: " + ((cell_size) * i).to_s + "px;\n"
    val = ".container_" + cells.to_s + " .prefix_" + i.to_s
      classes[key] = [] if !classes.has_key?(key)
      classes[key].push(val)
  end
  
  # suffix_*
  for i in 1..(cells-1)
    key = "\tpadding-right: " + ((cell_size) * i).to_s + "px;\n"
    val = ".container_" + cells.to_s + " .suffix_" + i.to_s
      classes[key] = [] if !classes.has_key?(key)
      classes[key].push(val)
  end
  
  # push_*
  for i in 1..(cells-1)
    key = "\tleft: " + ((cell_size) * i).to_s + "px;\n"
    val = ".container_" + cells.to_s + " .push_" + i.to_s
      classes[key] = [] if !classes.has_key?(key)
      classes[key].push(val)
  end
  
  # pull_*
  for i in 1..(cells-1)
    key = "\tleft: -" + ((cell_size) * i).to_s + "px;\n"
    val = ".container_" + cells.to_s + " .pull_" + i.to_s
      classes[key] = [] if !classes.has_key?(key)
      classes[key].push(val)
  end
  
end



# generate output
output = <<-HTML

/*
  760 Grid System ~ For Facebook Applications.
  -- Based on the 960 Grid System ~ http://960.gs/
 
  Licensed under MIT.
*/

/* `Grid >> Children (Alpha ~ First, Omega ~ Last)
----------------------------------------------------------------------------------------------------*/

.alpha {
  margin-left: 0;
}
 
.omega {
  margin-right: 0;
}

/* `Containers & Grids
----------------------------------------------------------------------------------------------------*/

HTML

classes.sort{|a,b| a[1]<=>b[1]}.each do |key, value|
  output << value.uniq.join(",\n") + " {\n"
  output << key
  output << "}\n"
  output << "\n"
end

output << <<-HTML
/* `Clear Floated Elements
----------------------------------------------------------------------------------------------------*/
 
/* http://sonspring.com/journal/clearing-floats */
 
.clear {
  clear: both;
  display: block;
  overflow: hidden;
  visibility: hidden;
  width: 0;
  height: 0;
}
 
/* http://perishablepress.com/press/2008/02/05/lessons-learned-concerning-the-clearfix-css-hack */
 
.clearfix:after {
  clear: both;
  content: ' ';
  display: block;
  font-size: 0;
  line-height: 0;
  visibility: hidden;
  width: 0;
  height: 0;
}
 
.clearfix {
  display: inline-block;
}
 
* html .clearfix {
  height: 1%;
}
 
.clearfix {
  display: block;
}
HTML

puts output
