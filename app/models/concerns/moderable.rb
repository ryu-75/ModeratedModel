require 'httparty'
require_relative '../../../config/environment'

module Moderable
  extend ActiveSupport::Concern

  def data_content
    ModeratedModel.all.each do |moderate|
      res = moderation_prediction(moderate.moderated)
      moderate.is_accepted = !res
      puts
      puts "ID: #{moderate.id}"
      puts "Moderated content: #{moderate.moderated}"
      puts "Is accepted: #{moderate.is_accepted}"
      puts "-----------------------------"
      moderate.save
    end
  end

  def moderation_prediction(content)
    response = HTTParty.get("https://moderation.logora.fr/predict?text=#{content}", body: { text: content }.to_json, headers: { 'Content-Type' => 'application/json' })
    result = JSON.parse(response.body)
    prediction_value = result["prediction"]["0"].to_f
    puts "Result: #{prediction_value}"
    if prediction_value > 0.9
      return false
    else
      return true
    end
  end
end
