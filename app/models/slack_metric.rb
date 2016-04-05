class SlackMetric < ActiveRecord::Base
  belongs_to :project
  has_many :slack_data_points
  
  def get_data
    client = Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN'])
    users = client.users_list.members
    user_contributions = {}
    users.each do |user|
      unless user.name == "slackbot"
        num_messages = client.search_all(query: "from:@#{user.name}").messages.total
        slack_data_point = self.slack_data_points.find_by user: user.name
        unless slack_data_point
          self.slack_data_points.create(user: user.name, messages: num_messages)
        else
          slack_data_point.update_attributes(:messages => num_messages)
        end
      end
    end
    
    return user_contributions
  end
end
