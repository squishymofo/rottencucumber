module ApplicationHelper
  def concise_dist(time)

    str = distance_of_time_in_words(Time.now - time).split(/about /)
    if str.size > 1
      str = str[1]
    else
      str = str[0]
      unless str.scan("less").empty?
        return "0 m"
      end
    end
    str.gsub("hours", "h").gsub("hour", "h").gsub("minutes", "m").gsub("minute", "m").gsub("days", "d").gsub("day", "d").gsub("weeks", "w").gsub("week", "w").gsub("months", "mo").gsub("month", "mo")

  end

end
