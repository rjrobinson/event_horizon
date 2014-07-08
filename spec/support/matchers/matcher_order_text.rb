RSpec::Matchers.define :order_text do |first, second|
  match do |page|
    page.text.index(first) < page.text.index(second)
  end

  failure_message do
    "\"#{first}\" does not appear before \"#{second}\""
  end
end
