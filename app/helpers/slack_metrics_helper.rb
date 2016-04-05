module SlackMetricsHelper

  def slack_graphic(metric)
    user_contributions = metric.get_data
    total_msgs = user_contributions.values.sum
    expected_contribution = total_msgs / user_contributions.length
    user_contributions.each do |user, contribution|
      if contribution < expected_contribution
        user_contributions[user] = ((contribution.to_f / expected_contribution) * 3).ceil
      else
        user_contributions[user] = 3
      end
    end
    graph = "<div class='slack_graphic'>"
    user_contributions.each_value do |score|
      graph << slack_color_block(score)
    end
    graph << "</div>"
    return graph
  end
  
  def slack_color_block(score)
    color_hash = {0 => 'red', 1 => 'orange', 2 => 'yellow', 3 => 'green'}
    return "<div id = 'slack' style = 'background: #{color_hash[score]};'></div>"
  end
end
