module ApplicationHelper

  def total_experience(user)
    total_time = 0
    user.experiences.each do |e|
      from_time = e.start_date.to_time
      to_time = (e.end_date or Date.today).to_time
      distance_in_seconds = ((to_time - from_time).abs).round
      total_time = distance_in_seconds + total_time
    end

    components = []

    %w(year month).each do |interval|

      if total_time >= 1.send(interval)
        delta = (total_time / 1.send(interval)).floor
        total_time -= delta.send(interval)
        components << pluralize(delta, interval)
      end
    end
    components.join(", ")
  end
end
