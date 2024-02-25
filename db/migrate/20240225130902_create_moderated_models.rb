class CreateModeratedModels < ActiveRecord::Migration[7.1]
  def change
    create_table :moderated_models do |t|
      t.string :moderated
      t.boolean :is_accepted

      t.timestamps
    end
  end
end
