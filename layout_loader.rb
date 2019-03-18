require 'nokogiri'

# opens both the layout and wrapper
# parses the layout
# applies the template
def generate_page(layout_name, template_name)
  layout = File.open(layout_name) { |f| Nokogiri::XML(f) }
  template = File.open(template_name) { |f| Nokogiri::HTML(f) }

  parse_layout(layout)

  apply_template(template, layout)
end

# applies the template file
# (with header info and general HTML stuff)
# to the HTML generated from the layout
# looks for a div with the id of "streamControlContent"
def apply_template(outer, inner)
  outer.at_xpath("//div[@id='streamControlContent']").replace(inner.root.children)
  outer
end

# parses all of each recognized node
def parse_layout(doc)
  parse_all(doc, "//text") { |e| parse_text doc, e }
  parse_all(doc, "//label") { |e| parse_label doc, e }
  parse_all(doc, "//spinner") { |e| parse_spinner doc, e }
  parse_all(doc, "//checkbox") { |e| parse_checkbox doc, e }
end

# performs an operation on all nodes that match
def parse_all(doc, selector)
  doc.xpath(selector).each do |element|
    yield element
  end
end

# turns a label node into its HTHML counterpart
# //label
def parse_label(doc, element)
  element.name = "h3"
end

# turns a text node into its HTML counterpart
# "//text"
def parse_text(doc, element)
  parse_input(doc, element)
  element["type"] = "text"
end

# turns a spinner node into its HTML counterpart
# //spinner
def parse_spinner(doc, element)
  parse_input(doc, element)
  element["type"] = "number"
  # min / max will automatically carry through
end

# turns a checkbox node into its HTML counterpart
# //checkbox
def parse_checkbox(doc, element)
  parse_input(doc, element)
  element["type"] = "checkbox"
end

# generic code for parsing all types of inputs
def parse_input(doc, element)
  element.name = "input"

  # required
  if element["name"].nil?
    # throw error
  end

  # optional accompanying label
  unless element["label"].nil?
    if element["id"].nil?
      element["id"] = element["name"]
    end

    new_label = Nokogiri::XML::Node.new "label", doc
    new_label.content = element["label"]
    new_label["for"] = element["id"]

    element.remove_attribute("label")
    element.add_previous_sibling(new_label)
  end
end

layout_name = "test_doc.xml"
template_name = "layout_wraper.html"
puts generate_page(layout_name, template_name)
