module ApplicationHelper

  def total_experience(user)
    exp_arr = []
    user_exps = user.experiences.collect{|x| [x.start_date, (x.end_date || Date.today)]}.sort
    tmp_arr = []
    user_exps.each do |exp|
      custom_range = Range.new(exp.first, exp.last)
      custom_range.each do |r|
        tmp_arr <<  r.strftime("%Y%m")
        tmp_arr.uniq
        exp_arr << tmp_arr
        tmp_arr = []
      end
    end
    months = exp_arr.flatten.uniq.count
    year = months/12
    month = months%12
    "#{pluralize(year, "year")} #{pluralize(month, "month")}" 
  end


  NAV = {
    "account" => [{:controller => "accounts", :action => "settings"}]
  }


  def nav_link(link_text, link_path, link_array = [])
    class_name = 'active' if current_page?(link_path)

    link_array.each do |link|
      class_name = 'active' if match_controller_action?(link)
    end

    content_tag(:li, :class => class_name) do
      if block_given?
        yield
      else
        link_to link_text, link_path
      end
    end
  end

  def match_controller_action?(link)
    params[:controller] == link[:controller] and params[:action] == link[:action]
  end

end
