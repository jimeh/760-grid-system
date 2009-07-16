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
  key << "\tmargin-left: " + margin.to_s + "px;\n"
  key << "\tmargin-right: " + margin.to_s + "px;\n"
  for i in 1..cells
    val = ".container_" + cells.to_s + " .grid_" + i.to_s
    classes[key] = [] if !classes.has_key?(key)
    classes[key].push(val)
  end

  # alpha / omega
  key = "\tmargin-left: 0;\n"
  val = ".alpha"
  classes[key] = [] if !classes.has_key?(key)
  classes[key].push(val)
  key = "\tmargin-right: 0;\n"
  val = ".omega"
  classes[key] = [] if !classes.has_key?(key)
  classes[key].push(val)
  
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
  
end

# clear
key  = "\tclear: both;\n"
key << "\tdisplay: block;\n"
key << "\toverflow: hidden;\n"
key << "\tvisibility: hidden;\n"
key << "\twidth: 0;\n"
key << "\theight: 0;\n"
val  = ".clear"
classes[key] = [] if !classes.has_key?(key)
classes[key].push(val)

# clearfix
key  = "\tclear: both;\n"
key << "\tcontent: '.';\n"
key << "\tdisplay: block;\n"
key << "\tvisibility: hidden;\n"
key << "\theight: 0;\n"
val  = ".clearfix:after"
classes[key] = [] if !classes.has_key?(key)
classes[key].push(val)

key = "\tdisplay: inline-block;\n"
val = ".clearfix"
classes[key] = [] if !classes.has_key?(key)
classes[key].push(val)

key = "\theight: 1%;\n"
val = "* html .clearfix"
classes[key] = [] if !classes.has_key?(key)
classes[key].push(val)

key = "\tdisplay: block;\n"
val = ".clearfix"
classes[key] = [] if !classes.has_key?(key)
classes[key].push(val)


# generate output
output = ""
classes.sort

classes.sort{|a,b| a[0]<=>b[0]}.each do |key, value|
  output << value.uniq.join(",\n") + " {\n"
  output << key
  output << "}\n"
  output << "\n"
end

puts output
