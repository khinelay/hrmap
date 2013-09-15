module ActiveAdmin::ViewsHelper
  def ancestry_options(items, &block)
    return ancestry_options(items){|i| "#{a = i.ancestors.collect{|a| a.name}; a.join(" / ") + " / " if a.any?} #{i.name}" } unless block_given?

    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      result += ancestry_options(sub_items, &block)
    end
    result
  end

  def department_ancestry_links(department)
    department.ancestors.collect{|a| link_to a.name, [:admin, a]}.join(" / ").html_safe
  end

  def department_employees_count(count)
    if count == 0
      "<span class=\"no-employees\">#{pluralize(count, "employee")}</span>".html_safe
    else
      pluralize(count, "employee")
    end
  end
end
