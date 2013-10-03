module ApplicationHelper

  def total_experience(user)
    total_time = 0
    
    user.experiences.each do |e|
      if e.start_date.present?
        from_time = e.start_date.to_time
        to_time = (e.end_date or Date.today).to_time
        distance_in_seconds = ((to_time - from_time).abs).round
        total_time = distance_in_seconds + total_time
      end
    end

    components = []

    %w(year month).each do |interval|
      if total_time >= 1.send(interval)
        delta = (total_time / 1.send(interval)).floor
        total_time -= delta.send(interval)
        components << pluralize(delta, interval)
      end
    end
    components.join(" ")
  end

  def new_total_exp(user)
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
