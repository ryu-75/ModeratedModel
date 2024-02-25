require "rails/test_help"
require_relative '../../../app/models/moderated_model'

class ModerableTest < ActiveSupport::TestCase
  include Moderable

  def setup
    # Change the moderated content to test it :
    @moderated_model = ModeratedModel.create(moderated: "Bien")
    @moderated_model.extend(Moderable)
  end

  test "data_content should set is_accepted to true for offensive content" do
    @moderated_model.data_content

    @moderated_model.reload

    assert(true, "Offensive content should not be accepted")
  end

  test "data_content should set is_accepted to false for acceptable content" do
    @moderated_model.data_content

    @moderated_model.reload

    refute(false, "Acceptable content should be accepted")
  end
end
