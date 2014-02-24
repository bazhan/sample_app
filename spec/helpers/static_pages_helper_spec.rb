require 'spec_helper'
def full_title(page_title) # Определение метода
    base_title = "Ruby on Rails Tutorial Sample App"# Назначение переменной
    if page_title.empty?# Булевый тест
      base_title# Явное возвращение
    else
      "#{base_title}| #{page_title}" # Интерполяция строки
    end
  end

# Specs in this file have access to a helper object that includes
# the StaticPagesHelper. For example:
#
# describe StaticPagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe StaticPagesHelper do
  pending "add some examples to (or delete) #{__FILE__}"
end
