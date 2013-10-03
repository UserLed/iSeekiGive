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

end
