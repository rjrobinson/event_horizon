RSpec::Matchers.define :have_link_href do |href|
  match do |page|
    page.has_css?("a[href='#{href}']")
  end
end
