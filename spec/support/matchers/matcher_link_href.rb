RSpec::Matchers.define :have_link_href do |href|
  match do |page|
    actual.has_css?("a[href='#{href}']")
  end
end
