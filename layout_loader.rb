require 'nokogiri'

def parse_layout_file(layout_filename)
  doc = load_doc(layout_filename)
  parse_layout_doc(doc)
end

def load_doc(layout_filename)
  doc = File.open(layout_filename) { |f| Nokogiri::XML(f) }
end

def xml_to_html(element, html = "")
  ## parse this element

  element.children.each { |child| xml_to_html child }
end

